package com.peter.shiro.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.model.User;
import com.peter.shiro.model.Ztree;
import com.peter.shiro.service.DataService;
import com.peter.shiro.service.ZtreeService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/")
public class teacherController {
	@Autowired
	private DataService dataService;

	@Autowired
	private ZtreeService ztreeService;

	@RequestMapping(value = "/teacher/group/list")
	// 查看分组
	public String groupList(Model model) {
		JSONArray groupArray = dataService.toJSONArray(
				"select * from t_group where status >?",
				DataStatusEnum.DElETED.getValue());
		JSONArray groupStudentArray = new JSONArray();
		for (int i = 0; i < groupArray.length(); i++) {
			JSONObject groupJson = groupArray.optJSONObject(i);
			String id = groupJson.optString("id");
			JSONArray studentArray = dataService.toJSONArray(
					"select * from t_student_group where groupId = ?", id);
			groupJson.put("studentList", studentArray);
			groupStudentArray.put(groupJson);
		}
		model.addAttribute("groupList", groupStudentArray);
		return "/teacher/groupList";
	}

	@RequestMapping(value = "/teacher/group/add")
	public String groupAdd(Model model, HttpServletRequest request) {
		String id = UUIDGenerator.getUUID();
		String name = request.getParameter("name");
		dataService.getTemplate().update(
				"insert into t_group(id, name) values(?,?)", id, name);
		return "redirect:/teacher/group/list";
	}

	@RequestMapping(value = "/teacher/group/update")
	public String groupUpdate(HttpServletRequest request) {
		String id = request.getParameter("groupId");
		String groupName = request.getParameter("groupName");
		dataService.getTemplate().update(
				"update t_group set name = ? where id = ?", groupName, id);
		dataService.getTemplate().update(
				"update t_student_group set groupName = ? where groupId = ?",
				groupName, id);
		return "redirect:/teacher/group/list";
	}

	@RequestMapping(value = "/teacher/group/delete")
	// 单个删除
	public String problemDelete(HttpServletRequest request) {
		String id = request.getParameter("id");
		dataService.getTemplate().update(
				"update t_group set status = ? where id = ?",
				DataStatusEnum.DElETED.getValue(), id);
		return "redirect:/teacher/group/list";
	}

	@RequestMapping(value = "/teacher/allocate")
	@ResponseBody
	public String allocate(HttpServletRequest request) {
		Date allocateDate = new Date();
		String groupId = request.getParameter("groupId");
		String problemId = request.getParameter("questionId");
		JSONObject group = dataService.toJSONObject(
				"select * from t_group where id = ?", groupId);
		String groupName = group.optString("name");
		String studentName = group.optString("leaderName");
		String studentId = group.optString("leaderId");
		dataService.getTemplate().update(
				"delete from t_answer where groupId = ?", groupId);
		int count1 = dataService
				.getTemplate()
				.update("insert into t_answer(problemId, studentId, studentName, groupId, groupName) values(?, ?, ?, ?, ?)",
						problemId, studentId, studentName, groupId, groupName);
		dataService.getTemplate().update(
				"update t_group set answerDate = ? where id = ?", allocateDate,
				groupId);
		/*
		 * int count3 = 0; if (count1 == 1) { count3 =
		 * dataService.getTemplate().
		 * update("update t_group set getStatus = ? where id = ?",
		 * DataStatusEnum.OK.getValue(), groupId); }
		 */
		if (count1 > 0) {
			return BaseReturn.response(ErrorCode.SUCCESS);
		} else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}

