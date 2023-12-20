
CREATE TABLE Products (
	    	    Product_IDX INT AUTO_INCREMENT PRIMARY KEY,
	    	    Product_Name VARCHAR(50),
	    	    Start_Date VARCHAR(50),
	    	    End_Date VARCHAR(50),
	    	    Thumbnail_Img VARCHAR(255),
	    	    Original_Price INT,
	    	    Discount_Price INT,
	    	    Discount_Rate VARCHAR(50),
	    	    Detail_Img VARCHAR(255),
	    	    Content_State VARCHAR(255),
	    	    Ctgr_ID INT,
	    	    Reg_ID INT
	    	);
select *from products;


drop table Products;
