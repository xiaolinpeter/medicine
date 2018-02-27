/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : peter_shiro

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-01-10 21:28:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_resource`
-- ----------------------------
DROP TABLE IF EXISTS `t_resource`;
CREATE TABLE `t_resource` (
  `id` varchar(32) NOT NULL COMMENT '资源 ID',
  `parentId` varchar(32) DEFAULT NULL,
  `name` varchar(20) NOT NULL COMMENT '资源名称,一般是中文名称(给人看的)',
  `permission` varchar(40) NOT NULL COMMENT '资源权限字符串,一般是 Shiro 默认的通配符表示(给人看的)',
  `url` varchar(40) NOT NULL COMMENT '资源 url 表示,我们设计的系统让 Shiro 通过这个路径字符串去匹配浏览器中显示的路径',
  `rank` int(4) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of t_resource
-- ----------------------------
INSERT INTO `t_resource` VALUES ('1', null, '系统管理', 'admin:*', '/admin/**', '0', '0', null, null);
INSERT INTO `t_resource` VALUES ('10', '8', '角色删除', 'role:delete', '/admin/role/delete', '24', '0', null, '2018-01-08 10:41:10');
INSERT INTO `t_resource` VALUES ('11', '8', '角色修改', 'role:update', '/admin/role/update/*', '23', '0', null, '2018-01-09 11:27:10');
INSERT INTO `t_resource` VALUES ('12', '8', '角色列表', 'role:list', '/admin/role/list', '21', '0', null, '2018-01-08 10:41:01');
INSERT INTO `t_resource` VALUES ('13', '8', '角色资源查询', 'role:resources:*', '/admin/role/resources/*', '35', '0', null, '2018-01-08 10:41:30');
INSERT INTO `t_resource` VALUES ('14', '1', '资源管理', 'resource:*', '/admin/resource/resource/**', '3', '0', null, '2018-01-08 20:14:24');
INSERT INTO `t_resource` VALUES ('15', '14', '资源增加', 'resource:add', '/admin/resource/add', '32', '0', null, '2018-01-08 10:41:22');
INSERT INTO `t_resource` VALUES ('16', '14', '资源删除', 'resource:delete', '/admin/resource/delete', '34', '0', null, '2018-01-08 10:41:27');
INSERT INTO `t_resource` VALUES ('17', '14', '资源修改', 'resource:update', '/admin/resource/update/*', '33', '0', null, '2018-01-09 11:27:35');
INSERT INTO `t_resource` VALUES ('18', '14', '资源列表', 'resource:list', '/admin/resource/list', '31', '0', null, '2018-01-08 10:41:20');
INSERT INTO `t_resource` VALUES ('2', '1', '用户管理', 'user:*', '/admin/user/user/**', '1', '0', null, '2018-01-08 20:14:50');
INSERT INTO `t_resource` VALUES ('3', '2', '用户添加', 'user:add', '/admin/user/add', '12', '0', null, '2018-01-08 10:40:32');
INSERT INTO `t_resource` VALUES ('3cbb637ccf794761bf8cbc2f9f61ec15', '1', '测试模块', 'admin:index', '/admin/index.html', '51', '0', '2018-01-08 13:39:02', '2018-01-09 13:48:19');
INSERT INTO `t_resource` VALUES ('4', '2', '用户删除', 'user:delete', '/admin/user/delete', '14', '0', null, '2018-01-08 10:40:43');
INSERT INTO `t_resource` VALUES ('5', '2', '用户修改', 'user:update', '/admin/user/update/*', '13', '0', null, '2018-01-09 11:25:25');
INSERT INTO `t_resource` VALUES ('6', '2', '用户列表', 'user:list', '/admin/user/list', '11', '0', null, '2018-01-08 10:40:30');
INSERT INTO `t_resource` VALUES ('7', '2', '用户资源查询', 'user:resources:*', '/admin/user/resource/*', '15', '0', null, '2018-01-08 14:56:10');
INSERT INTO `t_resource` VALUES ('8', '1', '角色管理', 'role:*', '/admin/role/role/**', '2', '0', null, '2018-01-08 20:14:42');
INSERT INTO `t_resource` VALUES ('9', '8', '角色添加', 'role:add', '/admin/role/add', '22', '0', null, '2018-01-08 10:40:54');
INSERT INTO `t_resource` VALUES ('caf4d35e5667439eb592cc643c318b01', '1', '学生模块', 'admin:student', '/admin/student/**', '5', '0', '2018-01-09 13:52:07', '2018-01-09 14:03:19');
INSERT INTO `t_resource` VALUES ('f10841ccd2ea4063954d374f9d844a12', '1', '教师模块', 'admin:teacher', '/admin/teacher/**', '4', '0', '2018-01-09 13:04:34', '2018-01-09 14:03:24');

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` varchar(32) NOT NULL COMMENT '角色表 ID',
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `sn` varchar(20) NOT NULL COMMENT '角色字符串',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '管理员', 'admin', '0', '2018-01-07 21:25:13', null);
INSERT INTO `t_role` VALUES ('2', '教师', 'teacher', '0', '2018-01-07 21:25:13', '2018-01-09 11:07:27');
INSERT INTO `t_role` VALUES ('3', '组长', 'leader', '0', '2018-01-07 21:25:13', '2018-01-09 11:07:36');
INSERT INTO `t_role` VALUES ('4', '学生', 'student', '0', '2018-01-07 21:25:13', '2018-01-09 11:07:41');
INSERT INTO `t_role` VALUES ('d66e2f4c69bc4249813794c207fc130c', '普通用户', 'user', '0', '2018-01-08 13:46:55', null);