	@RequestMapping(value = "/teacher/group/allocateLeader")
	// 设置组长
	@ResponseBody
	public String allocateLeader(HttpServletRequest request) {
		String groupId = request.getParameter("groupId");
		String leaderId = request.getParameter("studentId");
		JSONObject user = dataService.toJSONObject(
				"select * from t_user where username = ?", leaderId);
		String userId = user.optString("id");
		String leaderName = user.optString("nickname");
		int count4 = 0;
		// 更新这个组的原组长信息
		JSONObject group = dataService.toJSONObject(
				"select * from t_group where id = ?", groupId);
		String originUsername = group.optString("leaderId");
		JSONObject originUser = dataService.toJSONObject(
				"select * from t_user where username = ?", originUsername);
		String originUserId = originUser.optString("id");
		int count0 = dataService.getTemplate().update(
				"update  t_user_role  set role_id = ? where user_id = ?", "4",
				originUserId);

		int count5 = dataService
				.getTemplate()
				.update("update t_student_group set leaderFlag  = ? where studentId = ?",
						DataStatusEnum.NORMAL.getValue(),
						group.optString("leaderId"));

		if (count0 > 0 && count5 > 0) {
			int count1 = dataService
					.getTemplate()
					.update("update t_group set leaderId = ?, leaderName = ? where id = ?",
							leaderId, leaderName, groupId);
			if (count1 > 0) {
				int count3 = dataService
						.getTemplate()
						.update("update  t_user_role  set role_id = ? where user_id = ?",
								"3", userId);
				if (count3 > 0) {
					count4 = dataService
							.getTemplate()
							.update("update t_student_group set leaderFlag  = ? where studentId = ?",
									DataStatusEnum.OK.getValue(), leaderId);
				}
			}
		}
		if (count4 > 0) {
			return BaseReturn.response(ErrorCode.SUCCESS);
		} else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}

	@RequestMapping(value = "/teacher/power")
	public String power(HttpServletRequest request, HttpSession session,
			Model model) {
		/*
		 * String studentId = request.getParameter("studentId"); User user =
		 * (User) session.getAttribute("loginUser"); String userId =
		 * user.getId(); JSONArray powerArray = new JSONArray(); powerArray =
		 * dataService.toJSONArray( "select e.* from t_user a " +
		 * "LEFT JOIN t_user_role  b on a.id = b.user_id " +
		 * "LEFT JOIN t_role c on b.role_id = c.id " +
		 * "LEFT JOIN t_role_resource d on c.id = d.role_id " +
		 * "LEFT JOIN t_resource e on d.resource_id = e.id " +
		 * " WHERE a.id = ?  order by e.rank asc", userId);
		 * model.addAttribute("powerList", powerArray);
		 * model.addAttribute("studentId", studentId);
		 */
		return "/teacher/reallyPower";
	}

	@RequestMapping(value = "/teacher/teacherPower")
	// 教师授权给学生 第三方授权
	@ResponseBody
	public String teacherPower(HttpServletRequest request, String resourceIds,
			HttpSession session, Model model) {
		int count3 = 0;
		String id = request.getParameter("id");
		String[] powerIdList = resourceIds.split(",");
		User user = (User) session.getAttribute("loginUser");
		String userId = user.getId();
		JSONObject role = dataService
				.toJSONObject(
						"select c.* from t_user a left join t_user_role b on a.id = b.user_id "
								+ "left join t_role c on b.role_id = c.id where a.id = ?",
						userId);
		if (!"2".equals(role.optString("id"))) { // 首先判断是否为教师角色，不是的话否则不许授权
			return BaseReturn.response(ErrorCode.FAILURE);
		} else {
			if (powerIdList.length > 0) {
				String roleId = UUIDGenerator.getUUID();
				String roleName = "第三方";
				int count1 = dataService.getTemplate().update(
						"insert into t_role(id, name) values(?, ?)", roleId,
						roleName);
				int count2 = dataService
						.getTemplate()
						.update("insert into t_user_role(user_id, role_id) values(?,?)",
								id, roleId);
				if (count1 > 0 && count2 > 0) {
					for (String powerId : powerIdList) {
						count3 = dataService
								.getTemplate()
								.update("insert into t_role_resource(role_id, resource_id) values(?,?)",
										roleId, powerId);
					}
				}
			}
			if (count3 > 0) {
				return BaseReturn.response(ErrorCode.SUCCESS);
			} else {
				return BaseReturn.response(ErrorCode.FAILURE);
			}
		}
	}

