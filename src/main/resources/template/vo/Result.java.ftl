package ${packageName}.vo;

import java.io.Serializable;

/**
* Created by zhangyuyang1
*/
public class Result implements Serializable {
	/** 是否成功 **/
	private boolean success;
	/** 返回信息 **/
	private String msg;
	/** 返回编码 **/
	private String code;

	public Result() {
	}

	public boolean isSuccess() {
		return this.success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}