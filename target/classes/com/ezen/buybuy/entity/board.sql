
CREATE TABLE Products (
	    	    product_IDX INT AUTO_INCREMENT PRIMARY KEY,
	    	    product_Name VARCHAR(50),
	    	    start_Date VARCHAR(50),
	    	    end_Date VARCHAR(50),
	    	    thumbnail_Img VARCHAR(255),
	    	    original_Price int,
	    	    discount_Price int,
	    	    discount_Rate VARCHAR(50),
	    	    detail_Img VARCHAR(255),
	    	    content_State VARCHAR(255),
	    	    ctgr_IDX INT,
	    	    reg_IDX INT
	    	);
select *from products;

 update Products set
    original_Price =11 
    where product_IDX =7;

drop table Products;
