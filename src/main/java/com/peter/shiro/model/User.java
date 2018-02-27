package com.peter.shiro.model;

import java.io.Serializable;

/**
 * t_user
 */
public class User extends baseEntity implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 昵称
     */
    private String nickname;
    /**
     * 状态（启用、禁用）
     */
    private int rellyStatus;

	public User(){
		  
   }

	public User(String id, String username, String password, String nickname) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.nickname = nickname;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }


    public int getRellyStatus() {
		return rellyStatus;
	}

	public void setRellyStatus(int rellyStatus) {
		this.rellyStatus = rellyStatus;
	}

	@Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", nickname='" + nickname + '\'' +
                ", status=" + rellyStatus +
                '}';
    }
}
