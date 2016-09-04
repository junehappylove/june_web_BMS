/*
Navicat MySQL Data Transfer

Source Server         : 10.50.200.38 本机
Source Server Version : 50610
Source Host           : 10.50.200.38:3306
Source Database       : framework

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2016-09-04 22:11:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `app_setting`
-- ----------------------------
DROP TABLE IF EXISTS `app_setting`;
CREATE TABLE `app_setting` (
  `appid` varchar(48) NOT NULL COMMENT 'ID',
  `a_name` varchar(48) DEFAULT NULL COMMENT '用户名',
  `a_pass` varchar(48) DEFAULT NULL COMMENT '密码',
  `a_card` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `a_tel` varchar(13) DEFAULT NULL COMMENT '手机号',
  `a_store_id` varchar(48) DEFAULT NULL COMMENT '店铺id',
  `a_store_url` varchar(255) DEFAULT NULL COMMENT '店铺地址',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='程序app';

-- ----------------------------
-- Records of app_setting
-- ----------------------------

-- ----------------------------
-- Table structure for `dic_datas`
-- ----------------------------
DROP TABLE IF EXISTS `dic_datas`;
CREATE TABLE `dic_datas` (
  `key_code` varchar(32) NOT NULL COMMENT '字典值',
  `key_name` varchar(32) DEFAULT NULL COMMENT '字典名称',
  `dic_type` varchar(64) NOT NULL COMMENT '字典类型',
  `parent_id` varchar(32) DEFAULT '0' COMMENT '上级结点[parent_id是key_code的父节点]',
  `sort_key` int(11) DEFAULT '0' COMMENT '排序字段',
  `is_used` varchar(1) DEFAULT 'Y' COMMENT '是否被使用',
  `filter` varchar(10) DEFAULT NULL COMMENT '过滤、排序字段',
  PRIMARY KEY (`key_code`,`dic_type`),
  KEY `FK_DIC_TYPE` (`dic_type`),
  CONSTRAINT `FK_DIC_TYPE` FOREIGN KEY (`dic_type`) REFERENCES `dic_info` (`dic_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='下拉数据字典表';

-- ----------------------------
-- Records of dic_datas
-- ----------------------------
INSERT INTO `dic_datas` VALUES ('1', '拟稿', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('1', '绝密', 'MJ', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('2', '核稿', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('2', '秘密', 'MJ', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('3', '待办', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('3', '保密', 'MJ', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('4', '已办', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('5', '待阅', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('6', '已阅', 'DRAFT_STATE', '0', '0', 'Y', null);
INSERT INTO `dic_datas` VALUES ('7', '归档', 'DRAFT_STATE', '0', '0', 'Y', null);

-- ----------------------------
-- Table structure for `dic_info`
-- ----------------------------
DROP TABLE IF EXISTS `dic_info`;
CREATE TABLE `dic_info` (
  `dic_code` varchar(64) NOT NULL COMMENT '字典代码',
  `dic_name` varchar(200) DEFAULT NULL COMMENT '字典名称',
  `dic_type` varchar(2) DEFAULT 'D' COMMENT '字典类型[D:下拉;T:树;SD:sql语句构造下拉;ST:sql语句构造树]',
  `dic_sql` text COMMENT 'sql型语言[符合于形式]',
  `is_sys` varchar(5) DEFAULT '''F''' COMMENT '是否系统字典[T:是;F:否]',
  `sort_key` int(11) DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`dic_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典描述表';

-- ----------------------------
-- Records of dic_info
-- ----------------------------
INSERT INTO `dic_info` VALUES ('DRAFT_APP', '草稿名称', 'SD', 'SELECT\r\n	f.id AS key_value,\r\n	f.ng_title AS key_name,\r\n	\'DRAFT_APP\' AS key_type,\r\n	\'\' AS filter\r\nFROM\r\n	qd_bw_ng_info f\r\nWHERE\r\n	1 = 1', null, null);
INSERT INTO `dic_info` VALUES ('DRAFT_STATE', '草稿状态', 'D', null, null, null);
INSERT INTO `dic_info` VALUES ('MJ', '密级', 'D', null, 'T', null);
INSERT INTO `dic_info` VALUES ('ORG_TREE', '部门树', 'ST', 'SELECT\r\n	f.id AS id,\r\n	f.dept_parent_id AS pid,\r\n	f.id AS key_value,\r\n	f.dept_name AS key_name,\r\n	\'ORG_TREE\' AS key_type\r\nFROM\r\n	oa_department f\r\nWHERE\r\n	1 = 1', 'T', null);
INSERT INTO `dic_info` VALUES ('TYPE_ZD', '字典类型', 'D', null, null, null);

-- ----------------------------
-- Table structure for `ly_buttom`
-- ----------------------------
DROP TABLE IF EXISTS `ly_buttom`;
CREATE TABLE `ly_buttom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `buttom` varchar(200) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_buttom
-- ----------------------------
INSERT INTO `ly_buttom` VALUES ('1', '新增', '<button type=\"button\" id=\"addFun\" class=\"btn btn-primary marR10\">新增</button>', '');
INSERT INTO `ly_buttom` VALUES ('2', '编辑', '<button type=\"button\" id=\"editFun\" class=\"btn btn-info marR10\">编辑</button>', null);
INSERT INTO `ly_buttom` VALUES ('3', '删除', '<button type=\"button\" id=\"delFun\" class=\"btn btn-danger marR10\">删除</button>', null);
INSERT INTO `ly_buttom` VALUES ('4', '上传', '<button type=\"button\" id=\"upLoad\" class=\"btn btn-primary marR10\">上传</button>', null);
INSERT INTO `ly_buttom` VALUES ('5', '下载', '<button type=\"button\" id=\"downLoad\" class=\"btn btn-primary marR10\">下载</button>', null);
INSERT INTO `ly_buttom` VALUES ('6', '上移', '<button type=\"button\" id=\"lyGridUp\" class=\"btn btn-success marR10\">上移</button>', null);
INSERT INTO `ly_buttom` VALUES ('7', '下移', '<button type=\"button\" id=\"lyGridDown\" class=\"btn btn btn-grey marR10\">下移</button>', null);
INSERT INTO `ly_buttom` VALUES ('8', '分配权限', '<button type=\"button\" id=\"permissions\" class=\"btn btn btn-grey marR10\">分配权限</button>', null);

-- ----------------------------
-- Table structure for `ly_log`
-- ----------------------------
DROP TABLE IF EXISTS `ly_log`;
CREATE TABLE `ly_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountName` varchar(30) DEFAULT NULL,
  `module` varchar(30) DEFAULT NULL,
  `methods` varchar(30) DEFAULT NULL,
  `actionTime` varchar(30) DEFAULT NULL,
  `userIP` varchar(30) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_log
-- ----------------------------
INSERT INTO `ly_log` VALUES ('1', 'admin', '系统管理', '用户管理/组管理-修改权限', '66', '127.0.0.1', '2016-08-31 19:40:50', '执行成功!');
INSERT INTO `ly_log` VALUES ('2', 'admin', '系统管理', '用户管理/组管理-修改权限', '22', '127.0.0.1', '2016-08-31 19:41:43', '执行成功!');
INSERT INTO `ly_log` VALUES ('3', 'admin', '系统管理', '资源管理-修改资源', '16', '127.0.0.1', '2016-08-31 20:41:13', '执行成功!');
INSERT INTO `ly_log` VALUES ('4', 'admin', '系统管理', '用户管理-新增用户', '104', '127.0.0.1', '2016-08-31 21:12:16', '执行成功!');
INSERT INTO `ly_log` VALUES ('5', 'admin', '系统管理', '用户管理/组管理-修改权限', '9', '127.0.0.1', '2016-08-31 21:14:22', '执行成功!');
INSERT INTO `ly_log` VALUES ('6', 'admin', '系统管理', '用户管理-修改用户', '160', '127.0.0.1', '2016-09-01 22:30:50', '执行成功!');
INSERT INTO `ly_log` VALUES ('7', 'admin', '系统管理', '用户管理-修改用户', '43816', '127.0.0.1', '2016-09-01 22:43:13', '执行成功!');
INSERT INTO `ly_log` VALUES ('8', 'admin', '系统管理', '组管理-新增组', '47', '127.0.0.1', '2016-09-02 08:54:34', '执行成功!');

-- ----------------------------
-- Table structure for `ly_resources`
-- ----------------------------
DROP TABLE IF EXISTS `ly_resources`;
CREATE TABLE `ly_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `resKey` varchar(50) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `resUrl` varchar(200) DEFAULT NULL,
  `level` int(4) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `ishide` int(3) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_resources
-- ----------------------------
INSERT INTO `ly_resources` VALUES ('1', '系统基础管理', '0', 'system', '0', 'system', '1', 'fa-desktop', '0', '系统基础管理');
INSERT INTO `ly_resources` VALUES ('2', '用户管理', '1', 'account', '1', '/user/list.shtml', '2', null, '0', null);
INSERT INTO `ly_resources` VALUES ('3', '角色管理', '1', 'role', '1', '/role/list.shtml', '7', 'fa-list', '0', '组管理');
INSERT INTO `ly_resources` VALUES ('4', '菜单管理', '1', 'ly_resources', '1', '/resources/list.shtml', '12', 'fa-list-alt', '0', '菜单管理');
INSERT INTO `ly_resources` VALUES ('5', '新增用户', '2', 'account_add', '2', '/user/addUI.shtml', '3', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('6', '修改用户', '2', 'account_edit', '2', '/user/editUI.shtml', '4', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('7', '删除用户', '2', 'account_delete', '2', '/user/deleteById.shtml', '5', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('8', '新增角色', '3', 'role_add', '2', '/role/addUI.shtml', '8', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addRole&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('9', '修改角色', '3', 'role_edit', '2', '/role/editUI.shtml', '9', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editRole&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('10', '删除角色', '3', 'role_delete', '2', '/role/delete.shtml', '10', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delRole&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('11', '分配权限', '3', 'role_perss', '2', '/resources/permissions.shtml', '11', '无', '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;permissions&quot;&nbsp;class=&quot;btn&nbsp;btn&nbsp;btn-grey&nbsp;marR10&quot;&gt;分配权限&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('25', '登陆信息管理', '0', 'ly_login', '0', 'ly_login', '18', 'fa-calendar', '0', '登陆信息管理');
INSERT INTO `ly_resources` VALUES ('26', '用户登录记录', '25', 'ly_log_list', '1', '/userlogin/listUI.shtml', '19', null, '0', '用户登录记录');
INSERT INTO `ly_resources` VALUES ('27', '操作日志管理', '0', 'ly_log', '0', 'ly_log', '20', 'fa-picture-o', '0', '操作日志管理');
INSERT INTO `ly_resources` VALUES ('28', '日志查询', '27', 'ly_log', '1', '/log/list.shtml', '21', null, '0', null);
INSERT INTO `ly_resources` VALUES ('29', '新增菜单资源', '4', 'ly_resources_add', '2', '/resources/addUI.shtml', '13', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addFun&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('30', '修改菜单资源', '4', 'ly_resources_edit', '2', '/resources/editUI.shtml', '14', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editFun&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('31', '删除菜单资源', '4', 'ly_resources_delete', '2', '/resources/delete.shtml', '15', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delFun&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('32', '系统监控管理', '0', 'monitor', '0', 'monitor', '16', 'fa-tag', '0', '系统监控管理');
INSERT INTO `ly_resources` VALUES ('33', '实时监控', '32', 'sysmonitor', '1', '/monitor/monitor.shtml', '17', null, '0', '实时监控');
INSERT INTO `ly_resources` VALUES ('34', '分配权限', '2', 'permissions', '2', '/resources/permissions.shtml', '6', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;permissions&quot;&nbsp;class=&quot;btn&nbsp;btn&nbsp;btn-grey&nbsp;marR10&quot;&gt;分配权限&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('35', '告警列表', '32', 'monitor_warn', '1', '/monitor/list.shtml', null, null, '0', '告警列表');

-- ----------------------------
-- Table structure for `ly_res_user`
-- ----------------------------
DROP TABLE IF EXISTS `ly_res_user`;
CREATE TABLE `ly_res_user` (
  `resId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`resId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_res_user
-- ----------------------------
INSERT INTO `ly_res_user` VALUES ('25', '1');
INSERT INTO `ly_res_user` VALUES ('26', '1');
INSERT INTO `ly_res_user` VALUES ('1', '2');
INSERT INTO `ly_res_user` VALUES ('2', '2');
INSERT INTO `ly_res_user` VALUES ('3', '2');
INSERT INTO `ly_res_user` VALUES ('4', '2');
INSERT INTO `ly_res_user` VALUES ('5', '2');
INSERT INTO `ly_res_user` VALUES ('6', '2');
INSERT INTO `ly_res_user` VALUES ('7', '2');
INSERT INTO `ly_res_user` VALUES ('8', '2');
INSERT INTO `ly_res_user` VALUES ('9', '2');
INSERT INTO `ly_res_user` VALUES ('10', '2');
INSERT INTO `ly_res_user` VALUES ('11', '2');
INSERT INTO `ly_res_user` VALUES ('29', '2');
INSERT INTO `ly_res_user` VALUES ('30', '2');
INSERT INTO `ly_res_user` VALUES ('31', '2');
INSERT INTO `ly_res_user` VALUES ('32', '2');
INSERT INTO `ly_res_user` VALUES ('33', '2');
INSERT INTO `ly_res_user` VALUES ('34', '2');
INSERT INTO `ly_res_user` VALUES ('35', '2');
INSERT INTO `ly_res_user` VALUES ('1', '3');
INSERT INTO `ly_res_user` VALUES ('2', '3');
INSERT INTO `ly_res_user` VALUES ('3', '3');
INSERT INTO `ly_res_user` VALUES ('4', '3');
INSERT INTO `ly_res_user` VALUES ('5', '3');
INSERT INTO `ly_res_user` VALUES ('6', '3');
INSERT INTO `ly_res_user` VALUES ('7', '3');
INSERT INTO `ly_res_user` VALUES ('8', '3');
INSERT INTO `ly_res_user` VALUES ('9', '3');
INSERT INTO `ly_res_user` VALUES ('10', '3');
INSERT INTO `ly_res_user` VALUES ('11', '3');
INSERT INTO `ly_res_user` VALUES ('25', '3');
INSERT INTO `ly_res_user` VALUES ('26', '3');
INSERT INTO `ly_res_user` VALUES ('27', '3');
INSERT INTO `ly_res_user` VALUES ('28', '3');
INSERT INTO `ly_res_user` VALUES ('29', '3');
INSERT INTO `ly_res_user` VALUES ('30', '3');
INSERT INTO `ly_res_user` VALUES ('31', '3');
INSERT INTO `ly_res_user` VALUES ('32', '3');
INSERT INTO `ly_res_user` VALUES ('33', '3');
INSERT INTO `ly_res_user` VALUES ('34', '3');
INSERT INTO `ly_res_user` VALUES ('35', '3');
INSERT INTO `ly_res_user` VALUES ('1', '4');
INSERT INTO `ly_res_user` VALUES ('2', '4');
INSERT INTO `ly_res_user` VALUES ('3', '4');
INSERT INTO `ly_res_user` VALUES ('4', '4');
INSERT INTO `ly_res_user` VALUES ('5', '4');
INSERT INTO `ly_res_user` VALUES ('6', '4');
INSERT INTO `ly_res_user` VALUES ('7', '4');
INSERT INTO `ly_res_user` VALUES ('8', '4');
INSERT INTO `ly_res_user` VALUES ('9', '4');
INSERT INTO `ly_res_user` VALUES ('10', '4');
INSERT INTO `ly_res_user` VALUES ('11', '4');
INSERT INTO `ly_res_user` VALUES ('25', '4');
INSERT INTO `ly_res_user` VALUES ('26', '4');
INSERT INTO `ly_res_user` VALUES ('27', '4');
INSERT INTO `ly_res_user` VALUES ('28', '4');
INSERT INTO `ly_res_user` VALUES ('29', '4');
INSERT INTO `ly_res_user` VALUES ('30', '4');
INSERT INTO `ly_res_user` VALUES ('31', '4');
INSERT INTO `ly_res_user` VALUES ('32', '4');
INSERT INTO `ly_res_user` VALUES ('33', '4');
INSERT INTO `ly_res_user` VALUES ('34', '4');
INSERT INTO `ly_res_user` VALUES ('35', '4');

-- ----------------------------
-- Table structure for `ly_role`
-- ----------------------------
DROP TABLE IF EXISTS `ly_role`;
CREATE TABLE `ly_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `state` varchar(3) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `roleKey` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_role
-- ----------------------------
INSERT INTO `ly_role` VALUES ('1', '0', '管理员', 'admin', '管理员');
INSERT INTO `ly_role` VALUES ('2', '0', '普通角色', 'simple', '普通角色');
INSERT INTO `ly_role` VALUES ('3', '0', '超级管理员', 'SUPER', '超级管理员');
INSERT INTO `ly_role` VALUES ('4', '0', '系统维护', 'weihu', '系统维护角色');

-- ----------------------------
-- Table structure for `ly_server_info`
-- ----------------------------
DROP TABLE IF EXISTS `ly_server_info`;
CREATE TABLE `ly_server_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cpuUsage` varchar(255) DEFAULT NULL,
  `setCpuUsage` varchar(255) DEFAULT NULL,
  `jvmUsage` varchar(255) DEFAULT NULL,
  `setJvmUsage` varchar(255) DEFAULT NULL,
  `ramUsage` varchar(255) DEFAULT NULL,
  `setRamUsage` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_server_info
-- ----------------------------
INSERT INTO `ly_server_info` VALUES ('5', '18', '40', '49', '40', '71', '40', '121261494@qq.com', '2015-04-25 18:07:02', '<font color=\"red\">JVM当前：49%,超出预设值 40%<br>内存当前：71%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('6', '3', '40', '50', '40', '71', '40', '121261494@qq.com', '2015-04-25 18:08:03', '<font color=\"red\">JVM当前：50%,超出预设值 40%<br>内存当前：71%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('7', '5', '40', '50', '40', '70', '40', '121261494@qq.com', '2015-04-25 18:09:02', '<font color=\"red\">JVM当前：50%,超出预设值 40%<br>内存当前：70%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('8', '5', '40', '52', '40', '69', '40', '121261494@qq.com', '2015-04-25 18:10:03', '<font color=\"red\">JVM当前：52%,超出预设值 40%<br>内存当前：69%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('9', '2', '40', '52', '40', '68', '40', '121261494@qq.com', '2015-04-25 18:11:02', '<font color=\"red\">JVM当前：52%,超出预设值 40%<br>内存当前：68%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('10', '7', '40', '53', '40', '67', '40', '121261494@qq.com', '2015-04-25 18:12:02', '<font color=\"red\">JVM当前：53%,超出预设值 40%<br>内存当前：67%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('11', '5', '40', '54', '40', '67', '40', '121261494@qq.com', '2015-04-25 18:13:02', '<font color=\"red\">JVM当前：54%,超出预设值 40%<br>内存当前：67%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('12', '16', '40', '55', '40', '66', '40', '121261494@qq.com', '2015-04-25 18:14:02', '<font color=\"red\">JVM当前：55%,超出预设值 40%<br>内存当前：66%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('13', '5', '40', '56', '40', '65', '40', '121261494@qq.com', '2015-04-25 18:15:02', '<font color=\"red\">JVM当前：56%,超出预设值 40%<br>内存当前：65%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('14', '8', '40', '57', '40', '64', '40', '121261494@qq.com', '2015-04-25 18:16:02', '<font color=\"red\">JVM当前：57%,超出预设值 40%<br>内存当前：64%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('15', '3', '40', '58', '40', '63', '40', '121261494@qq.com', '2015-04-25 18:17:02', '<font color=\"red\">JVM当前：58%,超出预设值 40%<br>内存当前：63%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('16', '6', '40', '59', '40', '62', '40', '121261494@qq.com', '2015-04-25 18:18:03', '<font color=\"red\">JVM当前：59%,超出预设值 40%<br>内存当前：62%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('17', '1', '40', '60', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:19:02', '<font color=\"red\">JVM当前：60%,超出预设值 40%<br>内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('18', '5', '40', '61', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:20:02', '<font color=\"red\">JVM当前：61%,超出预设值 40%<br>内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('19', '5', '40', '38', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:21:02', '<font color=\"red\">内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('20', '5', '40', '39', '40', '60', '40', '121261494@qq.com', '2015-04-25 18:22:02', '<font color=\"red\">内存当前：60%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('21', '4', '40', '40', '40', '59', '40', '121261494@qq.com', '2015-04-25 18:23:02', '<font color=\"red\">内存当前：59%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('22', '32', '80', '41', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:43:05', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('23', '55', '80', '55', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:50:03', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('24', '13', '80', '53', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:59:08', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('25', '85', '80', '58', '80', '72', '80', '121261494@qq.com', '2015-04-26 02:46:06', '<font color=\"red\">CPU当前：85%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('26', '34', '80', '59', '80', '81', '80', '121261494@qq.com', '2015-04-27 00:29:06', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('27', '92', '80', '47', '80', '64', '80', '121261494@qq.com', '2015-04-27 00:44:07', '<font color=\"red\">CPU当前：92%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('28', '85', '80', '49', '80', '68', '80', '121261494@qq.com', '2015-04-27 23:38:04', '<font color=\"red\">CPU当前：85%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('29', '94', '80', '69', '80', '73', '80', '121261494@qq.com', '2015-04-28 01:35:03', '<font color=\"red\">CPU当前：94%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('30', '6', '80', '43', '80', '87', '80', '121261494@qq.com', '2015-05-09 00:00:08', '<font color=\"red\">内存当前：87%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('31', '88', '80', '59', '80', '87', '80', '121261494@qq.com', '2015-05-09 00:01:14', '<font color=\"red\">CPU当前：88%,超出预设值  80%<br>内存当前：87%,超出预设值  80%</font>');

-- ----------------------------
-- Table structure for `ly_user`
-- ----------------------------
DROP TABLE IF EXISTS `ly_user`;
CREATE TABLE `ly_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `credentialsSalt` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `locked` varchar(3) DEFAULT '0',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletestatus` int(1) DEFAULT '0' COMMENT '逻辑删除状态0:存在1:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_user
-- ----------------------------
INSERT INTO `ly_user` VALUES ('1', '蓝缘', 'simple', '78e21a6eb88529eab722793a448ed394', '4157c3feef4a6ed91b2c28cf4392f2d1', '0123', '1', '2016-09-01 22:30:50', '0');
INSERT INTO `ly_user` VALUES ('2', '超级管理员', 'ROOT', '78e21a6eb88529eab722793a448ed394', '4157c3feef4a6ed91b2c28cf4392f2d1', '0000', '1', '2015-05-23 17:39:37', '0');
INSERT INTO `ly_user` VALUES ('3', '管理员', 'admin', '85451aef43883ca6e050551e071afa5b', '76b36d2c2cf0aaecd88b6b6cd171f04e', '3434', '1', '2016-09-01 17:02:50', '0');
INSERT INTO `ly_user` VALUES ('4', '王俊伟', 'june', 'b2011b779d699018cc1e6d5c131c95ed', 'f3b0f669608e1f6be7e1bcd1c65b599a', '王俊伟', '1', '2016-08-31 21:12:16', '0');

-- ----------------------------
-- Table structure for `ly_userlogin`
-- ----------------------------
DROP TABLE IF EXISTS `ly_userlogin`;
CREATE TABLE `ly_userlogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `loginTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginIP` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_loginlist` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_userlogin
-- ----------------------------
INSERT INTO `ly_userlogin` VALUES ('143', '3', 'admin', '2016-01-04 10:07:58', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('144', '3', 'admin', '2016-01-04 11:45:40', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('145', '3', 'admin', '2016-01-04 18:07:23', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('146', '3', 'admin', '2016-08-31 19:28:22', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('147', '4', 'june', '2016-08-31 21:13:02', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('148', '3', 'admin', '2016-08-31 21:13:41', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('149', '4', 'june', '2016-08-31 21:14:37', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('150', '3', 'admin', '2016-08-31 21:35:36', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('151', '3', 'admin', '2016-09-01 10:42:46', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('152', '3', 'admin', '2016-09-01 16:41:08', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('153', '3', 'admin', '2016-09-01 17:01:47', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('154', '3', 'admin', '2016-09-01 17:02:31', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('155', '3', 'admin', '2016-09-01 17:03:02', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('156', '3', 'admin', '2016-09-01 17:03:13', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('157', '3', 'admin', '2016-09-01 17:03:19', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('158', '3', 'admin', '2016-09-01 17:03:37', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('159', '3', 'admin', '2016-09-01 18:23:27', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('160', '3', 'admin', '2016-09-01 22:10:24', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('161', '3', 'admin', '2016-09-01 22:24:07', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('162', '3', 'admin', '2016-09-02 08:53:18', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('163', '3', 'admin', '2016-09-02 08:59:09', '127.0.0.1');

-- ----------------------------
-- Table structure for `ly_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `ly_user_role`;
CREATE TABLE `ly_user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_user_role
-- ----------------------------
INSERT INTO `ly_user_role` VALUES ('1', '2');
INSERT INTO `ly_user_role` VALUES ('2', '3');
INSERT INTO `ly_user_role` VALUES ('3', '1');
INSERT INTO `ly_user_role` VALUES ('4', '1');
INSERT INTO `ly_user_role` VALUES ('4', '2');
INSERT INTO `ly_user_role` VALUES ('4', '3');

-- ----------------------------
-- Table structure for `sys_andorra`
-- ----------------------------
DROP TABLE IF EXISTS `sys_andorra`;
CREATE TABLE `sys_andorra` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '广告ID',
  `title` varchar(200) DEFAULT NULL COMMENT '广告标题',
  `content` varchar(200) DEFAULT NULL COMMENT '广告内容',
  `type` char(2) DEFAULT NULL COMMENT '广告类型  0为默认文字广告，1为图片广告',
  `adurl` varchar(200) DEFAULT NULL COMMENT '广告图片地址',
  `publisher` varchar(50) DEFAULT NULL COMMENT '广告发布人',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `uptime` datetime DEFAULT NULL COMMENT '修改时间',
  `starttime` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `endtime` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `status` char(2) DEFAULT '0' COMMENT '状态  0为默认未启用，1为启用',
  `tourl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_andorra
-- ----------------------------
INSERT INTO `sys_andorra` VALUES ('2', 'dddd', '<p>dddd</p>', '1', '286787ecf43449518b92fb3f04361cab.jpg', 'ssss', '2015-04-19 02:58:21', '2015-04-19 02:58:21', '2015-04-01', '2015-03-31', '1', 'dddd');

-- ----------------------------
-- Table structure for `sys_app_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_user`;
CREATE TABLE `sys_app_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of sys_app_user
-- ----------------------------
INSERT INTO `sys_app_user` VALUES ('04762c0b28b643939455c7800c2e2412', 'hy001', 'f1290186a5d0b1ceab27f4e77c0c5d68', 'w', '', '55896f5ce3c0494fa6850775a4e29ff6', '', '', '1', '', '18766666666', '', '', '', '0', '001', '18766666666@qq.com');

-- ----------------------------
-- Table structure for `sys_dictionaries`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionaries`;
CREATE TABLE `sys_dictionaries` (
  `ZD_ID` varchar(100) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `BIANMA` varchar(100) DEFAULT NULL,
  `ORDY_BY` int(10) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `JB` int(10) DEFAULT NULL,
  `P_BM` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ZD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of sys_dictionaries
-- ----------------------------
INSERT INTO `sys_dictionaries` VALUES ('14b65e2c42ca44bdb6d0d1543f7621c0', '李沧区', 'LCQ', '6', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_LCQ');
INSERT INTO `sys_dictionaries` VALUES ('212a6765fddc4430941469e1ec8c8e6c', '人事部', 'RSB', '1', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_RSB');
INSERT INTO `sys_dictionaries` VALUES ('22578c76ae13435d81acbef3830e751d', '重庆', 'ZQ', '6', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_ZQ');
INSERT INTO `sys_dictionaries` VALUES ('367b43e776394e3e9538a9aec76284ee', '四方区', 'SFQ', '3', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_SFQ');
INSERT INTO `sys_dictionaries` VALUES ('38074479154a4e5a86c0b3ac2327f6d9', '高新区', 'GXQ', '4', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_GXQ');
INSERT INTO `sys_dictionaries` VALUES ('3cec73a7cc8a4cb79e3f6ccc7fc8858c', '行政部', '002', '2', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_002');
INSERT INTO `sys_dictionaries` VALUES ('3ff791bbc412421d89a08d4898ce27a2', '贵州', 'GZ', '9', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_GZ');
INSERT INTO `sys_dictionaries` VALUES ('45c14e5073de467ba354b700d644665f', '烟台', 'YT', '2', 'dd48e94f6090419b8110279d1eacab75', '3', 'SD_YT');
INSERT INTO `sys_dictionaries` VALUES ('48724375640341deb5ef01ac51a89c34', '北京', 'BJ', '1', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_BJ');
INSERT INTO `sys_dictionaries` VALUES ('50b40fd70eac416f8dcd70d07bd3f460', '崂山区', 'LSQ', '5', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_LSQ');
INSERT INTO `sys_dictionaries` VALUES ('58a44022666443caa7a53aa61d7bd61c', '新疆', 'XJ', '7', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_XJ');
INSERT INTO `sys_dictionaries` VALUES ('5a1547632cca449db378fbb9a042b336', '研发部', '004', '4', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_004');
INSERT INTO `sys_dictionaries` VALUES ('5bf5cd32e34549f092eaa2bafcda60bc', '河南', 'HN2', '5', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_HN2');
INSERT INTO `sys_dictionaries` VALUES ('7069d0be8e244cb5bb27d54ccffef015', '湖南', 'HN', '4', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_HN');
INSERT INTO `sys_dictionaries` VALUES ('7930620ac75c4f3cbf3266c185f985b0', '山西', 'SX', '12', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_SX');
INSERT INTO `sys_dictionaries` VALUES ('7f9cd74e60a140b0aea5095faa95cda3', '财务部', '003', '3', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_003');
INSERT INTO `sys_dictionaries` VALUES ('8644909708d945d9a950b0f9cdd154a6', '市南区', 'SNQ', '0', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_SNQ');
INSERT INTO `sys_dictionaries` VALUES ('97639d263f2c47a8905b5305af59c314', '西藏', 'XZ', '10', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_XZ');
INSERT INTO `sys_dictionaries` VALUES ('a8ef210da43a4d42b2f51309d88e86cc', '江西', 'JX', '11', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_JX');
INSERT INTO `sys_dictionaries` VALUES ('b08e0e02ecd340c39e4ce84c8c1d2b9f', '青海', 'QH', '8', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_QH');
INSERT INTO `sys_dictionaries` VALUES ('b861bd1c3aba4934acdb5054dd0d0c6e', '科技部', 'KJB', '7', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_KJB');
INSERT INTO `sys_dictionaries` VALUES ('c067fdaf51a141aeaa56ed26b70de863', '部门', 'BM', '1', '0', '1', 'BM');
INSERT INTO `sys_dictionaries` VALUES ('c55f3d2abc6940a0aaeca5252763c134', '城阳区', 'CYQ', '2', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_CYQ');
INSERT INTO `sys_dictionaries` VALUES ('cdba0b5ef20e4fc0a5231fa3e9ae246a', '地区', 'DQ', '2', '0', '1', 'DQ');
INSERT INTO `sys_dictionaries` VALUES ('d1a2cd2669cd45ffa659278be2e21a7a', '青岛', 'QD', '1', 'dd48e94f6090419b8110279d1eacab75', '3', 'SD_QD');
INSERT INTO `sys_dictionaries` VALUES ('dd48e94f6090419b8110279d1eacab75', '山东', 'SD', '3', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_SD');
INSERT INTO `sys_dictionaries` VALUES ('eeb39c4b14fa4952b1c18f7b1cef5eeb', '市北区', 'SBQ', '1', 'd1a2cd2669cd45ffa659278be2e21a7a', '4', 'QD_SBQ');
INSERT INTO `sys_dictionaries` VALUES ('efaa777eb21b4a328f884f4fe3afa2ef', '济南', 'JN', '3', 'dd48e94f6090419b8110279d1eacab75', '3', 'SD_JN');
INSERT INTO `sys_dictionaries` VALUES ('f184bff5081d452489271a1bd57599ed', '上海', 'SH', '2', 'cdba0b5ef20e4fc0a5231fa3e9ae246a', '2', 'DQ_SH');
INSERT INTO `sys_dictionaries` VALUES ('f30bf95e216d4ebb8169ff0c86330b8f', '客服部', '006', '6', 'c067fdaf51a141aeaa56ed26b70de863', '2', 'BM_006');

-- ----------------------------
-- Table structure for `sys_featured`
-- ----------------------------
DROP TABLE IF EXISTS `sys_featured`;
CREATE TABLE `sys_featured` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '特别推荐ID',
  `title` varchar(200) DEFAULT NULL COMMENT '特别推荐标题',
  `content` varchar(300) DEFAULT NULL COMMENT '特别推荐内容',
  `url` varchar(300) DEFAULT NULL COMMENT '特别推荐连接地址',
  `heat` char(2) DEFAULT '0' COMMENT '热度  按1 2 3 4 5级',
  `stars` char(2) DEFAULT '0' COMMENT '星级  按1 2 3 4 5级',
  `sequence` int(10) DEFAULT '0' COMMENT '排序',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `uptime` datetime DEFAULT NULL COMMENT '修改时间',
  `status` char(2) DEFAULT '0' COMMENT '状态 0为未启用，1为启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_featured
-- ----------------------------
INSERT INTO `sys_featured` VALUES ('1', 'ssss', '<p>ssss</p>', 'ssss', '1', '1', '22323', '2015-04-19 02:59:11', '2015-04-19 02:59:11', '0');

-- ----------------------------
-- Table structure for `sys_gl_qx`
-- ----------------------------
DROP TABLE IF EXISTS `sys_gl_qx`;
CREATE TABLE `sys_gl_qx` (
  `GL_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `FX_QX` int(10) DEFAULT NULL,
  `FW_QX` int(10) DEFAULT NULL,
  `QX1` int(10) DEFAULT NULL,
  `QX2` int(10) DEFAULT NULL,
  `QX3` int(10) DEFAULT NULL,
  `QX4` int(10) DEFAULT NULL,
  PRIMARY KEY (`GL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_gl_qx
-- ----------------------------
INSERT INTO `sys_gl_qx` VALUES ('1', '2', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('2', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_gl_qx` VALUES ('2b05ec4eb409416aa02b45f65dd67570', '6', '1', '1', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '7', '1', '1', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '7', '0', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('7cb2ffef0947430dbf6a13568e604631', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('7dfd8d1f7b6245d283217b7e63eec9b2', '1', '0', '1', '1', '0', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '7', '1', '0', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '6', '1', '1', '1', '1', '0', '0');
INSERT INTO `sys_gl_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '7', '0', '0', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for `sys_link`
-- ----------------------------
DROP TABLE IF EXISTS `sys_link`;
CREATE TABLE `sys_link` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '友情链接ID',
  `stiename` varchar(100) DEFAULT NULL COMMENT '友情链接网站名称',
  `sitecontent` varchar(200) DEFAULT NULL COMMENT '友情链接网站内容',
  `type` char(2) DEFAULT '0' COMMENT '类型  0为文字连接，1为图片连接',
  `stieurl` varchar(200) DEFAULT NULL COMMENT '图片连接地址',
  `addtime` varchar(50) DEFAULT NULL COMMENT '添加时间',
  `uptime` varchar(50) DEFAULT NULL COMMENT '修改时间',
  `status` char(2) DEFAULT '0' COMMENT '状态  0为未启用，1为启用',
  `sequence` int(10) DEFAULT NULL COMMENT '排序',
  `tourl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_link
-- ----------------------------
INSERT INTO `sys_link` VALUES ('1', 'sdfsd2222', '<p>sdfsd222</p>', '1', 'acf1784d058149d3a1b6349f5c89d208.png', '2014-12-02 13:49:59', '2014-12-02 13:53:55', '0', '3', 'sdf222');
INSERT INTO `sys_link` VALUES ('2', 'sdfs', '<p>sdfsdf</p>', '0', '438994ecc7fe42539db7daa2b9b0a9d0.png', '2015-04-19 03:00:49', '2015-04-19 03:00:49', '0', '2', 'sdfsdf');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(30) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '#', '0', '1', 'icon-desktop', '1');
INSERT INTO `sys_menu` VALUES ('2', '组织管理', 'role.do', '1', '2', null, '1');
INSERT INTO `sys_menu` VALUES ('4', '会员管理', 'happuser/listUsers.do', '1', '4', null, '1');
INSERT INTO `sys_menu` VALUES ('5', '系统用户', 'user/listUsers.do', '1', '3', null, '1');
INSERT INTO `sys_menu` VALUES ('6', '信息管理', '#', '0', '2', 'icon-list-alt', '2');
INSERT INTO `sys_menu` VALUES ('7', '图片管理', 'pictures/list.do', '6', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('8', '性能监控', 'druid/index.html', '9', '1', null, '1');
INSERT INTO `sys_menu` VALUES ('9', '系统工具', '#', '0', '3', 'icon-th', '1');
INSERT INTO `sys_menu` VALUES ('10', '接口测试', 'tool/interfaceTest.do', '9', '2', null, '1');
INSERT INTO `sys_menu` VALUES ('11', '发送邮件', 'tool/goSendEmail.do', '9', '3', null, '1');
INSERT INTO `sys_menu` VALUES ('12', '置二维码', 'tool/goTwoDimensionCode.do', '9', '4', null, '1');
INSERT INTO `sys_menu` VALUES ('13', '多级别树', 'tool/ztree.do', '9', '5', null, '1');
INSERT INTO `sys_menu` VALUES ('14', '地图工具', 'tool/map.do', '9', '6', null, '1');
INSERT INTO `sys_menu` VALUES ('15', '广告管理', 'andorra/list.do', '6', '2', null, '2');
INSERT INTO `sys_menu` VALUES ('16', '特别推荐', 'featured/list.do', '6', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('17', '线路管理', 'line/list.do', '6', '4', null, '2');
INSERT INTO `sys_menu` VALUES ('18', '友情链接', 'link/list.do', '6', '6', null, '2');
INSERT INTO `sys_menu` VALUES ('19', '新闻管理', 'news/list.do', '6', '7', null, '2');
INSERT INTO `sys_menu` VALUES ('20', '公告管理', 'notice/list.do', '6', '8', null, '2');
INSERT INTO `sys_menu` VALUES ('21', '淘宝数据管理', '#', '0', '4', 'icon-calendar', '2');
INSERT INTO `sys_menu` VALUES ('22', '商铺', 'taobao/store/list.do', '21', '1', null, '2');
INSERT INTO `sys_menu` VALUES ('23', '会员', 'taobao/member/list.do', '21', '2', null, '2');
INSERT INTO `sys_menu` VALUES ('24', '商品分类', 'taobao/goods/type/list.do', '21', '3', null, '2');
INSERT INTO `sys_menu` VALUES ('25', '我得商品', 'taobao/goods/my/list.do', '21', '4', null, '2');
INSERT INTO `sys_menu` VALUES ('26', '其他店铺商品', 'taobao/goods/others/list.do', '21', '5', null, '2');
INSERT INTO `sys_menu` VALUES ('27', '应用设置', 'taobao/app/setting/list.do', '21', '6', null, '2');
INSERT INTO `sys_menu` VALUES ('28', '通用字典', 'dic/dicinfo.do', '9', '7', null, '1');

-- ----------------------------
-- Table structure for `sys_news`
-- ----------------------------
DROP TABLE IF EXISTS `sys_news`;
CREATE TABLE `sys_news` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
  `title` varchar(150) DEFAULT NULL COMMENT '新闻标题',
  `content` text COMMENT '新闻内容',
  `publisher` varchar(50) DEFAULT NULL COMMENT '发布人',
  `addtime` varchar(50) DEFAULT NULL COMMENT '发布时间',
  `uptime` varchar(50) DEFAULT NULL COMMENT '修改时间',
  `pip` varchar(50) DEFAULT NULL COMMENT '发布IP',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `sequence` int(10) DEFAULT '0' COMMENT '排序',
  `recommand` char(2) DEFAULT '0' COMMENT '推荐  0默认未推荐，1推荐',
  `status` char(2) DEFAULT '0' COMMENT '状态  0默认未发布，1发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_news
-- ----------------------------
INSERT INTO `sys_news` VALUES ('2', '新闻标题2', '<p>新闻内容2</p>', '张三2', '2014-12-01 20:59:33', '2015-02-08 23:51:26', '127.0.0.1', '0', '2', '1', '1');
INSERT INTO `sys_news` VALUES ('3', '世界大事件', '<p>wwww</p>', 'fdgf', '2014-12-02 01:07:41', '2015-04-19 03:02:29', '127.0.0.1', '0', '0', '0', '1');
INSERT INTO `sys_news` VALUES ('5', '新闻三十分', '<p>4565656</p>', '456465', '2014-12-15 11:38:59', '2015-04-19 03:01:58', '127.0.0.1', '0', '4564', '0', '1');
INSERT INTO `sys_news` VALUES ('6', '国家主席', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0024.gif\"/></p>', 'ddddd', '2014-12-24 10:55:34', '2015-04-19 03:02:40', '127.0.0.1', '0', '0', '0', '1');
INSERT INTO `sys_news` VALUES ('7', '足球新闻部', '<p>sdfs</p>', 'sdf', '2015-04-19 03:01:06', '2015-04-19 03:02:13', '127.0.0.1', '0', '3', '0', '0');

-- ----------------------------
-- Table structure for `sys_notice`
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(200) NOT NULL COMMENT '公告标题',
  `content` varchar(500) NOT NULL COMMENT '公告内容',
  `publisher` varchar(50) NOT NULL COMMENT '公告发布人',
  `addtime` datetime NOT NULL COMMENT '公告发布时间',
  `uptime` datetime NOT NULL COMMENT '修改时间',
  `status` char(2) NOT NULL DEFAULT '0' COMMENT '状态  0默认未启用，1启用',
  `sequence` int(10) DEFAULT '0' COMMENT '公告排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('2', 'ww1', 'www2', 'www3', '2014-12-01 21:39:13', '2014-12-01 21:39:20', '1', '1');
INSERT INTO `sys_notice` VALUES ('3', 'sdf', '<p>sdfs</p>', 'dfsd', '2015-04-19 03:01:15', '2015-04-19 03:01:15', '0', '44');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL COMMENT '角色ID',
  `ROLE_NAME` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `RIGHTS` varchar(255) DEFAULT NULL COMMENT '权限',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `ADD_QX` varchar(255) DEFAULT NULL COMMENT '添加权限',
  `DEL_QX` varchar(255) DEFAULT NULL COMMENT '删除权限',
  `EDIT_QX` varchar(255) DEFAULT NULL COMMENT '编辑权限',
  `CHA_QX` varchar(255) DEFAULT NULL COMMENT '查询权限',
  `QX_ID` varchar(100) DEFAULT NULL COMMENT '权限ID',
  `PX_ZD` int(11) DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '536870902', '0', '1', '1', '1', '1', '1', '0');
INSERT INTO `sys_role` VALUES ('2', '超级管理员', '536870902', '1', '268435446', '266338354', '266338354', '266338534', '2', '1');
INSERT INTO `sys_role` VALUES ('2b05ec4eb409416aa02b45f65dd67570', '普通客户', '266338304', '6', '0', '0', '0', '0', '2b05ec4eb409416aa02b45f65dd67570', '1');
INSERT INTO `sys_role` VALUES ('4', '用户组', '118', '0', '0', '0', '0', '0', null, '1');
INSERT INTO `sys_role` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '特级会员', '498', '7', '0', '0', '0', '0', '55896f5ce3c0494fa6850775a4e29ff6', '0');
INSERT INTO `sys_role` VALUES ('6', '客户组', '18', '0', '1', '1', '1', '1', null, '2');
INSERT INTO `sys_role` VALUES ('68f23fc0caee475bae8d52244dea8444', '中级会员', '498', '7', '0', '0', '0', '0', '68f23fc0caee475bae8d52244dea8444', '2');
INSERT INTO `sys_role` VALUES ('7', '会员组', '498', '0', '0', '0', '0', '1', null, '3');
INSERT INTO `sys_role` VALUES ('7cb2ffef0947430dbf6a13568e604631', '临时用户', '458816', '4', '0', '0', '0', '0', '7cb2ffef0947430dbf6a13568e604631', '0');
INSERT INTO `sys_role` VALUES ('7dfd8d1f7b6245d283217b7e63eec9b2', '管理员B', '536870902', '1', '246', '0', '0', '266338304', '7dfd8d1f7b6245d283217b7e63eec9b2', '3');
INSERT INTO `sys_role` VALUES ('ac66961adaa2426da4470c72ffeec117', '管理员A', '536870902', '1', '54', '54', '0', '246', 'ac66961adaa2426da4470c72ffeec117', '2');
INSERT INTO `sys_role` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '高级会员', '498', '7', '0', '0', '0', '0', 'b0c77c29dfa140dc9b14a29c056f824f', '1');
INSERT INTO `sys_role` VALUES ('e74f713314154c35bd7fc98897859fe3', '黄金客户', '266338322', '6', '1', '1', '1', '1', 'e74f713314154c35bd7fc98897859fe3', '0');
INSERT INTO `sys_role` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '初级会员', '498', '7', '1', '1', '1', '1', 'f944a9df72634249bbcb8cb73b0c9b86', '3');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('089d664844f8441499955b3701696fc0', 'fushide', 'daecb339f3ef1349a5cbe44f41007f7b4b066415', '富师德', '', '2', '2016-08-18 14:58:12', '127.0.0.1', '0', '18629359', 'default', 'asdadf@qq.com', '1231', '18766666666');
INSERT INTO `sys_user` VALUES ('0b3f2ab1896b47c097a81d322697446a', 'zhangsan', '90d7598650c36543faf9400d142203758cc198cb', '张三', '', '2', '2016-08-18 14:57:16', '127.0.0.1', '0', '小张', 'default', 'wwwwq@qq.com', '1101', '18788888888');
INSERT INTO `sys_user` VALUES ('0e2da7c372e147a0b67afdf4cdd444a3', 'lisi', '9245d558faadade47fdd116b15b5016d14cc9a91', '李四', '', 'e74f713314154c35bd7fc98897859fe3', '2016-08-18 14:51:36', '127.0.0.1', '0', 'ff', 'default', 'q324@qq.com', '002', '18767676767');
INSERT INTO `sys_user` VALUES ('1', 'admin', '74d7c8a3426acbbfabfdc457ab44d14332388033', '系统管理员', '1133671055321055258374707980945218933803269864762743594642571294', '1', '2016-09-04 19:08:10', '127.0.0.1', '0', '最高统治者', 'skin-1', 'admin@main.com', '001', '18788888888');

-- ----------------------------
-- Table structure for `sys_user_qx`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_qx`;
CREATE TABLE `sys_user_qx` (
  `U_ID` varchar(100) NOT NULL,
  `C1` int(10) DEFAULT NULL,
  `C2` int(10) DEFAULT NULL,
  `C3` int(10) DEFAULT NULL,
  `C4` int(10) DEFAULT NULL,
  `Q1` int(10) DEFAULT NULL,
  `Q2` int(10) DEFAULT NULL,
  `Q3` int(10) DEFAULT NULL,
  `Q4` int(10) DEFAULT NULL,
  PRIMARY KEY (`U_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_qx
-- ----------------------------
INSERT INTO `sys_user_qx` VALUES ('1', '1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('2', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_user_qx` VALUES ('2b05ec4eb409416aa02b45f65dd67570', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('55896f5ce3c0494fa6850775a4e29ff6', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('68f23fc0caee475bae8d52244dea8444', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('7cb2ffef0947430dbf6a13568e604631', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('7dfd8d1f7b6245d283217b7e63eec9b2', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('ac66961adaa2426da4470c72ffeec117', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('b0c77c29dfa140dc9b14a29c056f824f', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('e74f713314154c35bd7fc98897859fe3', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user_qx` VALUES ('f944a9df72634249bbcb8cb73b0c9b86', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `tb_goods`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
  `appid` varchar(48) NOT NULL COMMENT '商品ID',
  `g_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `g_code` varchar(60) DEFAULT NULL COMMENT '商品编码',
  `g_url` varchar(255) DEFAULT NULL COMMENT '商品链接',
  `g_price` float DEFAULT '0' COMMENT '商品售卖价格',
  `g_price_2` float DEFAULT '0' COMMENT '商品原始价格',
  `g_free` float DEFAULT '0' COMMENT '运费',
  `g_number` int(11) DEFAULT '0' COMMENT '商品备货量',
  `g_remark` int(11) DEFAULT '0' COMMENT '被评论数量',
  `g_sold` int(11) DEFAULT '0' COMMENT '已售数量',
  `g_store_id` varchar(48) DEFAULT NULL COMMENT '所属商店的id',
  `g_type` varchar(48) DEFAULT NULL COMMENT '商品所属分类',
  `g_inline` bit(1) DEFAULT b'1' COMMENT '是否有效[1是,0否]',
  `g_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='淘宝其他店铺商品';

-- ----------------------------
-- Records of tb_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_goods_my`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods_my`;
CREATE TABLE `tb_goods_my` (
  `appid` varchar(48) NOT NULL COMMENT '商品ID',
  `r_appid` varchar(48) DEFAULT NULL COMMENT '目标店铺商品的id',
  `g_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `g_code` varchar(60) DEFAULT NULL COMMENT '商品编码',
  `g_url` varchar(255) DEFAULT NULL COMMENT '商品链接',
  `g_price` float DEFAULT '0' COMMENT '商品售卖价格',
  `g_price_2` float DEFAULT '0' COMMENT '商品原始价格',
  `g_free` float DEFAULT '0' COMMENT '运费',
  `g_number` int(11) DEFAULT '0' COMMENT '商品备货量',
  `g_remark` int(11) DEFAULT '0' COMMENT '被评论数量',
  `g_sold` int(11) DEFAULT '0' COMMENT '已售数量',
  `g_store_id` varchar(48) DEFAULT NULL COMMENT '所属商店的id',
  `g_type` varchar(48) DEFAULT NULL COMMENT '商品所属分类',
  `g_inline` bit(1) DEFAULT b'1' COMMENT '是否有效[1是,0否]',
  `g_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自己店铺的商品信息';

-- ----------------------------
-- Records of tb_goods_my
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_goods_type`
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods_type`;
CREATE TABLE `tb_goods_type` (
  `appid` varchar(48) NOT NULL,
  `p_id` varchar(48) DEFAULT '0' COMMENT '分类的上一级id[顶级为0]',
  `t_name` varchar(60) DEFAULT NULL COMMENT '分类名称',
  `t_info` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `t_order` int(11) DEFAULT '0' COMMENT '同一级排序字段',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='淘宝商品分类表';

-- ----------------------------
-- Records of tb_goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_line`
-- ----------------------------
DROP TABLE IF EXISTS `tb_line`;
CREATE TABLE `tb_line` (
  `LINE_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '名称',
  `LINE_URL` varchar(255) DEFAULT NULL COMMENT '链接',
  `LINE_ROAD` varchar(255) DEFAULT NULL COMMENT '线路',
  `TYPE` varchar(255) DEFAULT NULL COMMENT '类型',
  `LINE_ORDER` int(10) DEFAULT NULL COMMENT '排序',
  `PARENT_ID` varchar(255) DEFAULT NULL COMMENT '父类ID',
  PRIMARY KEY (`LINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_line
-- ----------------------------
INSERT INTO `tb_line` VALUES ('079c63d4fdcd479b9a84e2af9745e430', '华泰', 'http://www.baidu.com', '联通', '大类', '1', '0');
INSERT INTO `tb_line` VALUES ('36fc89101f2b4792985f92bc35d1cbba', '问问', 'http://www.1b23.com', '一号线', '小类', '1', '079c63d4fdcd479b9a84e2af9745e430');
INSERT INTO `tb_line` VALUES ('4bd68dbe76e44d1d8f9a5a012712793e', '线路1号', 'http://www.163.com', '铁通', '小类', '1', 'b79ebcb13f2042ffb6132f004c8ff46c');
INSERT INTO `tb_line` VALUES ('6c15bc3c06c64b2392085e72c88bbba5', '线路2号', 'http://www.qq.com', '网通', '小类', '2', 'b79ebcb13f2042ffb6132f004c8ff46c');

-- ----------------------------
-- Table structure for `tb_member`
-- ----------------------------
DROP TABLE IF EXISTS `tb_member`;
CREATE TABLE `tb_member` (
  `appid` varchar(48) NOT NULL COMMENT '主键ID',
  `m_name` varchar(60) DEFAULT NULL COMMENT '用户名',
  `m_taobao` varchar(60) DEFAULT NULL COMMENT '淘宝号',
  `m_zhifubao` varchar(60) DEFAULT NULL COMMENT '支付宝号',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='淘宝用户信息';

-- ----------------------------
-- Records of tb_member
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_pictures`
-- ----------------------------
DROP TABLE IF EXISTS `tb_pictures`;
CREATE TABLE `tb_pictures` (
  `PICTURES_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `NAME` varchar(255) DEFAULT NULL COMMENT '文件名',
  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',
  `CREATETIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `MASTER_ID` varchar(255) DEFAULT NULL COMMENT '属于',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PICTURES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图片关联表';

-- ----------------------------
-- Records of tb_pictures
-- ----------------------------
INSERT INTO `tb_pictures` VALUES ('7c83783a81a341a8b09f9a9f86adab2a', '图片', '8540b9279aa04f42942721c6b6f2564c.jpg', '20160818/8540b9279aa04f42942721c6b6f2564c.jpg', '2016-08-18 10:43:00', '1', '图片管理处上传');
INSERT INTO `tb_pictures` VALUES ('9ce67d6fa1f549bdb940165bd7f2ca13', '图片', '0c3759112f2a4f50b0863c6270646c6e.png', '20160818/0c3759112f2a4f50b0863c6270646c6e.png', '2016-08-18 10:42:59', '1', '图片管理处上传');
INSERT INTO `tb_pictures` VALUES ('aaaa67043dbb4873a1dd992b1c056229', '图片', '7b538cc5db38435aa4bc100eee537483.jpg', '20160819/7b538cc5db38435aa4bc100eee537483.jpg', '2016-08-19 19:54:23', '1', '图片管理处上传');

-- ----------------------------
-- Table structure for `tb_store`
-- ----------------------------
DROP TABLE IF EXISTS `tb_store`;
CREATE TABLE `tb_store` (
  `appid` varchar(48) NOT NULL COMMENT '店铺id',
  `s_name` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  `s_info` varchar(255) DEFAULT NULL COMMENT '店铺描述',
  `s_address` varchar(255) DEFAULT NULL COMMENT '地址[省-市]',
  `s_url` varchar(255) DEFAULT NULL COMMENT '店铺首页链接',
  `s_user_id` varchar(48) DEFAULT NULL COMMENT '店铺的经营者id',
  PRIMARY KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='淘宝店铺信息';

-- ----------------------------
-- Records of tb_store
-- ----------------------------

-- ----------------------------
-- Function structure for `get_count`
-- ----------------------------
DROP FUNCTION IF EXISTS `get_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_count`(p_id varchar(100)) RETURNS tinyint(4)
BEGIN
		DECLARE p_count INT(11);
		SELECT COUNT('LINE_ID') into p_count from tb_line where PARENT_ID = p_id;
    RETURN p_count;
 END
;;
DELIMITER ;
