
CREATE TABLE Products (
	    	    product_IDX INT AUTO_INCREMENT PRIMARY KEY,
	    	    product_Name VARCHAR(50),
	    	    start_Date VARCHAR(50),
	    	    end_Date VARCHAR(50),
	    	    thumbnail_Img VARCHAR(255),
	    	    original_Price VARCHAR(255),
	    	    discount_Price VARCHAR(255),
	    	    discount_Rate VARCHAR(50),
	    	    detail_Img VARCHAR(255),
	    	    content_State VARCHAR(255),
	    	    ctgr_ID INT,
	    	    reg_ID INT
	    	);
select *from products;



drop table Products;
