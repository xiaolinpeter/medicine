package com.peter.shiro.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.model.Question;
import com.peter.shiro.model.Student;
import com.peter.shiro.model.User;
import com.peter.shiro.model.Ztree;
import com.peter.shiro.service.DataService;
import com.peter.shiro.service.ZtreeService;
import com.peter.shiro.service.AdminService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;


/**
 * 后台首页
 * 
 * @author xiaolin_peter
 * */

@Controller
@RequestMapping(value = "/admin")
public class adminController {

	JSONObject data = new JSONObject();



	String result = "dfsdsds";



	@Autowired
	private DataService dataService;

	@Autowired
	private  ZtreeService ztreeService;
	
	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/check/checkFile", method = RequestMethod.GET)
	// 审查文件
	public String checkFile(Model model) {
		JSONArray fileArray = new JSONArray();// 待审核
		JSONArray fileCheckFinisheArray = new JSONArray();// 审核完成
		JSONArray fileCheckFailureArray = new JSONArray();// 未审核
		fileArray = dataService.toJSONArray(
				"select * from t_file where isSubmit = ? and checkStatus = ?",
				DataStatusEnum.OK.getValue(), DataStatusEnum.NORMAL.getValue());
		fileCheckFinisheArray = dataService.toJSONArray(
				"select * from t_file where isSubmit = ? and checkStatus != ?",
				DataStatusEnum.OK.getValue(), DataStatusEnum.NORMAL.getValue());
		fileCheckFailureArray = dataService.toJSONArray(
				"select * from t_file where isSubmit = ? and checkStatus = ?",
				DataStatusEnum.OK.getValue(),
				DataStatusEnum.DISABLED.getValue());
		model.addAttribute("fileList", fileArray);
		model.addAttribute("fileFailureList", fileCheckFailureArray);
		model.addAttribute("fileFinishedList", fileCheckFinisheArray);
		return "/admin/checkFile";//kkkkll
	}

