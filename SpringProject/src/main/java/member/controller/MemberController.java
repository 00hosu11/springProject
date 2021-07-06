package member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.bean.MemberDTO;
import member.bean.ZipcodeDTO;
import member.service.MemberService;

@Controller
@RequestMapping(value="member") // /(슬래쉬)를 자동으로 부여해준다
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/login" ,method=RequestMethod.POST)
	@ResponseBody 
	public String login(@RequestParam Map<String ,String> map , HttpSession session) {
		return memberService.login(map, session);
	}
	
	@RequestMapping(value="/logout" ,method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();//모든 세션 무효화
		return "/index";
	}
	
	//display 에 넣기 
    @RequestMapping(value="writeForm", method=RequestMethod.GET)
    public String writeForm(Model model) {
    	model.addAttribute("display", "/member/writeForm.jsp");
        return "/index";
    }
	
	@RequestMapping(value="/checkId" ,method=RequestMethod.POST)
	@ResponseBody //진짜문자열로간다
	public String checkId(@RequestParam String id) {
		return memberService.checkId(id);
	}
	
	@RequestMapping(value="/checkPost" ,method=RequestMethod.GET)
	public String checkPost(){
		return "/member/checkPost";
		
	}
	
	 @RequestMapping(value="/checkPostSearch", method=RequestMethod.POST)
	 @ResponseBody // 다시 돌아가게 한다             //문자열 //map
	 public ModelAndView checkPostSearch(@RequestParam Map<String ,String> map) {
		 
	    List<ZipcodeDTO> list = memberService.checkPostSearch(map);
	      
	    ModelAndView mav = new ModelAndView();
	    mav.addObject("list" , list);
	    mav.setViewName("jsonView");
	    return mav;
	 }
	 
	 @RequestMapping(value="/write" ,method=RequestMethod.POST)
	 @ResponseBody //writeForm.jsp에서  write.jsp로 페이지 이동하지말고 제자리로 돌아가라고 @ResponseBody를 줬다
	 public void write(@ModelAttribute MemberDTO memberDTO) { //객체타입으로 넘어올때
		 memberService.write(memberDTO);
		 
	 }


    @RequestMapping(value="modifyForm",method=RequestMethod.GET)
    public String modifyForm(HttpSession session, Model model) {
      String id = (String) session.getAttribute("memId");
      MemberDTO memberDTO = memberService.getMember(id);
      
      model.addAttribute("memberDTO",memberDTO);
      model.addAttribute("display","/member/modifyForm.jsp");
      return "/index";
   }
    
     @RequestMapping(value="/modify" ,method=RequestMethod.POST) //ajax를 안써서(서브밋으로썼다) 굳이 리스폰스바디를 안써도된다
	 public String modify(@ModelAttribute MemberDTO memberDTO, Model model) {
		 memberService.modify(memberDTO);
		 
		 model.addAttribute("display" , "/member/modify.jsp");
		 return "/index";
	 }
	 

}
