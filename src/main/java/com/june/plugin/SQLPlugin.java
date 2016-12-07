package com.june.plugin;

import java.sql.Connection;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.xml.bind.PropertyException;

import org.apache.ibatis.cache.CacheKey;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.apache.log4j.Logger;

import com.june.util.ReflectHelper;
import com.june.util.Tools;

/**
 * 
 * SQL插件 <br>
 * 该拦截器拦截mybatis的query和update操作,能统计sql执行时间,可以根据执行时间打印sql语句.
 * 打印的sql语句是带参数的,没有?,可以拷贝到查询分析器什么的直接运行.
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月18日 下午7:25:13
 */
@Intercepts({
	/*@Signature(type = StatementHandler.class, method = "prepare", args= {Connection.class}),*/
	@Signature(type = Executor.class, method = "update", args = { MappedStatement.class, Object.class }),
	@Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class, CacheKey.class, BoundSql.class}),
	@Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class }) })
public class SQLPlugin implements Interceptor {
	private static final Logger logger = Logger.getLogger(SQLPlugin.class);
	private String dialect = ""; //数据库方言    
    private String pageSqlId = ""; //mapper.xml中需要拦截的ID(正则匹配)  
    
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		Object target = invocation.getTarget();
		Object returnValue = null;
		if (target instanceof Executor) {
			MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
			Object parameter = null;
			if (invocation.getArgs().length > 1) {
				parameter = invocation.getArgs()[1];
			}
			String sqlId = mappedStatement.getId();
			BoundSql boundSql = mappedStatement.getBoundSql(parameter);
			String sql = boundSql.getSql().toUpperCase();
			ReflectHelper.setValueByFieldName(boundSql, "sql", sql);// 将sql语句反射回BoundSql.
			Configuration configuration = mappedStatement.getConfiguration();
			long start = System.currentTimeMillis();
			returnValue = invocation.proceed();
			long end = System.currentTimeMillis();
			long time = (end - start);
			if (time > 1) {
				sql = getSql(configuration, boundSql, sqlId, time);
				logger.debug(sql);
			}
		}else if(target instanceof RoutingStatementHandler){
			RoutingStatementHandler statementHandler = (RoutingStatementHandler)invocation.getTarget();    
            StatementHandler delegate = (StatementHandler) ReflectHelper.getValueByFieldName(statementHandler, "delegate");  
			MappedStatement mappedStatement = (MappedStatement) ReflectHelper.getValueByFieldName(delegate, "mappedStatement");  
            BoundSql boundSql = delegate.getBoundSql();  
            String sql = boundSql.getSql().toUpperCase();
            if(mappedStatement.getId().matches(pageSqlId)){ 
	            Object parameterObject = boundSql.getParameterObject();
	            if(parameterObject!=null){
	            	ReflectHelper.setValueByFieldName(boundSql, "sql", sql);// 将sql语句反射回BoundSql
	            }
            }
            returnValue = invocation.proceed();
			
		}
		return returnValue;
	}

	public static String getSql(Configuration configuration, BoundSql boundSql, String sqlId, long time) {
		String sql = showSql(configuration, boundSql);
		StringBuilder str = new StringBuilder(100);
		str.append(sqlId);
		str.append(":");
		str.append(sql);
		str.append(":");
		str.append(time);
		str.append("ms");
		return str.toString();
	}

	private static String getParameterValue(Object obj) {
		String value = null;
		if (obj instanceof String) {
			value = "'" + obj.toString() + "'";
		} else if (obj instanceof Date) {
			DateFormat formatter = DateFormat.getDateTimeInstance(DateFormat.DEFAULT, DateFormat.DEFAULT, Locale.CHINA);
			value = "'" + formatter.format(new Date()) + "'";
		} else {
			if (obj != null) {
				value = obj.toString();
			} else {
				value = "";
			}
		}
		return value;
	}

	public static String showSql(Configuration configuration, BoundSql boundSql) {
		Object parameterObject = boundSql.getParameterObject();
		List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
		String sql = boundSql.getSql().replaceAll("[\\s]+", " ").toUpperCase();
		if (parameterMappings.size() > 0 && parameterObject != null) {
			TypeHandlerRegistry typeHandlerRegistry = configuration.getTypeHandlerRegistry();
			if (typeHandlerRegistry.hasTypeHandler(parameterObject.getClass())) {
				sql = sql.replaceFirst("\\?", getParameterValue(parameterObject));
			} else {
				MetaObject metaObject = configuration.newMetaObject(parameterObject);
				for (ParameterMapping parameterMapping : parameterMappings) {
					String propertyName = parameterMapping.getProperty();
					if (metaObject.hasGetter(propertyName)) {
						Object obj = metaObject.getValue(propertyName);
						sql = sql.replaceFirst("\\?", getParameterValue(obj));
					} else if (boundSql.hasAdditionalParameter(propertyName)) {
						Object obj = boundSql.getAdditionalParameter(propertyName);
						sql = sql.replaceFirst("\\?", getParameterValue(obj));
					}
				}
			}
		}
		return sql;
	}

	@Override
	public Object plugin(Object arg0) { 
		return Plugin.wrap(arg0, this);
	}

	@Override
	public void setProperties(Properties p) {
		dialect = p.getProperty("dialect");
		if (Tools.isEmpty(dialect)) {
			try {
				throw new PropertyException("dialect property is not found!");
			} catch (PropertyException e) {
				e.printStackTrace();
			}
		}
		pageSqlId = p.getProperty("pageSqlId");
		if (Tools.isEmpty(pageSqlId)) {
			try {
				throw new PropertyException("pageSqlId property is not found!");
			} catch (PropertyException e) {
				e.printStackTrace();
			}
		}
	}
	
    public String getDialect() {  
        return dialect;  
    }  
  
    public void setDialect(String dialect) {  
        this.dialect = dialect;  
    }  
  
    public String getPageSqlId() {  
        return pageSqlId;  
    }  
  
    public void setPageSqlId(String pageSqlId) {  
        this.pageSqlId = pageSqlId;  
    }
}
