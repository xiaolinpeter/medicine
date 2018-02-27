package com.peter.shiro.model;

/**
 * @author xiaolin_peter
 * 
 */
public class Student {
	private String id;
	private String name;
	private String sex;
	private String password;
	private String email;

	public Student(String id, String name, String sex, String password, String email) {
		this.id = id;
		this.name = name;
		this.sex = sex;
		this.password = password;
		this.email = email;
	}

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

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
