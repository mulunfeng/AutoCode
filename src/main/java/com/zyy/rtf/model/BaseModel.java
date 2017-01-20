package com.zyy.rtf.model;

import com.zyy.rtf.util.StringUtil;

import java.io.Serializable;

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
}
