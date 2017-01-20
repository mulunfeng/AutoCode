package com.zyy.rtf;

import com.zyy.rtf.constant.EntityConstant;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


public class GeneratorUtil {

	/**
	 * 方法功能说明:代码自动生成器
	 * @param type:oracle/mysql
	 * @param url:jdbc.url
	 * @param schema：数据库登录帐号
	 * @param password：数据库登录密码
	 * @param tablefix：表名前缀
	 * @param columnsfix：字段前缀
	 * @param isNeedKey：是否需要继承父类
	 * @param extendPackage：继承父类包名
	 * @param extendName：继承父类类名
	 * @param packageName：输出的包名
	 */
	public static void generator(String type, String url, String schema, String password,
			String tablefix, String columnsfix, List<String> tables, String isNeedKey,String extendPackage,String extendName,String packageName){
		Properties pro = new Properties();
		if (type.equals("mysql")) {
			pro.put("jdbc.driver", "com.mysql.jdbc.Driver");
		} else if (type.equals("oracle")) {
			pro.put("jdbc.driver", "oracle.jdbc.driver.OracleDriver");
		} else {
			throw new IllegalArgumentException("错误的数据库类型!");
		}
		
		pro.put("jdbc.url", url);
		pro.put("user", schema);
		pro.put("password", password);
		pro.put("remarksReporting", "true");
		pro.put(EntityConstant.TABPREFIX, tablefix);
		pro.put(EntityConstant.ATTPREFIX, columnsfix);
		pro.put(EntityConstant.ISNEEDKEY,isNeedKey);
		pro.put(EntityConstant.EXTEND_PACKAGE, extendPackage);
		pro.put(EntityConstant.EXTEND_NAME,extendName);
		pro.put(EntityConstant.PACKAGE,packageName);
		pro.put(EntityConstant.TABLES, tables);
		try {
			Generator.createGenerator(pro);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		List<String> tables = new ArrayList<String>();

		tables.add("crawler_job");
		GeneratorUtil.generator("mysql", "jdbc:mysql://172.24.7.95:3306/testzzy?useUnicode=true&characterEncoding=UTF8&zeroDateTimeBehavior=convertToNull",
				"mysql", "123456", "", "", tables, "true","","","com.yf.vo");
	}
	
}
