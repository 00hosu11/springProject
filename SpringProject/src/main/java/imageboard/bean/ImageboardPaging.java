package imageboard.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class ImageboardPaging {
	private int currentPage;
	private int pageBlock;
	private int pageSize;
	private int totalA;
	private StringBuffer pagingHTML;
	
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		int totalP = (totalA+pageSize-1)/pageSize;
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage > totalP) endPage = totalP;
		
		if(startPage > pageBlock) 
			pagingHTML.append("<span id='paging' onclick='imageboardPaging("+(startPage-1)+")'>이전</span>");

		for(int i =startPage; i<=endPage; i++) {
			if(i==currentPage) {
				pagingHTML.append("<span id='currentPaging' onclick='imageboardPaging("+i+")'>"+i+"</span> ");
			}else {
				pagingHTML.append("<span id='paging' onclick='imageboardPaging("+i+")'>"+i+"</span>");
			}//else
		}//for
	
		if(endPage < totalP) 
			pagingHTML.append("<span id='paging' onclick='imageboardPaging("+(endPage+1)+")'>다음</span>");
	}
	
}