	@RequestMapping(value = "/teacher/count")
	// 统计学生抢答结果
	public String count(Model model, HttpServletRequest request) {
		JSONArray answerArray = dataService.toJSONArray(
				"select * from t_answer where status > ?",
				DataStatusEnum.NORMAL.getValue());
		JSONArray groupList = new JSONArray();
		JSONArray groupArray = new JSONArray();
		groupArray = dataService.toJSONArray(
				"select * from t_group where getStatus = ?",
				DataStatusEnum.NORMAL.getValue());
		JSONArray questionArray = dataService.toJSONArray(
				"select * from t_question where isAnswer = ?",
				DataStatusEnum.NORMAL.getValue());
		JSONArray answerList = new JSONArray();
		String reallyanswer = "";
		int scoreFlag;// 是否打分的标志 1为打了分 0表示没有
		int scoreSubmitFlag;// 是否打分的标志 1为打了分 0表示没有
		for (int i = 0; i < answerArray.length(); i++) {
			scoreSubmitFlag = 0;
			JSONObject answer = answerArray.optJSONObject(i);
			String problemId = answer.optString("problemId");
			JSONObject problem = dataService.toJSONObject(
					"select * from t_question where id = ?", problemId);
			String problemName = problem.optString("title");
			JSONObject answerSubmit = dataService.toJSONObject(
					"select * from t_submit where problemId = ?", problemId);
			if (answerSubmit.length() > 0) { // 先判断是否提交
				reallyanswer = answerSubmit.optString("answer");
				String groupSubmitId = answerSubmit.optString("groupId");
				JSONObject scoreJson = dataService.toJSONObject(
						"select * from t_score where groupId = ?",
						groupSubmitId);
				if (scoreJson.length() > 0) {// 再判断老师是否打分
					scoreSubmitFlag = 1;
					int answerScore = scoreJson.optInt("answerScore");
					answer.put("answerScore", answerScore);
				}
				answer.put("scoreSubmitFlag", scoreSubmitFlag);
			}

			answer.put("problemName", problemName);
			answer.put("reallyAnswer", reallyanswer);
			answerList.put(answer);
		}
		for (int i = 0; i < groupArray.length(); i++) {
			scoreFlag = 0;
			JSONObject group = groupArray.optJSONObject(i);
			String groupId = group.optString("id");
			JSONObject data = new JSONObject();
			data = dataService.toJSONObject(
					"select * from t_answer where groupId = ?", groupId);
			if (data.length() > 0) {
				group.put("questionId", data.optString("problemId"));
				group.put("submitFlag", data.optInt("submitFlag"));
				if (data.optInt("submitFlag") == 1) { /* 如果等于1表示已提交 */
					group.put(
							"answer",
							dataService
									.toJSONObject(
											"select * from t_submit where groupId  = ?",
											groupId).optString("answer"));
					group.put(
							"allocateTitle",
							dataService.toJSONObject(
									"select * from t_question where id  = ?",
									data.optString("problemId")).optString(
									"title"));
					/* 进一步判断教师是否已经给答案打分 */
					JSONObject score = dataService.toJSONObject(
							"select * from t_score where groupId = ?", groupId);
					if (score.length() > 0) {
						scoreFlag = 1;
						int reallyScore = score.optInt("answerScore");
						group.put("reallyScore", reallyScore);
					}
					group.put("scoreFlag", scoreFlag);
				}
			}
			group.put("questionList", questionArray);
			groupList.put(group);
		}
		model.addAttribute("groupList", groupList);
		model.addAttribute("answerList", answerList);

		return "/teacher/countList";
	}

	/*
	 * @RequestMapping(value = "/teacher/importData") //导入数据
	 * 
	 * @ResponseBody public String importData(HttpServletRequest request,
	 * HttpSession session, Model model) { String result = ""; JSONObject json =
	 * new JSONObject(); int count = 0; List<Student> listExcel =
	 * StudentService.getAllByExcel("D:\\test.xls"); for (Student stuEntity :
	 * listExcel) { String id = stuEntity.getId(); if
	 * (!studentService.isExist(id)) { // 不存在就添加 count =
	 * dataService.getTemplate(
	 * ).update("insert into student(id,name,sex,password) values(?,?,?,?)",
	 * stuEntity.getId(), stuEntity.getName(), stuEntity.getSex(),
	 * stuEntity.getPassword()); } else { // 存在就更新 count =
	 * dataService.getTemplate
	 * ().update("update student set name=?,sex=?,password=? where id=?",
	 * stuEntity.getId(), stuEntity.getName(), stuEntity.getSex(),
	 * stuEntity.getPassword()); } } if (count == 1) { json.put("code", "200");
	 * } else { json.put("code", "500"); } result = json.toString(); return
	 * result; }
	 */

