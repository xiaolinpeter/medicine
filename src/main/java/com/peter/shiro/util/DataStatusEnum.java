package com.peter.shiro.util;


/**
 * 数据状态枚举信息
 * 将常用的几种数据状态独立出来，方便维护
 * @author xiaolin_peter
 */

public enum DataStatusEnum {
	OK(1),//可靠
	NORMAL(0),//等于0为正常
	DISABLED(-1),//等于-1 为禁用状态
	DElETED(-2);
	private int value;
	
	DataStatusEnum(int value) {
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
	
	
	
	
}
