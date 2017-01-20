package com.zyy.rtf;

import java.util.Properties;


public class TestGenerator {

	public static void main(String[] args) {
		Properties pro = new Properties();
		pro.put("jdbc.driver", "oracle.jdbc.driver.OracleDriver");
		pro.put("jdbc.url", "jdbc:oracle:thin:@192.168.123.206:1521:oradb");
		pro.put("user", "nkpa");
		pro.put("password", "nkpa");
		pro.put("remarksReporting", "true");
		pro.put("ISNEEDKEY", true);
		pro.put("PACKAGE", "com.nk.pa");
		try {
			Generator.createGenerator(pro);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
