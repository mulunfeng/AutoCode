package ${packageName}.vo;

import java.util.List;

/**
* Created by zhangyuyang1
*/
public class Page {
	/** 查询结果 */
	private List<?> listResult;
	/** 分页信息 */
	private PageVO pageVO;

	public Page(List<?> listResult, PageVO pageVO) {
		this.listResult = listResult;
		this.pageVO = pageVO;
	}

	public List<?> getListResult() {
		return listResult;
	}

	public void setLstResult(List<?> lstResult) {
		this.listResult = lstResult;
	}

	public PageVO getPageVO() {
		return pageVO;
	}

	public void setPageVO(PageVO pageVO) {
		this.pageVO = pageVO;
	}
}
