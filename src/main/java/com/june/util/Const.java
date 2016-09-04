package com.june.util;

import org.springframework.context.ApplicationContext;

/**
 * 常量定义
 */
public class Const {
	
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";
	public static final String SESSION_USER = "sessionUser";
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_MENU_LIST = "menuList";			//当前菜单
	public static final String SESSION_ALL_MENU_LIST = "allmenuList";	//全部菜单
	public static final String SESSION_QX = "QX";						//权限
	public static final String SESSION_USER_PDS = "userpds";			//TODO 用户令牌		
	public static final String SESSION_USERROL = "USERROL";				//用户对象
	public static final String SESSION_USERNAME = "USERNAME";			//用户名
	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin.do";				//登录地址
	public static final String SYSNAME = "admin/config/SYSNAME.txt";	//系统名称路径
	public static final String PAGE	= "admin/config/PAGE.txt";			//分页条数配置路径
	public static final String EMAIL = "admin/config/EMAIL.txt";		//邮箱服务器配置路径
	public static final String SMS1 = "admin/config/SMS1.txt";			//短信账户配置路径1
	public static final String SMS2 = "admin/config/SMS2.txt";			//短信账户配置路径2
	public static final String FWATERM = "admin/config/FWATERM.txt";	//文字水印配置路径
	public static final String IWATERM = "admin/config/IWATERM.txt";	//图片水印配置路径
	public static final String WEIXIN	= "admin/config/WEIXIN.txt";	//微信配置路径
	public static final String FILEPATHIMG = "uploadFiles/uploadImgs/";	//图片上传路径
	public static final String FILEPATHFILE = "uploadFiles/file/";		//文件上传路径
	public static final String FILEPATHTWODIMENSIONCODE = "uploadFiles/twoDimensionCode/"; //二维码存放路径
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(app)|(weixin)|(static)|(main)|(websocket)).*";	//不对匹配该值的访问路径拦截（正则）
	
	
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化
	
	/**
	 * APP Constants
	 */
	//app注册接口_请求协议参数)
	public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[]{"countries","uname","passwd","title","full_name","company_name","countries_code","area_code","telephone","mobile"};
	public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[]{"国籍","邮箱帐号","密码","称谓","名称","公司名称","国家编号","区号","电话","手机号"};
	
	//app根据用户名获取会员信息接口_请求协议中的参数
	public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[]{"USERNAME"};
	public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[]{"用户名"};

	/** save 保存操作 */
	public static final String OPT_SAVE = ".save";
	/** delete 删除操作 */
	public static final String OPT_DELE = ".delete";
	/** deleteAll 删除全部操作 */
	public static final String OPT_DELE_ALL = ".deleteAll";
	/** edit 修改操作 */
	public static final String OPT_EDIT = ".edit";
	/** findById 查找操作 */
	public static final String OPT_SEARCH = ".findById";
	/** listAll 查找操作 */
	public static final String OPT_LIST_ALL = ".listAll";
	/** pagedSearch 查找操作 */
	public static final String OPT_PAGED = ".listPage";
	/** getAllById 查找操作 */
	public static final String OPT_GET_ALL = ".getAllById";
	/** findCount 查找数量操作 */
	public static final String OPT_COUNT = ".findCount";
	

	/** success 成功标识 */
	public static final String SUCCESS = "success";
	/** failed 失败标识 */
	public static final String FAILED = "failed";
	/** error 错误标识 */
	public static final String ERROR = "error";
	/** false 错误2标识 */
	public static final String FALSE_ = "false";
	/** result 结果标识 */
	public static final String RESULT = "result";
	/** msg 消息标识 */
	public static final String MESSAGE = "msg";
	/** pd 页表数据标识 */
	public static final String PAGE_DATA = "pd";
	/** pt 页表数据标识 */
	public static final String PAGE_TABLE = "pt";
	/** ok 确定标识 */
	public static final String OK = "ok";
	/** no 否定标识 */
	public static final String NO = "no";

	/** add 权限标识 */
	public static final String ADD = "add";
	/** del 权限标识 */
	public static final String DEL = "del";
	/** edit 权限标识 */
	public static final String EDIT = "edit";
	/** cha 权限标识 */
	public static final String CHA = "cha";
}
