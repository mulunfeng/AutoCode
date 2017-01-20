package com.zyy.rtf.model;

import java.io.Serializable;

public class FreeMarkServiceModel implements Serializable {

	private static final long serialVersionUID = 2937705254827977138L;
	/** 基础包 **/
	private String basePackage;
	/** 包名 **/
	private String packageName;
	/** Service实现名 **/
	private String serviceName;
	/** Service接口名 **/
	private String serviceInterfaceName;
	/** Spring管理的Bean名 **/
	private String serviceBeanName;
	/** 实体名 **/
	private String entityName;
	/** 实体变量名 **/
	private String objectName;
	/** 实体类包名 **/
	private String entityPackageName;
	/** DAO名 **/
	private String daoName;
	/** DAO包名 **/
	private String daoPackageName;
	
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

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServiceInterfaceName() {
		return serviceInterfaceName;
	}

	public void setServiceInterfaceName(String serviceInterfaceName) {
		this.serviceInterfaceName = serviceInterfaceName;
	}

	public String getServiceBeanName() {
		return serviceBeanName;
	}

	public void setServiceBeanName(String serviceBeanName) {
		this.serviceBeanName = serviceBeanName;
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

	public String getDaoName() {
		return daoName;
	}

	public void setDaoName(String daoName) {
		this.daoName = daoName;
	}

	public String getDaoPackageName() {
		return daoPackageName;
	}

	public void setDaoPackageName(String daoPackageName) {
		this.daoPackageName = daoPackageName;
	}

}