	@RequestMapping(value = "/check/adminCheck")
	// 审查文件
	@ResponseBody
	public String adminCheck(Model model, HttpServletRequest request) {
		int count = 0;
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		JSONObject data = new JSONObject();
		String result = "";
		count = dataService.getTemplate().update(
				"update t_file set checkStatus = ? where id = ?", status, id);
		if (count == 1) {
			data.put("code", "200");
		} else {
			data.put("code", "500");
		}
		result = data.toString();
		return result;
	}

	
	/**
	 * 检查用户名是否可用
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping(value = "/user/checkUsername", method = RequestMethod.GET)
	@ResponseBody
	public String checkUsername(String username) {
		if (StringUtils.isBlank(username)) {
			return BaseReturn.response(ErrorCode.PARAM_ERROR, "username不能为空");
		} else {
			return BaseReturn.response(checkName(username));
		}

	}
	
	private Boolean checkName(String username) {
		// TODO Auto-generated method stub
		Boolean flag = false;
		JSONObject json= dataService.toJSONObject("select * from t_user where username = ?", username);
		if (StringUtils.isBlank(json.optString("id"))) {
		  	flag = true;
		}
		return flag;
	}

	@RequestMapping(value = "/teacher/analyzeData")
	// 解析并导入教师上传的文件数据
	@ResponseBody
	public String analyzeData(HttpServletRequest request, HttpSession session,
			Model model) {
		String result = "";
		JSONObject json = new JSONObject();
		// 下载文件路径
		String path = session.getServletContext().getRealPath("/images/");
		String name = request.getParameter("name") + ".xls";
		String teacherId = request.getParameter("teacherId");
		String fileId = request.getParameter("fileId");
		int count = 0;
		if("student.xls".equals(name)) {
			List<Student> listExcel = adminService.getStudentExcel(path
					+ File.separator + name, teacherId, fileId);
			for (Student student: listExcel) {
				String id = student.getId();
				if (!adminService.isExistStudent(id)) {
					// 不存在就添加
					count = dataService
							.getTemplate()
							.update("insert into t_student(id, name, sex, password, email) values(?,?,?,?,?)",
									student.getId(), student.getName(),student.getSex(),
									student.getPassword(),
									student.getEmail());
				} else {
					// 存在就更新
					count = dataService
							.getTemplate()
							.update("update t_question set name = ?, sex = ?, password = ?, email = ? where id=?",
									 student.getName(),student.getSex(),
									student.getPassword(),
									student.getEmail(),student.getId());
				}
			}
			JSONArray groupArray = dataService.toJSONArray("select * from t_group order by createDate asc");
			JSONArray studentArray = dataService.toJSONArray("select * from t_student");
			int j = 0;
			for (int i = 0; i < groupArray.length(); i++) {
				JSONObject groupJson= groupArray.optJSONObject(i);
		    	String groupId= groupJson.optString("id");
		    	String groupName = groupJson.optString("name");
		    	for (int m = 0;j< studentArray.length() && m < 5; j++,m++) {
		    		int leaderFlag = 0;
		    		JSONObject studentJson = studentArray.optJSONObject(j);
			    	String studentId= studentJson.optString("id");
			    	String studentName = studentJson.optString("name");
			    	String password = studentJson.optString("password");
			    	String userId = UUIDGenerator.getUUID();
			        dataService.getTemplate().update("insert into t_user(id,username,nickname,password) value(?, ?, ?, ?)",
			    				userId, studentId, studentName, password);
		    		if(m % 5 == 0){
		    		  leaderFlag = 1;
		    		  dataService.getTemplate().update("update t_group set leaderId = ?,leaderName = ? where id = ?"
		    				  ,studentId, studentName,groupId);
		    		  dataService.getTemplate().update("insert into t_user_role(user_id, role_id) values(?,?)",userId,"3");
		    		} else{
		    		  dataService.getTemplate().update("insert into t_user_role(user_id, role_id) values(?,?)",userId,"4");
		    		}
		    		dataService.getTemplate().update("insert into t_student_group(groupId, groupName, studentId, studentName, leaderFlag) values(?, ?, ?, ?, ?)"
		    				,groupId, groupName, studentId, studentName, leaderFlag);
				}
			}
			
			
		
		}else {
			List<Question> listExcel = adminService.getAllByExcel(path
					+ File.separator + name, teacherId, fileId);
			for (Question question : listExcel) {
				String id = question.getId();
				if (!adminService.isExistQuestion(id)) {
					// 不存在就添加
					count = dataService
							.getTemplate()
							.update("insert into t_question(id, fileId, title, description, teacherId) values(?,?,?,?,?)",
									question.getId(), question.getFileId(),question.getTitle(),
									question.getDescription(),
									question.getTeacherId());
				} else {
					// 存在就更新
					count = dataService
							.getTemplate()
							.update("update t_question set teacherId = ?, fileId = ?, title = ?, description =? where id=?",
									question.getTeacherId(), question.getFileId(), question.getTitle(),
									question.getDescription(), question.getId());
				}
			}
		}
		
		if (count == 1) {
			json.put("code", "200");
		} else {
			json.put("code", "500");
		}
		result = json.toString();
		return result;
	}
	
	
	/**
	 * 分配权限的时候加载的ztree
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/role/menuZtree", method = RequestMethod.GET)
	@ResponseBody
	public String menuZtree(Model model, HttpSession session, String roleId) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser != null) {
			List<Ztree> ztree = new ArrayList<Ztree>();
			if (StringUtils.isNoneBlank(roleId)) {
				ztree = ztreeService.getMenuZtreeByRoleId(loginUser, roleId);
			} else {
				ztree = ztreeService.getMenuZtree(loginUser);
			}
		/*	logger.info("-----返回的ztree:{}-----", BaseReturn.response(ztree));*/
			return BaseReturn.response(ztree);
		} else {
			return BaseReturn.response(ErrorCode.NOT_LOGGIN);
		}
	}
	
}
