package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.*;

@Mapper
public interface ProductMapper {

	public void ProductListInsert(Products Products);

	public List<Products> ProductList();

	public List<Products> ProductListCtgr(int ctgr_idx);

	public Products read(int product_idx);

	public void ProductModify(Products Products);

	public void ProductDelete(int product_idx);
	
	public List<Products> PopMain(int limit);
	
	public List<Products> NewMain(int limit);
	
	public List<Products> ProductSearch(String word);
	
	public List<Products> SoonMain();

	public void ProductTimeout(int product_idx);
}
