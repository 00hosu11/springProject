package member.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.bean.MemberDTO;
import member.bean.ZipcodeDTO;
import member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	@Override
	public String login(Map<String, String> map, HttpSession session) {
		MemberDTO memberDTO = memberDAO.login(map);
		
		if(memberDTO == null) {
			return "fail"; //로그인실패
		}else {
			session.setAttribute("memName", memberDTO.getName());
			session.setAttribute("memId", memberDTO.getId());
			session.setAttribute("memEmail", memberDTO.getEmail1()+"@"+memberDTO.getEmail2());
			return "success"; //로그인성공
		}
		
	}

	@Override
	public String checkId(String id) {
		MemberDTO memberDTO = memberDAO.checkId(id);
		if(memberDTO == null)
			return "false";
		else
			return "true"; //아이디가 존재 - 사용불가능
	}

	@Override
	public List<ZipcodeDTO> checkPostSearch(Map<String, String> map) {
		return memberDAO.checkPostSearch(map);
	}


	@Override
	public void write(MemberDTO memberDTO) {
		memberDAO.write(memberDTO);
	}

	@Override
	public MemberDTO getMember(String id) {
		return memberDAO.getMember(id);
	}

	@Override
	public void modify(MemberDTO memberDTO) {
		memberDAO.modify(memberDTO);
	}


	
	
	
	
	
}
