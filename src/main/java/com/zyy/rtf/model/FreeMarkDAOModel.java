package com.zyy.rtf.model;

public class FreeMarkDAOModel extends BaseModel {

	private static final long serialVersionUID = 2937705254827977138L;

	/** Spring管理的Bean名 **/
	private String repositoryName;
	/** DAO名 **/
	private String daoName;
	/** 接口名 **/
	private String daoInterfaceName;
	
	public String getRepositoryName() {
		return repositoryName;
	}

	public void setRepositoryName(String repositoryName) {
		this.repositoryName = repositoryName;
	}

	public String getDaoName() {
		return daoName;
	}

	public void setDaoName(String daoName) {
		this.daoName = daoName;
	}

	public String getDaoInterfaceName() {
		return daoInterfaceName;
	}

	public void setDaoInterfaceName(String daoInterfaceName) {
		this.daoInterfaceName = daoInterfaceName;
	}

}
