package com.zyy.rtf;

import com.zyy.rtf.constant.EntityConstant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * jdbc连接数据库获得数据源
 */
public class DataSource {

   	private static Connection connection = null;

	public static Connection getConnection(Properties pro) {
		// 事先导入驱动
		try {
			if(connection == null){
				String driver = pro.getProperty("jdbc.driver");
				Class.forName(driver);// 加载驱动
				// 创建连接对象,即已经连接到数据库
				if (driver.equalsIgnoreCase(EntityConstant.JDBC_DRIVER_MYSQL)) {
					connection = DriverManager.getConnection(pro.getProperty("jdbc.url"), pro.getProperty("user"), pro.getProperty("password"));	
				} else if (driver.equalsIgnoreCase(EntityConstant.JDBC_DRIVER_ORACLE)) {
					connection = DriverManager.getConnection(pro.getProperty("jdbc.url"), pro);
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
}
