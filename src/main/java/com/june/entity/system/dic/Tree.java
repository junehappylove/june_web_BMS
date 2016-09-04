/**
 * 中科方德软件有限公司<br>
 * BMSystem:com.june.entity.system.dic.Tree.java
 * 日期:2016年8月26日
 */
package com.june.entity.system.dic;

/**
 * 字典数据 <br>
 * 下拉或者树数据
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月26日 上午10:48:52
 */
public class Tree {
	private String key_code;
	private String key_name;
	private String dic_type;
	private String parent_id;
	private int sort_key;
	private String is_used;
	private String filter;
	public String getKey_code() {
		return key_code;
	}
	public void setKey_code(String key_code) {
		this.key_code = key_code;
	}
	public String getKey_name() {
		return key_name;
	}
	public void setKey_name(String key_name) {
		this.key_name = key_name;
	}
	public String getDic_type() {
		return dic_type;
	}
	public void setDic_type(String dic_type) {
		this.dic_type = dic_type;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public int getSort_key() {
		return sort_key;
	}
	public void setSort_key(int sort_key) {
		this.sort_key = sort_key;
	}
	public String getIs_used() {
		return is_used;
	}
	public void setIs_used(String is_used) {
		this.is_used = is_used;
	}
	public String getFilter() {
		return filter;
	}
	public void setFilter(String filter) {
		this.filter = filter;
	}
	
}
