package member.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import member.bean.MemberDTO;
import member.bean.ZipcodeDTO;


@Transactional //여기다가 줘도 되고 밑에 함수마다 줘도된다
@Repository
public class MemberDAOMybatis implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberDTO login(Map<String, String> map) {
		return sqlSession.selectOne("memberSQL.login" , map);
	}

	@Override
	public MemberDTO checkId(String id) {
		return sqlSession.selectOne("memberSQL.checkId" , id);
	}

	@Override
	public List<ZipcodeDTO> checkPostSearch(Map<String, String> map) {
		return sqlSession.selectList("memberSQL.checkPostSearch", map);
	}
	
	@Override
	public void write(MemberDTO memberDTO) {
		sqlSession.insert("memberSQL.write" , memberDTO);		
	}

	@Override
	public MemberDTO getMember(String id) {
		return sqlSession.selectOne("memberSQL.getMember" , id);
	}

	@Override
	public void modify(MemberDTO memberDTO) {
		sqlSession.update("memberSQL.modify" , memberDTO);	
		
	}

}
