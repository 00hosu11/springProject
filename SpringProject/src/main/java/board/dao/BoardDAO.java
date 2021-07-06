package board.dao;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;


public interface BoardDAO {

	public void boardWrite(Map<String, String> map);

	public List<BoardDTO> getBoardList(Map<String, Integer> map);

	public BoardDTO getBoard(String seq);

	public int getTotalA();

	public void boardModify(Map<String, Object> map);

	public void boardReply(Map<String, String> map);

	public void hitUpdate(String seq);
	
	public void boardDelete(String seq);

	public List<BoardDTO> boardSearch(Map<String, String> map);

	public int getSearchTotalA(Map<String, String> map);

}
