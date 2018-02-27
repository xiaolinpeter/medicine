package com.peter.shiro.service;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Service;
import com.peter.shiro.model.User;

import vms.common.util.JsonUtils;

@Service
public class DataService {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private  final Logger log = LoggerFactory.getLogger(DataService.class);
	public  JdbcTemplate getTemplate() {
		return jdbcTemplate;
	}
	
	/**
	 * 
	 * @param sql  执行的sql语句
	 * @param args 不定项参数
	 * @return
	 * @throws DataAccessException
	 * @throws IOException
	 */
	/*public  JSONArray toJSONArray(String sql, Object... args)  {
		List list= getTemplate().queryForList(sql, args);
		return JSONArray.fromObject(list);
		
	}*/
	
	public JSONArray toJSONArray(String sql, Object... args) {
		final JSONArray array = new JSONArray();
		getTemplate().query(sql, new RowCallbackHandler() {

			@Override
			public void processRow(ResultSet rs) {
				try {
					array.put(toJSONObject(rs));
				} catch (Exception e) {
					log.error("processRow error", e);
				}
			}

		}, args);
		return array;
	}
	
	public JSONObject toJSONObject(ResultSet rs) throws SQLException {
		final JSONObject json = new JSONObject();
		toJSONObject(json, rs);
		return json;
	}

	public void toJSONObject(final JSONObject json, ResultSet rs) throws SQLException{

		ResultSetMetaData rsmd = rs.getMetaData();
		int columnCount = rsmd.getColumnCount();
		for (int index = 1; index <= columnCount; index++) {
			String column = JdbcUtils.lookupColumnName(rsmd, index);
			Object value = JdbcUtils.getResultSetValue(rs, index);
			if (value == null) {
				json.put(column, "");
				continue;
			}
			if (value instanceof Date) {
				Date date = (Date) value;
				/*value = DateUtils.formatFullDate(new Date(date.getTime()));*/
				/*value = DateUtils.formatFullDate(null);*/
			}
			json.put(column, value);
		}
	}

	public JSONObject toJSONObject(String sql, Object... args) {
		final JSONObject json = new JSONObject();
		getTemplate().query(sql, new RowCallbackHandler() {

			@Override
			public void processRow(ResultSet rs) throws SQLException {
				try {
					toJSONObject(json, rs);
				} catch (JSONException e) {
					log.error("processRow error", e);
				}
			}

		}, args);
		return json;
	}
	
	
	/*public JSONObject toJSONObject(String sql, Object... args) {
		List list = getTemplate().queryForList(sql,args);
		if(list.size() == 0) {
			return new JSONObject();
		}
		return JSONObject.fromObject(list.get(0));
	}
	
	protected JSONObject toJSONObject(baseEntity entity)  {
		return entity.toJSONObject();
	}
	*/

	public User login(String username, String password) {
		// TODO Auto-generated method stub
		JSONObject jsonUser = new JSONObject();
		jsonUser  = toJSONObject("select * from t_user where username = ?", username);
		/*User user = (User) JSONObject.toBean(jsonUser, User.class);*/
		User user = JsonUtils.fromJson(jsonUser, User.class);
		return user;
	}
	
}

