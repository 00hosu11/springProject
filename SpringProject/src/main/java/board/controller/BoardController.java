package board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.service.BoardService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping(value="board") 
public class BoardController {
	@Autowired
	private BoardService boardService;
	
//    @RequestParam  --문자열 또는 MAP
//    @ModelAttribute -- 객체타입
	
	
	//display 에 넣기 
    @RequestMapping(value="boardWriteForm", method=RequestMethod.GET)
    public String boardWriteForm(Model model) {
    	model.addAttribute("display", "/board/boardWriteForm.jsp");
        return "/index";
    }
	
    @RequestMapping(value="boardWrite" ,method=RequestMethod.POST)
	 @ResponseBody
	 public void boardWrite(@RequestParam Map<String,String> map) {
    	//원글 - 1페이지 , 첫번째
    	boardService.boardWrite(map);
		 
	 }
    
    @RequestMapping(value="boardList" , method=RequestMethod.GET)//페이지가 안들어올수도있으니까 이렇게 디폴트값주기
    public String boardList(@RequestParam(required=false, defaultValue = "1") String pg , Model model) {
    	model.addAttribute("pg", pg);
    	model.addAttribute("display", "/board/boardList.jsp");
    	return "/index";
    }
    
    @RequestMapping(value="getBoardList", method=RequestMethod.POST)
    @ResponseBody
    public ModelAndView getBoardList(@RequestParam(required=false, defaultValue = "1") String pg,
    												HttpSession session,
    												HttpServletResponse response) {
    	//1페이지당 5개씩
    	List<BoardDTO> list = boardService.getBoardList(pg);
    	
    	//세션
    	String memId = (String) session.getAttribute("memId");
    	
    	//조회수 - 새로고침 방지
    	if(session.getAttribute("memId") != null){
    		Cookie cookie = new Cookie("memHit" , "0"); //쿠키생성
    		cookie.setMaxAge(30*60); //초단위 // 30분
    		response.addCookie(cookie); //클라이언트 보내기
    	}
    	
    	//페이징 처리
    	BoardPaging boardPaging= boardService.boardPaging(pg);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("pg", pg);
    	mav.addObject("list", list);
    	mav.addObject("memId", memId);
    	mav.addObject("boardPaging", boardPaging);
    	
    	mav.setViewName("jsonView"); //json으로 자동으로 변환
    	return mav;
    }
    
	/* 리스트 검색 */
    @RequestMapping(value="/boardSearch" ,method=RequestMethod.POST)
    public @ResponseBody ModelAndView boardSearch(@RequestParam Map<String, String> map, //pg, searchOption, keyword
    												HttpSession session) {
 	   	
    	//1페이지당 5개씩
    	List<BoardDTO> list = boardService.boardSearch(map);
    	
    	//세션
    	String memId = (String) session.getAttribute("memId");
    	
    	//페이징 처리
    	BoardPaging boardPaging= boardService.boardPaging(map);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("pg", map.get("pg"));
    	mav.addObject("list", list);
    	mav.addObject("memId", memId);
    	mav.addObject("boardPaging", boardPaging);
    	mav.setViewName("jsonView");
 	    return mav;
 	   }
    
    @RequestMapping(value="boardView", method=RequestMethod.GET)
    public String boarView(Model model,
    					   @RequestParam String pg,
    					   @RequestParam String seq) {
    	
    	model.addAttribute("pg", pg);
    	model.addAttribute("seq", seq);
    	model.addAttribute("display", "/board/boardView.jsp");
        return "/index";
    }
    
    @RequestMapping(value="getBoard" , method=RequestMethod.POST)//페이지가 안들어올수도있으니까 이렇게 디폴트값주기
    @ResponseBody
    public ModelAndView getBoard(@RequestParam String seq , HttpSession session,
    							 @CookieValue(value="memHit", required=false) Cookie cookie,
    							 HttpServletResponse response) {
    	
    	//조회수 - 새로고침 방지
    	if(cookie != null) {
    		boardService.hitUpdate(seq); //조회수 증가
    		cookie.setMaxAge(0); //쿠키 삭제
    		response.addCookie(cookie); //클라이언트 보내기
    	}
    	
    	//한사람의 글을 가지고오기
    	BoardDTO boardDTO = boardService.getBoard(seq);
    	
    	//세션
    	String memId = (String) session.getAttribute("memId");
    	
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("boardDTO" ,boardDTO);
    	mav.addObject("memId", memId);
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    @RequestMapping(value="boardModifyForm", method=RequestMethod.POST)
    public String boardModifyForm(Model model, @RequestParam String seq,
    										   @RequestParam String pg) {
    	
    	model.addAttribute("seq", seq);
    	model.addAttribute("pg", pg);
    	model.addAttribute("display", "/board/boardModifyForm.jsp");
    	return "/index";
     }
    
     @RequestMapping(value="boardModify" ,method=RequestMethod.POST)
  	 public @ResponseBody void boardModify(@RequestParam Map<String, Object> map) {
      	boardService.boardModify(map);
  	 }
     
     @RequestMapping(value="boardReplyForm", method=RequestMethod.POST)
     public String boardReplyForm(@RequestParam String seq,
    		 					  @RequestParam String pg,
    		                       Model model) {
    	 //답글 - 원글이 있는 페이지, 원글 밑으로
    	 model.addAttribute("pseq" , seq); //원글번호
    	 model.addAttribute("pg" , pg);//원글이 있는 페이지 번호도 갖고와야한다
     	 model.addAttribute("display", "/board/boardReplyForm.jsp");
         return "/index";
     }
     
     @RequestMapping(value="boardReply" ,method=RequestMethod.POST)
	 @ResponseBody
	 public void boardReply(@RequestParam Map<String,String> map) { //pseq, pg, subject, content
    	boardService.boardReply(map);
	 }
     
     @RequestMapping(value="boardDelete",method=RequestMethod.POST)
  	 public ModelAndView boardDelete(@RequestParam String seq) {
      	boardService.boardDelete(seq);
      	
      	return new ModelAndView("redirect:/board/boardList"); //바로 요청해버린다. //sendRedirect 하고 같은 기능 //같은컨트롤러를 또 요청할수 있다. 클라이언트처럼
  	 }
     
}
