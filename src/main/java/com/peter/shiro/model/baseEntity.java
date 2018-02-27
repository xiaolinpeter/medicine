package com.peter.shiro.model;

import java.util.Date;

import org.json.JSONObject;

import vms.common.util.JsonUtils;


public class baseEntity {
	private Date createDate = new Date();
	private Date updateDate = new Date();
    private int status = 0;
    
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String toJSON() {
		// 转义成标准的JSON格式
		return JsonUtils.toJsonString(this);
	}

	/**
	 * 导出为JSON 对象
	 * 
	 * @return
	 */
	public JSONObject toJSONObject(){
		return new JSONObject(this.toJSON());
	}
}
