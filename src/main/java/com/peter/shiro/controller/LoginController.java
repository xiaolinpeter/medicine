package com.peter.shiro.controller;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.util.Properties;
import java.util.Random;

import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.context.SessionParam;
import com.peter.shiro.kit.ShiroKit;
import com.peter.shiro.model.User;
import com.peter.shiro.service.DataService;
import com.peter.shiro.service.SessionService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.Param;
import com.peter.shiro.util.UUIDGenerator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import vms.common.util.JsonUtils;


@RequestMapping(value = "/")
@Controller
public class LoginController {
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    private DataService dataService;
    @Autowired
    private SessionService sessionService;
	String content = "";
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(HttpSession session){
    	if(session.getAttribute("loginUser") != null){
			return "redirect:/index.html";
		}
        return "login";
    }

    @RequestMapping(value = "/register.html",method = RequestMethod.POST)//注册
    @ResponseBody
    public String register(HttpServletRequest request){
    	String result = "";
    	JSONObject json =new JSONObject();
    	String role_id = "1";
    	String id = UUIDGenerator.getUUID();
    	int status = 1;
    	int count = 0;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String secondPassword = ShiroKit.getMD5(password);
        String typeId = request.getParameter("userType");
       /* JSONArray usernameArray = dataService.toJSONArray("select username from t_user");
        for (int i = 0; i < usernameArray.length(); i++) {
			JSONObject usernameJsonObject = usernameArray.optJSONObject(i);
			if (username.equals(usernameJsonObject.optString("username"))) {
				json.put("code","201");
				json.put("message","该用户名已存在");
				return json.toString();
			}
		}*/
        if ("2".equals(typeId)) {
        	role_id = "2";
        	dataService.getTemplate().update("insert into t_user(id,username,nickname,password,status) value(?, ?, ?, ?, ?)",id, username, username, secondPassword, status);
            dataService.getTemplate().update("insert into t_user_role(user_id, role_id) value(?,?)", id, role_id);
		}else if ("3".equals(typeId)) {
			role_id = "4";
		    count = dataService.getTemplate().update("update t_user set status = ?, password = ? where username = ?",DataStatusEnum.OK.getValue(), secondPassword, username);
		}
        
    
        if(count > 0) {
        	json.put("code", 200);
        }else {
        	json.put("code", 500);
        }
        result = json.toString();
        return result;
    }
    
    
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public String login(User user, Model model, HttpSession session){
    	String result = "";
    	JSONObject json = new JSONObject();
        String username = user.getUsername();
        String password = user.getPassword();
        logger.debug("username => " + username);
        logger.debug("password => " + password);
    	UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        Subject subject = SecurityUtils.getSubject();
        String msg = null;
        try {
        	/*token.setRememberMe(true);*/
            subject.login(token);
        } catch (UnknownAccountException e) {
            e.printStackTrace();
            msg = e.getMessage();
            json.put("code", "201");
            json.put("message", msg);
            
        } catch (IncorrectCredentialsException e){
            e.printStackTrace();
            msg = "用户名或者密码不匹配";
            json.put("code", "202");
            json.put("message", msg);
      
        } catch (LockedAccountException e){
            e.printStackTrace();
            msg = e.getMessage();
            json.put("code", "203");
            json.put("message", msg);
        }
        if(msg == null){
        	/* json = dataService.toJSONObject("select * from t_user where username = ? ", username);*/
        	 user = (User) dataService.login(username, password);
        	 session.setAttribute(Param.SESSION_LOGIN_USER, user);
        	 sessionService.setResourceInSession(session, user);
        	 json.put("code","200");
        	 json.put("message","登陆成功");
        	 result = json.toString();
             return result;
        }
        result = json.toString();
        return result;
    }

