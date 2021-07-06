package board.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class BoardPaging {

	private int currentPage; //현재페이지
	private int pageBlock; //[이전][1][2][3][다음]
	private int pageSize; //1페이지당 5개씩
	private int totalA; //총글수
	private StringBuffer pagingHTML; //편집이 가능하게 스트링버퍼를 사용했다.

	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		//총페이지수
//		int totalP =(totalA+4)/5; //이렇게 하면 맨날 5개밖에 안나온다
		int totalP =(totalA+pageSize-1)/pageSize; 
		
		/*
		 * currentPage : 2  startPage : 1  endPage : 3 
		 * currentPage : 5  startPage : 4  endPage : 6
		 */
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1;
		
		
		int endPage = startPage + pageBlock - 1;
		if(endPage > totalP) endPage = totalP;
		
		if(startPage > pageBlock)
			pagingHTML.append("<span id='paging' onclick='boardPaging("+(startPage-1)+")'>[이전]</span>");
		
		for(int i=startPage; i<=endPage; i++) {
			if(i==currentPage) {
				pagingHTML.append("[ <span id='currentPaging' onclick='boardPaging("+i+")'>"+i+"</span> ]");
			}else {
				pagingHTML.append("[ <span id='paging' onclick='boardPaging("+i+")'>"+i+"</span> ]");
			}
		}//for
		
		if(endPage < totalP)
			pagingHTML.append("<span id='paging' onclick='boardPaging("+(endPage+1)+")'>[다음]</span>");
	}	
	
}




