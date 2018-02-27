package com.peter.shiro.model;

/**
 * t_role_resource
 */
public class RoleResource extends baseEntity{
    private String id;
    private String roleId;
    private String resourceId;


    public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getRoleId() {
		return roleId;
	}


	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}


	public String getResourceId() {
		return resourceId;
	}


	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}


	@Override
    public String toString() {
        return "RoleResource{" +
                "id=" + id +
                ", roleId=" + roleId +
                ", resourceId=" + resourceId +
                '}';
    }
}
