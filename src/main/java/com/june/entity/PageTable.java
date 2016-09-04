package com.june.entity;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * 页表数据 <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月18日 上午9:14:08
 */
public class PageTable extends HashMap<String, Object> implements Map<String, Object> {

	private static final long serialVersionUID = 100L;

	Map<String, Object> data;

	HttpServletRequest request;

	/**
	 * 将 http的请求对象转换成页表
	 * @param request
	 * @see org.springframework.web.util.WebUtils.getParametersStartingWith()
	 */
	public PageTable(HttpServletRequest request) {
		this.request = request;
		Map<String, String[]> properties = request.getParameterMap();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Iterator<Map.Entry<String, String[]>> entries = properties.entrySet().iterator();
		Map.Entry<String, String[]> entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry<String, String[]>) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		data = returnMap;
	}
	
	public PageTable(HttpServletRequest request, boolean flag) {
		this.request = request;
		Map<String, Object> returnMap ;
		if(flag){
			returnMap = org.springframework.web.util.WebUtils.getParametersStartingWith(request,"");
		}else{
			returnMap = new PageTable(request);
		}
		this.data = returnMap;
	}
	
	/**
	 * 将实体转成PageTable表
	 * @param bean
	 * @date 2016年8月19日 上午10:45:06
	 * @writer iscas
	 */
	public PageTable(Object bean) {
		BeanInfo beanInfo = null;
		try {
			beanInfo = Introspector.getBeanInfo(bean.getClass());
		} catch (IntrospectionException e) {
			e.printStackTrace();
		}
		PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
		for (int i = 0; i < propertyDescriptors.length; i++) {
			PropertyDescriptor descriptor = propertyDescriptors[i];
			String propertyName = descriptor.getName();
			if (!propertyName.equals("class")) {
				Method readMethod = descriptor.getReadMethod();
				Object result = null;
				try {
					result = readMethod.invoke(bean, new Object[0]);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
				if (result != null) {
					data.put(propertyName, result);
				} else {
					data.put(propertyName, "");
				}
			}
		}
	}

	/**
	 * 创建一个新的空页数据
	 */
	public PageTable() {
		data = new HashMap<String, Object>();
	}

	protected PageTable(Map<String, Object> _map) {
		this(_map, null);
	}

	public PageTable(String key) {
		this(new HashMap<String, Object>(), key);
	}

	private PageTable(Map<String, Object> _map, String key) {
		if (_map != null) {
			data = _map;
		} else {
			data = new HashMap<String, Object>();
		}
		if (key != null) {
			data.put(key.toString(), null);
		}
	}

	@Override
	public Object get(Object key) {
		Object obj = null;
		if (data.get(key) instanceof Object[]) {
			Object[] arr = (Object[]) data.get(key);
			obj = request == null ? arr : (request.getParameter((String) key) == null ? arr : arr[0]);
		} else {
			obj = data.get(key);
		}
		return obj;
	}

	public String getString(Object key) {
		return (String) get(key);
	}

	@Override
	public Object put(String key, Object value) {
		return data.put(key, value);
	}

	@Override
	public Object remove(Object key) {
		return data.remove(key);
	}

	public void clear() {
		data.clear();
	}

	public boolean containsKey(Object key) {
		return data.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return data.containsValue(value);
	}

	public Set<Entry<String, Object>> entrySet() {
		return data.entrySet();
	}

	public boolean isEmpty() {
		return data.isEmpty();
	}

	public Set<String> keySet() {
		return data.keySet();
	}

	/**
	 * TODO bug: String is a final class ,therefor no class can extends String.
	 */
	public void putAll(Map<? extends String, ? extends Object> t) {
		data.putAll(t);
	}

	public int size() {
		return data.size();
	}

	public Collection<Object> values() {
		return data.values();
	}

}
