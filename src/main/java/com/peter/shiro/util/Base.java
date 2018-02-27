package com.peter.shiro.util;
import java.io.IOException;
import java.text.SimpleDateFormat;

import org.springframework.dao.DataAccessException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base {
	/**
	 * 检查用户登陆
	 * @return
	 */
	/**
	 * 获取用户简单信息
	 * @param userId
	 * @return
	 * @throws DataAccessException
	 * @throws IOException
	 */
	/*public static JSONObject getUserInfo(String userId) throws DataAccessException, IOException {
		JSONObject json = new JSONObject();
		JSONObject userInfo = DataService.toJSONObject("select * from nsfc_user where id = ?", userId);
		json.put("onlineStatus", 1);
		json.put("userId", userId);
		json.put("userName", userInfo.optString("nickName",""));
		return json;
	}*/
	/**
	 * 解密
	 * @param key
	 * @return
	 * @throws Exception
	 */
    public static byte[] decryptBASE64(String key) throws Exception {   
        return (new BASE64Decoder()).decodeBuffer(key);   
    } 
    /**
     * 加密
     * @param key
     * @return
     * @throws Exception
     */
    public static String encryptBASE64(byte[] key) throws Exception {   
        return (new BASE64Encoder()).encodeBuffer(key);   
    }  
    
    /**
     * 转换整形时间至字符串时间
     * @param time
     * @return
     */
    public static String dateFormat(long time) {
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String date = sf.format(time);
    	return date;
    }
}
