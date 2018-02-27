package com.peter.shiro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.model.User;
import com.peter.shiro.service.DataService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;

@RequestMapping(value = "/")
@Controller
public class ProblemController {
	@Autowired
	private DataService dataService;
	
	@RequestMapping(value = "/teacher/task/list")
	public String problemList(Model model) {
		JSONArray taskArray = dataService.toJSONArray("select * from t_question where status > ?", DataStatusEnum.DElETED.getValue());
		model.addAttribute("taskList", taskArray);
		return "/teacher/taskList";
	}

	@RequestMapping(value = "/teacher/task/add")
	public String problemAdd(Model model,HttpServletRequest request,HttpSession session) {
		User teacher = (User) session.getAttribute("loginUser");
		String teacherId = teacher.getId();
		String id = UUIDGenerator.getUUID();
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		dataService.getTemplate().update("insert into t_question(id, title ,description, teacherId) values(?,?,?,?)"
				, id, title, description,teacherId);
		return "redirect:/teacher/task/list";
	}
	
	@RequestMapping(value = "/teacher/task/update")
	public String problemUpdate(HttpServletRequest request) {
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		dataService.getTemplate().update("update t_question set title = ?,description = ? where id = ?"
				, title, description, id);
		return "redirect:/teacher/task/list";
	}
	
	@RequestMapping(value = "/teacher/task/delete")//单个删除
	public String problemDelete(HttpServletRequest request) {
		String id = request.getParameter("id");
		dataService.getTemplate().update("update t_question set status = ? where id = ?"
				, DataStatusEnum.DElETED.getValue(), id);
		return "redirect:/teacher/task/list";
	}
	
	@RequestMapping(value = "/teacher/task/deleteBatch")//批量删除
	@ResponseBody
	public String problemDeleteBatch(String arr) {
		String id[] = arr.split(",");
		int count = 0;
	    for (String string : id) {
	    	count = dataService.getTemplate().update("update t_question set status = ? where id = ?"
					, DataStatusEnum.DElETED.getValue(), string);
		}
		if(count > 0){
			return BaseReturn.response(ErrorCode.SUCCESS);
		}else{
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}
	
	@RequestMapping(value = "/teacher/task/handle")
	public String handle(Model model,HttpServletRequest request) {
		JSONArray taskArray = dataService.toJSONArray("select * from t_question where status > ?", DataStatusEnum.DElETED.getValue());
		model.addAttribute("taskList", taskArray);
		return "/teacher/handle";
	}
	
	@RequestMapping(value = "/teacher/task/handleTask")
	@ResponseBody
	public String handleTask(Model model,HttpServletRequest request) {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		int  count = dataService.getTemplate().update("update t_question set isRelease= ? where id = ?", status, id);
		JSONArray taskArray = dataService.toJSONArray("select * from t_question where status > ?", DataStatusEnum.DElETED.getValue());
		model.addAttribute("taskList", taskArray);
	    if(count > 0){
			return BaseReturn.response(ErrorCode.SUCCESS);
		}else{
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}
	
	@RequestMapping(value = "/teacher/task/releaseBatch")//批量发布
	@ResponseBody
	public String problemReleaseBatch(HttpServletRequest request) {
		String[] taskIdList = request.getParameterValues("taskIdList");
		int count = 0;
	    for (String string : taskIdList) {
	    	count = dataService.getTemplate().update("update t_question set isRelease = ? where id = ?"
					, DataStatusEnum.OK.getValue(), string);
		}
	    if(count > 0){
			return BaseReturn.response(ErrorCode.SUCCESS);
		}else{
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}
	
	
	@RequestMapping(value = "/teacher/task/cancelBatch")//批量取消
	@ResponseBody
	public String problemCancelBatch(HttpServletRequest request) {
		int count = 0;
		String[] taskIdList = request.getParameterValues("taskIdList");
	    for (String string : taskIdList) {
	    	count = dataService.getTemplate().update("update t_question set isRelease = ? where id = ?"
					, DataStatusEnum.NORMAL.getValue(), string);
		}
	    if(count > 0){
	 			return BaseReturn.response(ErrorCode.SUCCESS);
	 		}else{
	 			return BaseReturn.response(ErrorCode.FAILURE);
	 		}
	}
	
	
	
	@RequestMapping(value = "/teacher/updateLeader")
	public String updateLeader(Model model,HttpServletRequest request) {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		dataService.getTemplate().update("update t_user set status = ? where id = ?", status, id);
		return "redirect:/teacher/studentList";
	}
	
}
