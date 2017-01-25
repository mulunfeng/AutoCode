package ${packageName}.mybatis;

import org.apache.ibatis.executor.statement.BaseStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;

import ${packageName}.vo.PageVO;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})})
public class PageStatementHandlerInterceptor implements Interceptor {
	private final Log logger = LogFactory.getLog(getClass());

	/**
	* mapper.xml中需要拦截的ID(正则匹配)
	**/
	private static String PAGESQL_ID = "pageSqlId";

	private String pageSqlId;


	/**
	* 直接设置对象属性值, 忽略 private/protected 修饰符, 也不经过 setter
	*
	* @param object
	* @param fieldName
	* @param value
	*/
	public static void setFieldValue(Object object, String fieldName, Object value) {
		Field field = null;

		for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
			try {
				field = superClass.getDeclaredField(fieldName);
			} catch (NoSuchFieldException e) {
				// Field 不在当前类定义, 继续向上转型
			}
		}

		if (field == null)
			throw new IllegalArgumentException("Could not find field ["
				+ fieldName + "] on target [" + object + "]");

		if (!Modifier.isPublic(field.getModifiers())) {
			field.setAccessible(true);
		}

		try {
			field.set(object, value);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}


	/**
	 * 直接读取对象的属性值, 忽略 private/protected 修饰符, 也不经过 getter
	 *
	 * @param object
	 * @param fieldName
	 * @return
	 */
	public static Object getFieldValue(Object object, String fieldName) {

		Field field = null;
		for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
			try {
				field = superClass.getDeclaredField(fieldName);
			} catch (NoSuchFieldException e) {
				// Field 不在当前类定义, 继续向上转型
			}
		}

		if (field == null) {
			throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + object + "]");
		}

		if (!Modifier.isPublic(field.getModifiers())) {
			field.setAccessible(true);
		}

		Object result = null;
		try {
			result = field.get(object);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}

		return result;
	}


	/**
	 * 分页拦截器。
	 * <p>功能主要是用来取总记录数和对SQL分页拦截。
     *
     * @param invocation
     * @return
     * @throws Throwable
     * @see org.apache.ibatis.plugin.Interceptor#intercept(org.apache.ibatis.plugin.Invocation)
     */
    @Override
    public Object intercept(Invocation invocation) throws Throwable {

		RoutingStatementHandler routingStatementHandler = (RoutingStatementHandler) invocation.getTarget();
		BaseStatementHandler delegate = (BaseStatementHandler) getFieldValue(routingStatementHandler, "delegate");
		MappedStatement mappedStatement = (MappedStatement) getFieldValue(delegate, "mappedStatement");

		if (mappedStatement.getId().matches(pageSqlId)) {
			BoundSql boundSql = delegate.getBoundSql();
			Object parameterObject = boundSql.getParameterObject();

			if (parameterObject == null) {
				throw new NullPointerException("Object is Null, Please Check");
			}

			Map<String, Object> parameterMap = (Map<String, Object>) parameterObject;
			PageVO pageVO = (PageVO) parameterMap.get("pageVO");

			if (pageVO == null) {
				throw new NullPointerException("Not Found Page Info,Please Check PageBean");
			}

			// 取得连接
			Connection connection = (Connection) invocation.getArgs()[0];
			String sql = boundSql.getSql();


			//删除查询语句中的order by子句
			String newCountSql;
			newCountSql = delOrderbySQL(sql);
			int idx = newCountSql.toUpperCase().indexOf("FROM ");
			newCountSql = "select count(*) as cnt " + newCountSql.substring(idx);


			BoundSql newBoundSql = new BoundSql(mappedStatement.getConfiguration(), newCountSql,
			boundSql.getParameterMappings(), parameterObject);
			DefaultParameterHandler parameterHandler = new DefaultParameterHandler(
			mappedStatement, parameterObject, newBoundSql);


			PreparedStatement ps = null;
			int count = 0;

			try {
				ps = connection.prepareStatement(newCountSql);
				parameterHandler.setParameters(ps);
				ResultSet rs = ps.executeQuery();
				count = (rs.next()) ? rs.getInt("cnt") : 0;
				rs.close();
			} catch (SQLException e) {
				throw new Exception("Query total record is Error", e);
			} finally {
				try {
					if (ps != null) ps.close();
				} catch (SQLException e) {
					throw new Exception("An exception occurred while the closed state", e);
				}
			}

			// 把记录总数放入对象pageBean中
			pageVO.setTotalCount(count);
			String pageSql = getLimitString(sql, pageVO);
			//将分页sql语句反射回BoundSql.
			setFieldValue(boundSql, "sql", pageSql);
		}

		return invocation.proceed();
    }

    /**
    * 删除查询条件中的order by子句
    *
    * @param queryString 查询SQL语句
    * @return 删除查询语句中的order by子句后的查询语句
    */
    private String delOrderbySQL(String queryString) {
		StringBuilder temp = new StringBuilder();
		queryString = "(" + queryString + ")";

		String[] strArray = queryString.split("order by");

		for (int i = 1; i < strArray.length; i++) {
			strArray[i] = ")";
		}

		for (String aStrArray : strArray) {
			temp.append(aStrArray);
		}
		String result = temp.toString();

		if (temp.length() >= 2) {
			result = result.substring(1, result.length() - 1);
		}

		return result;
    }

    private String getLimitString(String sql, PageVO pageVO) {
		StringBuilder pagingSelect = new StringBuilder(sql.length() + 20);
		pagingSelect.append(sql);
		/**默认起始位置是从1开始*/
		int page = (pageVO.getPageNumber() > 0) ? pageVO.getPageNumber() : 1;
		int start = (page - 1) * pageVO.getPageSize();
		pagingSelect.append(" limit ").append(start).append(", ").append(pageVO.getPageSize());
		return pagingSelect.toString();
    }

    /**
    * 拦截本插件。
    *
    * @param target
    * @return
    * @see org.apache.ibatis.plugin.Interceptor#plugin(Object)
    */
    @Override
    public Object plugin(Object target) {
   		return Plugin.wrap(target, this);
    }

    /**
    * 设置属性值。
    *
    * @param properties
    * @see org.apache.ibatis.plugin.Interceptor#setProperties(java.util.Properties)
    */
    @Override
    public void setProperties(Properties properties) {
		pageSqlId = properties.getProperty(PAGESQL_ID);
		if (pageSqlId == null || pageSqlId.length() < 1) {
			logger.error("pageSqlId property is not found!");
		}
    }
}