-- ----------------------------
-- Table structure for `t_role_resource`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_resource`;
CREATE TABLE `t_role_resource` (
  `id` varchar(32) NOT NULL COMMENT '角色资源关联 ID',
  `role_id` varchar(32) NOT NULL COMMENT '角色 id',
  `resource_id` varchar(32) NOT NULL COMMENT '资源 id',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源关联表';

-- ----------------------------
-- Records of t_role_resource
-- ----------------------------
INSERT INTO `t_role_resource` VALUES ('00b30b98466d42049ef4e459201bb5e7', '4', '3cbb637ccf794761bf8cbc2f9f61ec15', '0', '2018-01-09 14:21:15', null);
INSERT INTO `t_role_resource` VALUES ('1', '1', '1', '0', null, '2018-01-08 10:44:10');
INSERT INTO `t_role_resource` VALUES ('10', '2', '15', '0', null, '2018-01-08 10:44:11');
INSERT INTO `t_role_resource` VALUES ('11', '2', '17', '0', null, '2018-01-08 10:44:12');
INSERT INTO `t_role_resource` VALUES ('12', '2', '18', '0', null, '2018-01-08 10:44:14');
INSERT INTO `t_role_resource` VALUES ('13', '3', '6', '0', null, '2018-01-08 10:44:14');
INSERT INTO `t_role_resource` VALUES ('14', '3', '7', '0', null, '2018-01-08 10:44:15');
INSERT INTO `t_role_resource` VALUES ('15', '3', '8', '0', null, '2018-01-08 10:44:15');
INSERT INTO `t_role_resource` VALUES ('16', '3', '14', '0', null, '2018-01-08 10:44:16');
INSERT INTO `t_role_resource` VALUES ('17', '4', '6', '0', null, '2018-01-08 10:44:17');
INSERT INTO `t_role_resource` VALUES ('18', '4', '7', '0', null, '2018-01-08 10:44:17');
INSERT INTO `t_role_resource` VALUES ('19', '4', '12', '0', null, '2018-01-08 10:44:18');
INSERT INTO `t_role_resource` VALUES ('2', '2', '3', '0', null, '2018-01-08 10:44:19');
INSERT INTO `t_role_resource` VALUES ('20', '4', '18', '0', null, '2018-01-08 10:44:19');
INSERT INTO `t_role_resource` VALUES ('27330a8cf4c847d8b5d0d7477a5ee7db', '3', '3cbb637ccf794761bf8cbc2f9f61ec15', '0', '2018-01-08 16:35:21', null);
INSERT INTO `t_role_resource` VALUES ('29dd6b95f5e64fc28b6766378e197795', '2', 'f10841ccd2ea4063954d374f9d844a12', '0', '2018-01-09 13:49:18', null);
INSERT INTO `t_role_resource` VALUES ('2db6f092d2534ba3972764724f1bd7ff', '2', '8', '0', '2018-01-08 14:50:03', null);
INSERT INTO `t_role_resource` VALUES ('3', '2', '5', '0', null, '2018-01-08 10:44:20');
INSERT INTO `t_role_resource` VALUES ('4', '2', '6', '0', null, '2018-01-08 10:44:22');
INSERT INTO `t_role_resource` VALUES ('4117ce133d0a480d97129f50bc2fd74f', '4', '14', '0', '2018-01-09 14:22:29', null);
INSERT INTO `t_role_resource` VALUES ('5', '2', '7', '0', null, '2018-01-08 10:44:21');
INSERT INTO `t_role_resource` VALUES ('5f6b036427bd4e8686c77be7ad69ed9d', '2', '14', '0', '2018-01-08 14:49:55', null);
INSERT INTO `t_role_resource` VALUES ('6', '2', '9', '0', null, '2018-01-08 10:44:22');
INSERT INTO `t_role_resource` VALUES ('63d2e9c56c91492cbe56de8d96e1cfd1', 'd66e2f4c69bc4249813794c207fc130c', '12', '0', '2018-01-08 13:47:32', null);
INSERT INTO `t_role_resource` VALUES ('698d3b199dad4168a150ecaa94371dae', 'd66e2f4c69bc4249813794c207fc130c', '18', '0', '2018-01-08 20:16:04', null);
INSERT INTO `t_role_resource` VALUES ('7', '2', '11', '0', null, '2018-01-08 10:44:23');
INSERT INTO `t_role_resource` VALUES ('744ea32f0eef46489292d89a7999b280', 'd66e2f4c69bc4249813794c207fc130c', '3cbb637ccf794761bf8cbc2f9f61ec15', '0', '2018-01-08 20:05:23', null);
INSERT INTO `t_role_resource` VALUES ('7973e19877bc4a5498ae2798e0f34638', '4', 'caf4d35e5667439eb592cc643c318b01', '0', '2018-01-09 14:01:44', null);
INSERT INTO `t_role_resource` VALUES ('7e44428097bc4484b63fee9bb0e33d03', 'd66e2f4c69bc4249813794c207fc130c', '14', '0', '2018-01-08 20:16:15', null);
INSERT INTO `t_role_resource` VALUES ('8', '2', '12', '0', null, '2018-01-08 10:44:24');
INSERT INTO `t_role_resource` VALUES ('80bbaf0f96cd4eee8097faa8186e1da9', 'd66e2f4c69bc4249813794c207fc130c', '6', '0', '2018-01-08 13:47:16', null);
INSERT INTO `t_role_resource` VALUES ('8592bc3bd3f1430a9183497fe974c0e0', 'd66e2f4c69bc4249813794c207fc130c', '8', '0', '2018-01-08 20:15:58', null);
INSERT INTO `t_role_resource` VALUES ('8a13bc6c1f994a8f99049f82899a5f4d', '3', '2', '0', '2018-01-08 16:37:34', null);
INSERT INTO `t_role_resource` VALUES ('9', '2', '13', '0', null, '2018-01-08 10:44:25');
INSERT INTO `t_role_resource` VALUES ('b7a0520d5b354bcbb6ec2b2e9e9362f2', '2', '2', '0', '2018-01-08 14:50:00', null);
INSERT INTO `t_role_resource` VALUES ('c04b9eb1d48d459ab0a7b5f1170abb71', '2', '3cbb637ccf794761bf8cbc2f9f61ec15', '0', '2018-01-08 13:49:09', null);
INSERT INTO `t_role_resource` VALUES ('ecb80da0dac543bab5fa5ac3af818234', '4', '8', '0', '2018-01-09 14:22:23', null);
INSERT INTO `t_role_resource` VALUES ('f637740897f8426f9ba67a445e80c74b', 'd66e2f4c69bc4249813794c207fc130c', '2', '0', '2018-01-08 20:15:18', null);
INSERT INTO `t_role_resource` VALUES ('f6644bc561ab4e90ade6c4cbdf2d87d8', '3', '12', '0', '2018-01-08 16:37:25', null);
INSERT INTO `t_role_resource` VALUES ('f7f14ce831374cfc85e49ba6a7cbd69a', '4', '2', '0', '2018-01-09 14:22:32', null);

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(32) NOT NULL COMMENT '用户 ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `nickname` varchar(30) NOT NULL COMMENT '昵称',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `reallyStatus` tinyint(4) NOT NULL DEFAULT '0',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '1', '1', '2018-01-07 21:28:59', '2018-01-09 11:01:53');
INSERT INTO `t_user` VALUES ('2', 'teacher', '202cb962ac59075b964b07152d234b70', '教师', '1', '0', '2018-01-07 21:28:59', '2018-01-09 11:11:21');
INSERT INTO `t_user` VALUES ('3', 'leader', '202cb962ac59075b964b07152d234b70', '学生组长', '1', '0', '2018-01-07 21:28:59', '2018-01-09 11:09:22');
INSERT INTO `t_user` VALUES ('4', 'student', '202cb962ac59075b964b07152d234b70', '学生', '1', '0', '2018-01-07 21:28:59', '2018-01-09 11:09:32');
INSERT INTO `t_user` VALUES ('9c5be6726cce4b2bbb31f29e2b8e70fe', 'user3', '2fa5319fb2333fabb82b3ab68b100a33', '普通用户', '-2', '0', '2018-01-08 19:52:33', '2018-01-09 11:13:17');
INSERT INTO `t_user` VALUES ('af1c8b0d67404e24b8b8951cd657c7f0', 'user8', '202cb962ac59075b964b07152d234b70', '牛奶', '-2', '0', '2018-01-09 10:52:20', '2018-01-09 11:13:11');

-- ----------------------------
-- Table structure for `t_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `id` varchar(32) NOT NULL COMMENT '用户角色关联表 ID',
  `user_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1', '1', '1', '0', null, null);
INSERT INTO `t_user_role` VALUES ('25ca77a5104f46e6bce782ac9859b980', 'efe4df282c044e259a4ac936026774ba', 'd66e2f4c69bc4249813794c207fc130c', '0', null, null);
INSERT INTO `t_user_role` VALUES ('302b85bb6bf24f54a85510f4e079b55b', 'c9c87b7c75e74d0d82d4abca5ed482d2', 'd66e2f4c69bc4249813794c207fc130c', '0', null, null);
INSERT INTO `t_user_role` VALUES ('4138898819c74dd9bcd5e6cd3c2007bc', '3', '3', '0', null, null);
INSERT INTO `t_user_role` VALUES ('4a7f5c97f61f47e28ae574fddc870b53', '4', '4', '0', '2018-01-09 14:20:16', null);
INSERT INTO `t_user_role` VALUES ('87528d1f48024ead82ae1061db437c61', 'f9009ab69d05403eb26666312784ce33', 'd66e2f4c69bc4249813794c207fc130c', '0', null, null);
INSERT INTO `t_user_role` VALUES ('b7dc3f614f3f47ac9d268834412b926d', '2', '2', '0', null, null);
