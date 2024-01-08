package com.ezen.buybuy.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.Members;

@Mapper
public interface MemberMapper {
	public int register(Members m);

	public Members check(Members m);

	public void insert(Members mem);

	public Members registerCheck(String member_id);

	public int emailCheck(String email);

	public void membermodify(Members mem);

	public void memberdelete(String member_id);

	public Members findId(String email, String name);

	public Members findPw(String member_id, String email);
}
