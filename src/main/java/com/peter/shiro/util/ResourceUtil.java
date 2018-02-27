package com.peter.shiro.util;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import com.peter.shiro.model.Resource;
public class ResourceUtil {
	/**
	 * 递归查找子菜单
	 * 
	 * @param id
	 *            当前菜单id
	 * @param rootMenu
	 *            要查找的列表
	 * @return
	 */
	public static List<Resource> getChild(String id, List<Resource> rootResource) {
		// 子菜单
		List<Resource> childList = new ArrayList<Resource>();
		for (Resource resource: rootResource) {
			// 遍历所有节点，将父菜单id与传过来的id比较
			if (StringUtils.isNotBlank(resource.getParentId())) {
				if (resource.getParentId().equals(id)) {
					childList.add(resource);
				}
			}
		}
		// 把子菜单的子菜单再循环一遍
		for (Resource resource : childList) {// 没有url子菜单还有子菜单
			if (resource.getUrl().endsWith("*")) {
				// 递归
				resource.setChildren(getChild(resource.getId(), rootResource));
			}
		} // 递归退出条件
		if (childList.size() == 0) {
			return null;
		}
		return childList;
	}
}
