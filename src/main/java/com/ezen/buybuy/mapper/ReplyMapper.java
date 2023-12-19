package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.Reply;
import com.ezen.buybuy.entity.Reply2;
import com.ezen.buybuy.entity.Reply3;

@Mapper
public interface ReplyMapper {
	public void replyinsert(Reply r);
	public List<Reply> replyselet(Reply r);
	public void replyinsert2(Reply2 r);
	public List<Reply2> replyselet2(Reply2 r2);
	public List<Reply3> replytotal(Reply3 r3);
	public List<Reply3> replytotal2(Reply3 r3);
}
