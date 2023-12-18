package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.*;

@Mapper
public interface ProductMapper {
	
	public void ProductListInsert(Products Products);
	public List<Products> ProductList();
	public Products read(int product_idx);
	public void ProductModify(Products Products);
	public void ProductDelete(int product_idx);
	
}