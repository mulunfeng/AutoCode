package com.zyy.rtf.model;

import com.zyy.rtf.constant.BaseConstant;
import com.zyy.rtf.util.StringUtil;
import org.apache.commons.lang.StringUtils;

import java.io.Serializable;
import java.util.List;

public class BaseModel implements Serializable {

	private static final long serialVersionUID = -3438890745113467885L;
	/** 基础包 **/
	private String basePackage;
	/** 包名 **/
	private String packageName;
	/** 实体名 **/
	private String entityName;
	/** 首字母小写实体名 **/
	private String lowerEntityName;
	/** 实体变量名 **/
	private String objectName;
	/** 实体类包名 **/
	private String entityPackageName;
	/** 表的列集合 **/
	private List<Column> columns;
	/** 表的主键 **/
	private Column columnKey;

	public String getBasePackage() {
		return basePackage;
	}

	public void setBasePackage(String basePackage) {
		this.basePackage = basePackage;
	}

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
		this.lowerEntityName = StringUtil.toLowerCaseFirstOne(entityName);
	}

	public String getObjectName() {
		return objectName;
	}

	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}

	public String getEntityPackageName() {
		return entityPackageName;
	}

	public void setEntityPackageName(String entityPackageName) {
		this.entityPackageName = entityPackageName;
	}

	public String getLowerEntityName() {
		return StringUtil.toLowerCaseFirstOne(this.entityName);
	}

	public void setLowerEntityName(String lowerEntityName) {
		this.lowerEntityName = lowerEntityName;
	}
	public Column getColumnKey() {
		if (columns == null)
			return null;

		for (Column column : columns) {
			if (StringUtils.isNotBlank(column.getColumnKey()) && column.getColumnKey().equals(BaseConstant.TRUE)) {
				return column;
			}
		}
		return null;
	}

	public void setColumnKey(Column columnKey) {
		this.columnKey = columnKey;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
}
