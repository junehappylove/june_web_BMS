/**
 * 中科方德软件有限公司<br>
 * BMSystem:com.june.entity.system.dic.Dictory.java
 * 日期:2016年8月26日
 */
package com.june.entity.system.dic;

/**
 * 字典 <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月26日 上午10:45:53
 */
public class Dictory {
	private String dic_code;
	private String dic_name;
	private String dic_type;
	private String dic_sql;
	private String is_sys;
	private int sort_key;
	public String getDic_code() {
		return dic_code;
	}
	public void setDic_code(String dic_code) {
		this.dic_code = dic_code;
	}
	public String getDic_name() {
		return dic_name;
	}
	public void setDic_name(String dic_name) {
		this.dic_name = dic_name;
	}
	public String getDic_type() {
		return dic_type;
	}
	public void setDic_type(String dic_type) {
		this.dic_type = dic_type;
	}
	public String getDic_sql() {
		return dic_sql;
	}
	public void setDic_sql(String dic_sql) {
		this.dic_sql = dic_sql;
	}
	public String getIs_sys() {
		return is_sys;
	}
	public void setIs_sys(String is_sys) {
		this.is_sys = is_sys;
	}
	public int getSort_key() {
		return sort_key;
	}
	public void setSort_key(int sort_key) {
		this.sort_key = sort_key;
	}
	
}