	@RequestMapping(value = "/teacher/uploadFile")
	@ResponseBody
	public String uploadFile(HttpServletRequest request,
			@RequestParam("image") MultipartFile image, HttpSession session,
			Model model) throws IOException {
		// 如果文件不为空，写入上传路径
		String result = "";
		JSONObject data = new JSONObject();
		if (!image.isEmpty()) {
			// 上传文件路径
			String path = session.getServletContext().getRealPath("/images/");
			// 上传文件名
			String filename = image.getOriginalFilename();
			File filepath = new File(path, filename);
			// 判断路径是否存在，如果不存在就创建一个
			if (!filepath.getParentFile().exists()) {
				filepath.getParentFile().mkdirs();
			}
			// 将上传文件保存到一个目标文件当中
			image.transferTo(new File(path + File.separator + filename));
			String id = UUIDGenerator.getUUID();
			String url = path + File.separator + filename;
			String name = filename.substring(0, filename.lastIndexOf("."));
			User user = (User) session.getAttribute("loginUser");
			String teacherId = user.getId();
			int count = dataService
					.getTemplate()
					.update("insert into t_file(id, name, url, teacherId) values(?, ?, ?, ?)",
							id, name, url, teacherId);
			if (count == 1) {
				data.put("code", "200");
			} else {
				data.put("code", "500");
			}
		} else {
			data.put("code", "500");
		}
		result = data.toString();
		return result;
	}

	@RequestMapping(value = "/teacher/createTest")
	// 创建试题
	public String createTest() {
		return "/teacher/createTest";
	}

