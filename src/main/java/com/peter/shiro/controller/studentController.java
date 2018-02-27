package com.peter.shiro.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.SessionParam;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.model.User;
import com.peter.shiro.service.DataService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping(value = "/")
public class studentController {
    @Autowired 
    private DataService dataService;
    
    @RequestMapping(value = "/student/studentGroupList")//查看组员
	public String groupList(HttpSession session,Model model) {
    	if(session.getAttribute("loginUser") == null) {
    		return "redirect:/login.html";
    	}
    	User user = (User)session.getAttribute("loginUser");
    	String userName = user.getUsername();
    	
    	String groupId = dataService.toJSONObject("select groupId from  t_student_group where studentId = ?", userName).optString("groupId");
    	String groupName = dataService.toJSONObject("select groupName from  t_student_group where studentId = ?", userName).optString("groupName");
	    JSONArray groupIdArray = new JSONArray();
		JSONArray studentArray = new JSONArray();
		groupIdArray = dataService.toJSONArray("select * from t_student_group where groupId = ?", groupId);
		for (int i = 0; i < groupIdArray.length(); i++) {
			JSONObject json = groupIdArray.optJSONObject(i);
			String studentId = json.optString("studentId");
			JSONObject student = dataService.toJSONObject("select * from t_user where username = ?", studentId);
			json.put("id", student.optString("id"));
			studentArray.put(json);
		}
		
		/*//判断该学生是否为组长
	    int flag = 0;
		JSONArray leaderArray = dataService.toJSONArray("select * from t_group ");
		for (int i = 0; i < leaderArray.length(); i++) {
			String leaderId = leaderArray.optJSONObject(i).optString("leaderId");
			if(leaderId.equals(userName)) {
				flag = 1;
				break;
			}
		}*/
		model.addAttribute("groupName",groupName);
		model.addAttribute("studentList", studentArray);
		return "/student/studentGroupList";
	}
    
    
    @RequestMapping(value = "/student/answer")//抢答
    @ResponseBody
   	public String Answer(HttpServletRequest request,HttpSession session) {
    	//首先判断抢答的人是否为组长，如果是组长允许抢答，否则看studentFlag的值，如果studentFlag为1表示组长已经为该组员授权了，改组员也就有抢塔的权利
    	//step1 判断是否为组长
    	int count2 = 0;
        if(session.getAttribute("loginUser") == null){
        	return BaseReturn.response(ErrorCode.FAILURE);
    	}else{
    		User user = (User)session.getAttribute("loginUser");
    		String userId = user.getId();
    		JSONObject studentJson= new JSONObject();
    		studentJson= dataService.toJSONObject("select * from t_user where id = ?", userId);
    		String username = studentJson.optString("username");
    	    JSONObject  studentGroup= dataService.toJSONObject("select * from t_student_group where studentId = ?", username);
    	    int leaderFlag = studentGroup.optInt("leaderFlag");
    	    int studentFlag = studentGroup.optInt("studentFlag");
    	    Date  answerDate = new Date();
    	    if(leaderFlag ==1 || studentFlag == 1){
            	String problemId = request.getParameter("id");
            	String studentId =  studentGroup.optString("studentId");
            	String studentName = studentGroup.optString("studentName");
            	String groupId = studentGroup.optString("groupId");
            	String groupName= studentGroup.optString("groupName");
            	int status = 1;
            	int count1 = dataService.getTemplate().update("insert into t_answer(problemId, studentId, studentName, groupId, groupName, status) values(?, ?, ?, ?, ?, ?)",problemId, studentId, studentName, groupId, groupName, status);
            	dataService.getTemplate().update("update t_group set answerDate = ? where id = ?",answerDate, groupId);
            	if (count1 == 1) {
        			count2 = dataService.getTemplate().update("update t_question set isAnswer = ? where id = ?", DataStatusEnum.OK.getValue(), problemId);
        			dataService.getTemplate().update("update t_group set getStatus = ? where id = ?", DataStatusEnum.OK.getValue(), groupId);
            	}
            	if (count2 == 1) {
            		return BaseReturn.response(ErrorCode.SUCCESS);
        		}else {
        			return BaseReturn.response(ErrorCode.FAILURE);
        		}
    	    }else{
    	    	return BaseReturn.response(ErrorCode.FAILURE);
    	    }
    	}
   	}
    
    
    @RequestMapping(value = "/student/leaderPower")//组长授权 
    @ResponseBody
   	public String leaderPower(HttpServletRequest request, HttpSession session) {
    	int count2 = 0;
    	String studentId = request.getParameter("studentId");
    	String status = request.getParameter("status");
    	//首先判断该授权用户是否为组长，不是组长不能授权给别人
    	JSONObject student = new JSONObject();
    	User user = (User) session.getAttribute(SessionParam.LOGIN_USER);
    	String userId = user.getUsername();
    	student = dataService.toJSONObject("select * from t_student_group where studentId = ?", userId);
    	int leaderFlag = student.optInt("leaderFlag");
    	if (leaderFlag == 1) {
    		 count2 = dataService.getTemplate().update("update t_student_group set studentFlag = ? where studentId = ?", status, studentId);
    	    	if (count2 == 1) {
    			  return BaseReturn.response(ErrorCode.SUCCESS);
    			}else {
    			  return BaseReturn.response(ErrorCode.FAILURE);
    			}
		}else{
			  return BaseReturn.response(ErrorCode.FAILURE);
		}
   	}
    
    
    @RequestMapping(value = "/student/applyPower")//组员申请抢答权 
    @ResponseBody
   	public String applyPower(HttpServletRequest request, HttpSession session) {
    	int count2 = 0;
    	String studentId = request.getParameter("studentId");
    	String status = request.getParameter("status");
    	//首先判断该授权用户是否为组长，不是组长不能授权给别人
		count2 = dataService.getTemplate().update("update t_student_group set isFlag = ? where studentId = ?", status, studentId);
    	if (count2 == 1) {
		  return BaseReturn.response(ErrorCode.SUCCESS);
		}else {
		  return BaseReturn.response(ErrorCode.FAILURE);
		}
   	}
    
    
    @RequestMapping(value = "/student/groupProject")//小组题目
   	public String groupProject(HttpServletRequest request,HttpSession session,Model model) {
    	int flag = 0;
    	String answer = "";
    	String submitUserId= "";
    	String submitUserName= "";
    	if (session.getAttribute("loginUser") == null) {
    		return "";
		}else {
			User user = (User) session.getAttribute("loginUser");
			String userId = user.getId();
			JSONObject student = new JSONObject();
			student = dataService.toJSONObject("select * from t_user where id = ?",userId);
			String studentId = student.optString("username");
			String groupId =   dataService.toJSONObject("select * from t_student_group where studentId = ?", studentId).optString("groupId");
		    String problemId = dataService.toJSONObject("select * from t_answer where groupId= ?", groupId).optString("problemId");
		    JSONObject problem = dataService.toJSONObject("select * from t_question where id = ?", problemId);
		    JSONObject submit = dataService.toJSONObject("select * from t_submit where problemId = ?", problemId);
		    if(submit.length() > 0){
		    	flag = 1;
		    	//查看提交人信息
		    	answer = submit.optString("answer");
		    	submitUserId = submit.optString("studentId");
		    	submitUserName = submit.optString("studentName");
		    }
			problem.put("flag", flag);
			problem.put("answer", answer);
			problem.put("submitUserId", submitUserId);
			problem.put("submitUserName", submitUserName);
			problem.put("flag", flag);
		    model.addAttribute("task",problem);
		    return "/student/groupProject";
		}
   	}
    
