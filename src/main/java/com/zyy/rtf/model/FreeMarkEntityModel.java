package com.zyy.rtf.model;

import java.util.List;


/**
 * 模板显示数据的传输对象
 */
public class FreeMarkEntityModel {
	
	/** 包名 **/
	private String packageName;
	
	/** 实体名 **/
	private String entityName;
	
	/** 所属数据库用户 **/
	private String sysName;
	
	/** 数据库表名 **/
	private String tableName;
	
	/** 继承类名 **/
	private String extendName;
	
	/** 继承类包名 **/
	private String extendPackageName;
	
	/** 表名描述 **/
	private String tableRemarks;
	
	

	/** 表的列集合 **/
	private List<Column> columns;

	

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getSysName() {
		return sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public String getExtendName() {
		return extendName;
	}

	public void setExtendName(String extendName) {
		this.extendName = extendName;
	}

	public String getExtendPackageName() {
		return extendPackageName;
	}

	public void setExtendPackageName(String extendPackageName) {
		this.extendPackageName = extendPackageName;
	}
	
	public String getTableRemarks() {
		return tableRemarks;
	}

	public void setTableRemarks(String tableRemarks) {
		this.tableRemarks = tableRemarks;
	}
	
	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
}