	@RequestMapping(value = "/teacher/download")
	public ResponseEntity<byte[]> download(HttpServletRequest request,
			HttpSession session, Model model) throws Exception {
		// 下载文件路径
		String name = request.getParameter("name") + ".xls";
		String path = session.getServletContext().getRealPath("/images/");
		File file = new File(path + File.separator + name);
		HttpHeaders headers = new HttpHeaders();
		// 下载显示的文件名，解决中文名称乱码问题
		String downloadFielName = new String(name.getBytes("UTF-8"),
				"iso-8859-1");
		// 通知浏览器以attachment（下载方式）打开图片
		headers.setContentDispositionFormData("attachment", downloadFielName);
		// application/octet-stream ： 二进制流数据（最常见的文件下载）。
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
				headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/teacher/upload")
	// 不同审核状态下的文件
	public String upload(Model model) {
		JSONArray fileArray = new JSONArray();
		JSONArray fileInCheckArray = new JSONArray();
		JSONArray fileFinishedArray = new JSONArray();
		fileArray = dataService.toJSONArray("select * from t_file");
		fileInCheckArray = dataService.toJSONArray(
				"select * from t_file where isSubmit = ? and checkStatus = ?",
				DataStatusEnum.OK.getValue(), DataStatusEnum.NORMAL.getValue());
		fileFinishedArray = dataService.toJSONArray(
				"select * from t_file where isSubmit = ? and checkStatus != ?",
				DataStatusEnum.OK.getValue(), DataStatusEnum.NORMAL.getValue());
		model.addAttribute("fileList", fileArray);
		model.addAttribute("fileInCheckList", fileInCheckArray);
		model.addAttribute("fileFinshiedList", fileFinishedArray);
		return "/teacher/upload";
	}

	@RequestMapping(value = "/teacher/submitCheck")
	// 取消或提交审核
	@ResponseBody
	public String submitCheck(Model model, HttpServletRequest request) {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		JSONObject data = new JSONObject();
		int count = 0;
		String result = "";
		count = dataService.getTemplate().update(
				"update t_file set isSubmit = ? where id = ?", status, id);
		if (count == 1) {
			data.put("code", "200");
		} else {
			data.put("code", "500");
		}
		result = data.toString();
		return result;
	}

	@RequestMapping(value = "/teacher/test")
	// 我的试题
	public String test(Model model, HttpServletRequest request,
			HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		String id = user.getId();
		JSONArray testArray = dataService.toJSONArray(
				"select * from t_question where status > ? and teacherId = ?",
				DataStatusEnum.DElETED.getValue(), id);
		model.addAttribute("taskList", testArray);
		return "/teacher/myTest";
	}

	@RequestMapping(value = "/teacher/studentList")
	public String studentList(HttpServletRequest request, Model model,
			HttpSession session) {
		JSONArray studentList = new JSONArray();
		JSONArray studentArray = dataService
				.toJSONArray(
						"select a.* from t_user a left join t_user_role b on a.id = b.user_id "
								+ "left join t_role c on b.role_id = c.id where (c.id = 4 or c.id = 3) and a.status > ?",
						DataStatusEnum.DElETED.getValue());
		JSONArray groupArray = dataService.toJSONArray(
				"select * from t_group where status > ?",
				DataStatusEnum.DElETED.getValue());

		for (int i = 0; i < studentArray.length(); i++) {
			JSONObject student = studentArray.optJSONObject(i);
			String studentId = student.optString("id");
			String groupId = dataService.toJSONObject(
					"select groupId from t_student_group where studentId = ?",
					studentId).optString("groupId");
			student.put("groupId", groupId);
			studentList.put(student);
		}
		model.addAttribute("studentList", studentList);
		model.addAttribute("groupList", groupArray);
		/*
		 * JSONArray studentList =
		 * dataService.toJSONArray("select * from t_student");
		 * model.addAttribute("studentList", studentList);
		 */
		return "/teacher/studentList";
	}

	@RequestMapping(value = "/teacher/studentSubmit")
	public String studentSubmit(HttpServletRequest request, Model model,
			HttpSession session) {
		JSONArray submitList = new JSONArray();
		JSONArray submitArray = new JSONArray();
		submitList = dataService.toJSONArray(
				"select * from t_submit where status > ?",
				DataStatusEnum.DElETED.getValue());
		for (int i = 0; i < submitList.length(); i++) {
			JSONObject json = submitList.optJSONObject(i);
			String problemId = json.optString("problemId");
			String problemTitle = dataService.toJSONObject(
					"select title from t_question where id = ?", problemId)
					.optString("title");
			json.put("title", problemTitle);
			submitArray.put(json);
		}
		model.addAttribute("submitList", submitArray);
		return "/teacher/submitList";
	}

	@RequestMapping(value = "/teacher/estimateScore")
	// 最后成绩
	public String estimateScore(Model model, HttpServletRequest request)
			throws ParseException {
		 int flag = 0;
	 	 String  name = request.getParameter("name");
		 JSONArray scoreArray = new JSONArray();
		 scoreArray = dataService.toJSONArray("select * from t_score");
		if(name == null){
			 scoreArray = dataService.toJSONArray("select * from t_score");
			for (int i = 0; i < scoreArray.length(); i++) {
					JSONObject score = scoreArray.optJSONObject(i);
				    flag = score.optInt("flag");
					if (flag == 1) {
						model.addAttribute("scoreList",dataService.toJSONArray("select * from t_score order by totalScore desc"));
						return "/teacher/estimateScore";
					}else if(flag == -1){
						model.addAttribute("scoreList", dataService.toJSONArray("select * from t_score order by timeScore desc"));
						return "/teacher/estimateScore";
					}
		    }
		}else{
			 if (Integer.parseInt(name)== 1) {
				 dataService.getTemplate().update("update t_score set flag = ?",DataStatusEnum.OK.getValue());
			 }else if(Integer.parseInt(name)== 2){
				 dataService.getTemplate().update("update t_score set flag = ?",DataStatusEnum.DISABLED.getValue());
			 }
		}
		JSONArray scoreList = new JSONArray();
		JSONArray scoreReallyArray = new JSONArray();
		int k = 1;
		for (int i = 0; i < scoreArray.length(); i++) {
			JSONObject score = scoreArray.optJSONObject(i);
			String groupId = score.optString("groupId");
			JSONObject group = dataService.toJSONObject(
					"select * from t_group where id = ?", groupId);
			String answerDate = group.optString("answerDate");
			String submitDate = group.optString("submitDate");
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			Date reallyAnswerDate = format.parse(answerDate);
			Date reallySubmitDate = format.parse(submitDate);
			long time = reallySubmitDate.getTime() - reallyAnswerDate.getTime();
			score.put("time", time);
			score.put("reallyAnswerDate", reallyAnswerDate);
			score.put("reallySubmitDate", reallySubmitDate);
			scoreList.put(score);
		}
		for (int i = 0; i < scoreList.length();) {// 根据抢答时间与提交时间差排名
			JSONObject json1 = scoreList.optJSONObject(i);
			long time1 = json1.optLong("time");
			for (int j = i + 1; j < scoreList.length(); j++) {
				JSONObject json2 = scoreList.optJSONObject(j);
				long time2 = json2.optLong("time");
				if (time2 < time1) {
					time1 = time2;
				}
			}
			for (int m = 0; m < scoreList.length(); m++) {
				JSONObject json = scoreList.optJSONObject(m);
				long time = json.optLong("time");
				if (time == time1) {
					json.put("order", k);
					json.put("timeScore", 100 - 20 * (k - 1));
					dataService.getTemplate().update("update t_score set timeScore = ? where groupId = ?",100 - 20 * (k - 1), json.optString("groupId"));
					DecimalFormat df = new DecimalFormat("0%");
					double total = json.optInt("answerScore")* json.optDouble("answerPre") + (100 - 20 * (k - 1))
							* json.optDouble("timePre");
					json.put("totalScore",total);
					dataService.getTemplate().update("update t_score set totalScore = ? where groupId = ?",total, json.optString("groupId"));
					json.put("timePre", df.format(json.optDouble("timePre")));
					json.put("answerPre",
							df.format(json.optDouble("answerPre")));
					scoreReallyArray.put(json);
					k++;
					scoreList.remove(m);
				}

			}
		}
		model.addAttribute("scoreList", scoreReallyArray);
		return "/teacher/estimateScore";
	}

	
	
	@RequestMapping(value = "/teacher/scoreOrder")
	@ResponseBody
	// 最后成绩
	public String scoreOrder(Model model, HttpServletRequest request)
			throws ParseException {
		JSONArray scoreArray = dataService.toJSONArray("select * from t_score  order by totalScore desc");
		model.addAttribute("scoreList", scoreArray);
		if (scoreArray.length() > 0) {
			return BaseReturn.response(ErrorCode.SUCCESS);
		} else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}

	
	@RequestMapping(value = "/teacher/answerScore")
	// 教师给答案打分
	public String answerScore(Model model, HttpServletRequest request,
			HttpSession session) {
		String score = request.getParameter("score");
		String groupId = request.getParameter("groupId");
		String groupName = dataService.toJSONObject(
				"select * from t_group where id = ?", groupId)
				.optString("name");
		User teacher = (User) session.getAttribute("loginUser");
		String teacherId = teacher.getId();
		 dataService.getTemplate().update(
				"insert into t_score(teacherId, groupId,groupName,answerScore) "
						+ "values(?, ?, ?, ?)", teacherId, groupId, groupName,
				score);
		return "redirect:/teacher/count";
	}

	@RequestMapping(value = "/teacher/answerPercent")
	// 教师设置答案分比例
	@ResponseBody
	public String answerPercent(Model model, HttpServletRequest request,
			HttpSession session) {
		String answerPercent = request.getParameter("answerPercent");
		String timePercent = request.getParameter("timePercent");
		/* DecimalFormat df = new DecimalFormat("0%"); */
		/* String reallyPercent = ""; */
		double Percent = 0;
		if (answerPercent == null) {
			Percent = Double.parseDouble(timePercent);
			/* reallyPercent = df.format(Percent); */
			dataService.getTemplate().update(
					"update t_score set timePre = ? where status > ?", Percent,
					DataStatusEnum.DElETED.getValue());
		} else {
			Percent = Double.parseDouble(answerPercent);
			/* reallyPercent = df.format(Percent); */
			dataService.getTemplate().update(
					"update t_score set answerPre = ? where status > ?",
					Percent, DataStatusEnum.DElETED.getValue());
		}

		return BaseReturn.response(ErrorCode.SUCCESS);
	}

	@RequestMapping(value = "/teacher/role/menuZtree", method = RequestMethod.GET)
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
			/* logger.info("-----返回的ztree:{}-----", BaseReturn.response(ztree)); */
			return BaseReturn.response(ztree);
		} else {
			return BaseReturn.response(ErrorCode.NOT_LOGGIN);
		}
	}
}