    @RequestMapping(value = "/student/groupAnswer")
   	public String groupAnswer(HttpServletRequest request,HttpSession session,Model model) {
		    String problemId = request.getParameter("problemId");
		    JSONObject problem = dataService.toJSONObject("select * from t_question where id = ?", problemId);
		    model.addAttribute("problem",problem);
		    return "/student/groupAnswer";	
   	}
    
    @RequestMapping(value = "/student/groupSubmit")
   	public String groupSubmit(HttpServletRequest request,HttpSession session,Model model) throws ParseException {
    	if (session.getAttribute("loginUser") == null) {
    		 return "redirect:/student/taskList";	
		}else {
			User user = (User) session.getAttribute("loginUser");	
			Date submitDate = new Date();
			String studentId = user.getUsername();
			String studentName = user.getNickname();
			String answer = request.getParameter("answer");
			JSONObject group = dataService.toJSONObject("select * from t_student_group where studentId = ? ", studentId);
			String groupId = group.optString("groupId");
			JSONObject reallyGroup = dataService.toJSONObject("select * from t_group where id = ? ", groupId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date answerDate = df.parse(reallyGroup.optString("answerDate"));
			String groupName = group.optString("groupName");
		    String problemId = request.getParameter("problemId");
		    String id = UUIDGenerator.getUUID();
		    int count = dataService.getTemplate().update("insert into t_submit(id, studentId, studentName, groupId, groupName, problemId, answer) values(?, ?, ?, ?, ?, ?, ?)", id, studentId, studentName, groupId, groupName, problemId, answer);
		    if(count > 0){
		    	dataService.getTemplate().update("update t_answer set submitFlag = ? where problemId = ?", DataStatusEnum.OK.getValue(), problemId);
		    	 long time = submitDate.getTime() - answerDate.getTime();
		    	 dataService.getTemplate().update("update t_group set submitDate= ?, time = ? where id= ?", submitDate, time, groupId);
		       
		    }
		    return "redirect:/student/taskList";	
		}
    	    
   	}
    
    @RequestMapping(value = "/student/taskList")
	public String studentTaskList(Model model,HttpServletRequest request) {
		JSONArray taskArray = dataService.toJSONArray("select * from t_question where isRelease > ?", DataStatusEnum.NORMAL.getValue());
		model.addAttribute("taskList", taskArray);
		return "/student/taskList";
	}
    
}   



