package com.peter.shiro.model;

/**
 * @author xiaolin_peter 组
 */
public class Group extends baseEntity {
	private String id; // 组id
	private String name; // 组名
	private String leaderId; // 组长学号
	private String leaderName;// 组长姓名

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getLeaderId() {
		return leaderId;
	}

	public void setLeaderId(String leaderId) {
		this.leaderId = leaderId;
	}

	public String getLeaderName() {
		return leaderName;
	}

	public void setLeaderName(String leaderName) {
		this.leaderName = leaderName;
	}

}
