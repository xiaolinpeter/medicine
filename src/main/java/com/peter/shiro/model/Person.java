package com.peter.shiro.model;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

/**
 * t_user
 */
public class Person implements Serializable {
	private static final long serialVersionUID = 1L;
	private MultipartFile image;

	public Person() {
		super();
	}

	public MultipartFile getImage() {
		return image;
	}

	public void setImage(MultipartFile image) {
		this.image = image;
	}	
}
