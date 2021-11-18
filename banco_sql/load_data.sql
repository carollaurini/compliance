SET GLOBAL local_infile=1;
LOAD DATA LOCAL INFILE 'W:\Compliance\vbaProductClassProductsInfo-24Jun2021.txt'  
 INTO TABLE compliance.ativo 
 FIELDS TERMINATED BY '\t'   
 LINES TERMINATED BY '\n'  
 ( @Product
 , @ISIN
 )
 SET `ativo`   = @Product
   , `isin` = @ISIN
 ;