    @RequestMapping(value = "/register/checkUsername", method = RequestMethod.GET)
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
		JSONObject json= dataService.toJSONObject("select * from t_student where id = ?", username);
		if (!StringUtils.isBlank(json.optString("id"))) {
		  	flag = true;
		}
		return flag;
	}
    
    @RequestMapping(value = "/checkEmailCode", method = RequestMethod.GET)
   	@ResponseBody
   	public String emailCode(String emailCode) {
       	if (StringUtils.isBlank(emailCode)) {
   			return BaseReturn.response(ErrorCode.PARAM_ERROR, "验证码不能为空");
   		} else {
   			return BaseReturn.response(checkEmailCode(emailCode));
   		}

   	}
    
    private Boolean checkEmailCode(String emailCode) {
		// TODO Auto-generated method stub
    	if (emailCode.equals(content)) {
			return true;
		}else {
			return false;
		}
	}
	
	
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(Model model){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        model.addAttribute("msg","您已经退出登录");
        return "login";
    }

    @RequestMapping(value = "/unAuthorization")
    public String unAuthorization(){
        return "unAuthorization";
    }
    
    /**
   	 * 个人设置
   	 * 
   	 * @param model
   	 * @return
   	 */
   	@RequestMapping("/setting.html")
   	public String setting(Model model, HttpSession session) {
   		User user = (User)session.getAttribute("loginUser");
   		String title = "个人设置";
   		model.addAttribute("title", title);
   		model.addAttribute("loginUser", user);
   		return "setting";
   	}
   	
   	
   	@RequestMapping("/updateUser.html")
   	@ResponseBody
   	public String updateUser(Model model,HttpServletRequest request,HttpSession session) {
   		String username = request.getParameter("username");
   		String nickname= request.getParameter("nickname");
   		int count = dataService.getTemplate().update("update t_user set nickname = ? where username = ?",nickname, username);
   		JSONObject user = dataService.toJSONObject("select * from t_user where username = ?", username);
   		User entityUser = JsonUtils.fromJson(user, User.class);
   		if(count > 0){
   	        sessionService.setResourceInSession(session, entityUser);
   			return BaseReturn.response(ErrorCode.SUCCESS);
   		}else{
   			return BaseReturn.response(ErrorCode.FAILURE);
   			
   		}
   	}
   	
   	@RequestMapping("/updatePassword.html")
   	@ResponseBody
   	public String updatePassword(Model model,HttpServletRequest request, HttpSession session) {
   		String username = request.getParameter("username");
   		String password= request.getParameter("password");
   		String reallyPassword = ShiroKit.getMD5(password);
   		int count = dataService.getTemplate().update("update t_user set password = ? where username = ?",reallyPassword, username);
   		if(count > 0){
   			session.removeAttribute(SessionParam.LOGIN_USER);
   			return BaseReturn.response(ErrorCode.SUCCESS);
   		}else{
   			return BaseReturn.response(ErrorCode.FAILURE);
   			
   		}
   	}
   	
   	/*@RequestMapping("/doRegister")
	@ResponseBody
	public String doRegister(Model model,HttpServletRequest request){
		JSONObject json = new JSONObject();
		String email = request.getParameter("email");
		String password= request.getParameter("password");
		String nickName = "";
		String result = "";
		JSONObject data = new JSONObject();
		try {
			data = dataService.toJSONObject("select id from nsfc_user where email = ?", email);
			if (!data.optString("id").equals("")) {
				json.put("code", "201");
				json.put("message", "该邮箱已注册");
			}else {
			  nickName = email.split("@")[0];
			  MessageDigest md = MessageDigest.getInstance("MD5");
		        // 计算md5函数
		        md.update(password.getBytes()); 
		        password = new BigInteger(1, md.digest()).toString(16);
			  int count = dataService.getTemplate().update("insert into nsfc_user(nickName, email, password) values(?, ? ,?)", nickName,email,password);
			  if(count == 0) {
					json.put("code", 204);//注册失败
					json.put("message", "注册失败");
					json.put("email", email);
				}else {
					//发送邮箱验证
					JSONObject userInfo = dataService.toJSONObject("select id from nsfc_user where email = ?",email);  
					JSONObject sendStatus = sendCheckEmal(email,userInfo.optString("id"));
					String err = sendStatus.optString("err",null);
					if(err == null) {
						json.put("code", 200);
						json.put("email", email);
					}else {
						json.put("code", 500);
						json.put("message", err);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code", "500");
			json.put("message", "服务器有问题");
			result = json.toString();
			return result;
		}
		result = json.toString();
		return result;
	}*/
   	
    @RequestMapping(value = "/sendCheckEmail.html", method = RequestMethod.GET)
	@ResponseBody
	private String sendCheckEmail(HttpServletRequest req) {
		// TODO Auto-generated method stub
    	if(content.length()>3) {
    		content = "";
    	}
    	String username = req.getParameter("username");
    	JSONObject data = dataService.toJSONObject("select * from t_student where id = ?", username);
    	String email = data.optString("email");
		JSONObject json = new JSONObject();
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			content += random.nextInt(10);
		}
		try {
			json = sendSimpleMail(email, content, "邮箱验证");
			if(json.optString("code").equals("200")) {
				return BaseReturn.response(ErrorCode.SUCCESS);
			}else {
				return BaseReturn.response(ErrorCode.FAILURE);
			}
		} catch (Exception e) {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
	}

	private JSONObject sendSimpleMail(String email, String content,String subject) {
		JSONObject json = new JSONObject();
		Properties prop = new Properties();
		InputStream in = new BufferedInputStream (DataService.class.getClassLoader().getResourceAsStream("config.properties"));
        Transport ts;
		try {
			prop.load(in);
	        //使用JavaMail发送邮件的5个步骤
	        //1、创建session
		    Session session = Session.getInstance(prop);
	        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
	        session.setDebug(true);
	        //2、通过session得到transport对象
			ts = session.getTransport();
            //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
	        ts.connect(prop.getProperty("mail.host"), prop.getProperty("mail.user"), prop.getProperty("mail.pass"));
	        //4、创建邮件
	        Message message = createSimpleMail(session, email, content, subject,prop.getProperty("mail.from"),prop.getProperty("mail.nick"));
	        //5、发送邮件
	        ts.sendMessage(message, message.getAllRecipients());
	        ts.close();
		} catch (Exception e) {
			json.put("err", e.getMessage());
			return json;
		}
		json.put("code", "200");
		return json;
	}

	private Message createSimpleMail(Session session, String email,
			String content, String subject, String from, String nick) throws Exception {
		// TODO Auto-generated method stub
		 //创建邮件对象
        MimeMessage message = new MimeMessage(session);
        //指明邮件的发件人
        message.setFrom(new InternetAddress(nick+" <"+from+">"));
        //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
        //邮件的标题
        message.setSubject(subject);
        message.setContent(content, "text/html;charset=UTF-8");
        //返回创建好的邮件对象
        return message;
	}

}
