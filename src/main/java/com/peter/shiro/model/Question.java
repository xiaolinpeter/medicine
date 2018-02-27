package com.peter.shiro.model;

/**
 * @author xiaolin_peter
 * 
 */
public class Question extends baseEntity {
	private String id; // 问题id
	private String title; // 问题标题
	private String description; // 问题描述
	private String teacherId;// 教师id
	private String fileId;// 文件id
	private int isRelease;// 是否发布
	private int isAnswer; // 是否被抢

	public Question(String id, String title, String description,
			String teacherId, String fileId) {
		// TODO Auto-generated constructor stub
		this.id = id;
		this.title = title;
		this.description = description;
		this.teacherId = teacherId;
		this.fileId = fileId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public int getIsRelease() {
		return isRelease;
	}

	public void setIsRelease(int isRelease) {
		this.isRelease = isRelease;
	}

	public int getIsAnswer() {
		return isAnswer;
	}

	public void setIsAnswer(int isAnswer) {
		this.isAnswer = isAnswer;
	}

}
