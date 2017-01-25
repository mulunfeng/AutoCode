package ${packageName}.vo;

/**
* Created by zhangyuyang1
*/
public class PageVO {

	private Long startRow;

	private int pageSize = 10;

	private int pageNumber = 1;

	private long totalPage;

	private long totalCount;

	public PageVO() {
	}

	public PageVO(int pageSize, int pageNumber) {
		this.pageSize = pageSize;
		this.pageNumber = pageNumber;
	}

	public Long getStartRow() {
		if (null == startRow) {
			startRow = (long) (pageNumber - 1) * pageSize;
		}
		return startRow;
	}

	public void setStartRow(Long startRow) {
		this.startRow = startRow;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(long totalCount) {
		if (totalCount % pageSize == 0)
			this.setTotalPage(totalCount / pageSize);
		else
			this.setTotalPage(totalCount / pageSize + 1);
		this.totalCount = totalCount;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}
}
