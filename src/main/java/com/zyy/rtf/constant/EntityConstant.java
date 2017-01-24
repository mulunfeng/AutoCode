package com.zyy.rtf.constant;

/**
 * 生成实体的常量类
 */
public class EntityConstant {

	/** 模板文件 **/
	public static final String ENTITY_TEMPLATE_DIR = EntityConstant.class.getClassLoader().getResource("template").getFile();
	
	/** 模板文件 **/
	public static final String ENTITY_TEMPLATE = "Entity.java.ftl";
	
	/** 模板文件-Mapper **/
	public static final String MAPPER_TEMPLATE = "Mapper.xml.ftl";

	/** 模板文件-Controller **/
	public static final String CONTROLLER_TEMPLATE = "Controller.java.ftl";

	/** 模板文件-View **/
	public static final String VIEW_TEMPLATE = "View.vm.ftl";

	/** 实体包名 **/
	public static final String PACKAGE = "PACKAGE";//"com.zyy.rtf.entity";
	
	/** 继承类包名 **/
	public static final String EXTEND_PACKAGE = "EXTEND_PACKAGE";
	
	/** 继承类 **/
	public static final String EXTEND_NAME = "EXTEND_NAME";
	
	public static final String TABLES = "TABLES";
	
	/** 数据表前缀 **/
	public static final String TABPREFIX = "TABPREFIX";
	
	/** 数据库表字段前缀 **/
	public static final String ATTPREFIX = "ATTPREFIX";
	
	/** 是否需要主键 **/
	public static final String ISNEEDKEY = "ISNEEDKEY";
	
	public static final String JDBC_DRIVER_MYSQL = "com.mysql.jdbc.Driver";
	
	public static final String JDBC_DRIVER_ORACLE = "oracle.jdbc.driver.OracleDriver";
	
}
