package board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private HttpSession session;
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private BoardPaging boardPaging;

	@Override
	public void boardWrite(Map<String, String> map) {
		map.put("id" , (String)session.getAttribute("memId"));
		map.put("name" , (String)session.getAttribute("memName"));
		map.put("email" , (String)session.getAttribute("memEmail"));
		
		boardDAO.boardWrite(map);
	}


	@Override
	public List<BoardDTO> getBoardList(String pg) {
		//1페이지당 5개씩
		int endNum = Integer.parseInt(pg)*5;
		int startNum = endNum-4;
		
		Map<String , Integer> map = new HashedMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return boardDAO.getBoardList(map);
	
	}
	
	@Override
	public List<BoardDTO> boardSearch(Map<String, String> map) {
		//1페이지당 5개씩
		int endNum = Integer.parseInt(map.get("pg"))*5;
		int startNum = endNum-4;
		
		//pg, searchOption, keyword, startNum, endNum
		map.put("startNum", startNum+"");
		map.put("endNum", endNum+"");
		
		return boardDAO.boardSearch(map);
	}
	

	@Override
	public BoardDTO getBoard(String seq) {
		return boardDAO.getBoard(seq);
	}

	@Override
	public BoardPaging boardPaging(String pg) {
		int totalA = boardDAO.getTotalA(); //총글수
		
		boardPaging.setCurrentPage(Integer.parseInt(pg)); //현재페이지
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA);
		boardPaging.makePagingHTML();
		
		return boardPaging;
	}

	
	@Override
	public BoardPaging boardPaging(Map<String, String> map) {
		int totalA = boardDAO.getSearchTotalA(map); //검색한 총글수
		
		boardPaging.setCurrentPage(Integer.parseInt(map.get("pg"))); //현재 페이지
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA);
		boardPaging.makePagingHTML();
		
		return boardPaging;
	}

	
	@Override
	public void boardModify(Map<String, Object> map) {
		boardDAO.boardModify(map);
	}


	@Override
	public void boardReply(Map<String, String> map) {//pseq, pg, subject, content
		//원글
		BoardDTO pDTO = boardDAO.getBoard(map.get("pseq"));
		
		map.put("id", (String) session.getAttribute("memId"));
		map.put("name", (String) session.getAttribute("memName"));
		map.put("email", (String) session.getAttribute("memEmail"));
		map.put("ref" , pDTO.getRef()+""); //원글 ref
		map.put("lev" , pDTO.getLev()+""); //원글 lev 
		map.put("step" , pDTO.getStep()+""); //원글step
		
		boardDAO.boardReply(map);
	}

	@Override
	public void hitUpdate(String seq) {
		boardDAO.hitUpdate(seq);
		
	}
	
	@Override
	public void boardDelete(String seq) {
		boardDAO.boardDelete(seq);
		
	}



}
