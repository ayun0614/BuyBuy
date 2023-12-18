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
}
