package com.zyy.rtf.model;

import com.zyy.rtf.constant.BaseConstant;
import org.apache.commons.lang.StringUtils;

import java.io.Serializable;
import java.util.List;

public class FreeMarkServiceModel extends BaseModel {

	private static final long serialVersionUID = 2937705254827977138L;
	/** Service实现名 **/
	private String serviceName;
	/** Service接口名 **/
	private String serviceInterfaceName;
	/** Spring管理的Bean名 **/
	private String serviceBeanName;
	/** DAO名 **/
	private String daoName;
	/** DAO包名 **/
	private String daoPackageName;
	/** 表的列集合 **/
	private List<Column> columns;
	/** 表的主键 **/
	private Column columnKey;

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
