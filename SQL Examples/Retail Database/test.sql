CREATE Database test;


CREATE TABLE Customer(CustomerID int UNIQUE NOT NULL , CustomerName varchar(25) NOT NULL,
						CustomerAddress varchar(45) NOT NULL, CustomerState varchar(20),
						CustomerZipcode int, CustomerEmail varchar(25) UNIQUE NOT NULL,
						CustomerPassword varchar(25) NOT NULL, CustomerPhone varchar(15) UNIQUE,
						CONSTRAINT cusIDPK PRIMARY KEY(CustomerID));

CREATE TABLE CutomerAccount(BankAccountNumber int NOT NULL, BankName varchar(25) NOT NULL,
							BankAccountName int NOT NULL, CustomerID int NOT NULL,
                            CONSTRAINT BANPK PRIMARY KEY(BankAccountNumber),
                            CONSTRAINT CusFK FOREIGN KEY(CustomerID)
							REFERENCES Customer(CustomerID));
                            


CREATE TABLE Supplier(SupplierID int NOT NULL, SupplierName varchar(25) NOT NULL,
						SupplierAddress varchar(45) NOT NULL, SupplierState varchar(20) NOT NULL,
						SupplierZipcode int NOT NULL, SupplierEmail varchar(25) NOT NULL,
						CustomerPhone varchar(15) NOT NULL,
						CONSTRAINT supIDPK PRIMARY KEY(SupplierID));
                   
CREATE TABLE SupplierAccount(BankAccountNumber int NOT NULL, BankName varchar(25) NOT NULL,
								BankAccountName int NOT NULL, SupplierID int NOT NULL
								CONSTRAINT BANS_PK PRIMARY KEY(BankAccountNumber),
								CONSTRAINT SupFK FOREIGN KEY(SupplierID)
								REFERENCES Supplier(SupplierID));


CREATE TABLE Item(ItemID int NOT NULL, ItemName int NOT NULL,
					ItemType int, ItemColor int,
                    ItemPrice int NOT NULL, AvailableStock int NOT NULL,
                    CONSTRAINT IIDPK PRIMARY KEY(ItemID));
                           
CREATE TABLE OrderTable(OrderID int NOT NULL, ItemID int NOT NULL,
						ItemQuantity int NOT NULL, PriceOfOrder int NOT NULL,
						Discounts int NOT NULL, OrderTotal int NOT NULL,
						SupplierID int NOT NULL, CustomerID int NOT NULL,
						CONSTRAINT oIDPK PRIMARY KEY(OrderID),
						CONSTRAINT Cusc_FK FOREIGN KEY(CustomerID)
							REFERENCES Customer(CustomerID),
						CONSTRAINT Sups_FK FOREIGN KEY(SupplierID)
							REFERENCES Supplier(SupplierID),
						CONSTRAINT Supi_FK FOREIGN KEY(ItemID)
							REFERENCES Item(ItemID));                    


                   
CREATE TABLE Item_has_Order(ItemID int NOT NULL, OrderID int NOT NULL,
							ItemQuantity int NOT NULL, ItemPrice int NOT NULL,
                            PriceOfOrder int NOT NULL,
                            CONSTRAINT IIDI_PK PRIMARY KEY(ItemID, OrderID));

CREATE TABLE Order_has_Supplier(OrderID int NOT NULL, SupplierID int NOT NULL,
								CONSTRAINT OIDO_PK PRIMARY KEY(OrderID, SupplierID));
                               
SELECT *
FROM Item;

INSERT INTO Supplier(SupplierID, SupplierName, SupplierAddress, SupplierState, SupplierZipcode, SupplierEmail, SupplierPhone)
VALUES(1, 'Aaron Son', '3 8th Street', 'NC', 17357, 'aaronson@gmail.com', '523-543-2055'),
		(2, 'Moe Green', '345 9th St.', 'MI', 20502, 'moregreen@gmail.com', '116-643-8585'),
       (3, 'Sam Smith', '301 Pink St.', 'AZ', 10593, 'samsmith@gmail.com', '854-245-6375'),
       (4, 'Miley Williams', '711 Saint St.', 'NY', 30575, 'mileywillams@gmail.com', '234-654-3573');

INSERT INTO Customer(CustomerID, CustomerName, CustomerAddress, CustomerState, CustomerZipcode, CustomerEmail, CustomerPassword, CustomerPhone)
VALUES(1, 'Sally Mae', '8 5th Street', 'PA', 17485, 'sallymae@gmail.com', 'catsareawesome', '917-717-4141'),
		(2, 'Mary White', '901 8th St.', 'NY', 09102, 'marywhite@gmail.com', 'dogsaredope', '191-234-4121'),
       (3, 'Jen Green', '91 Pear St.', 'AZ', 41317, 'jengreen@gmail.com', 'fisharefriends', '103-413-5436'),
       (4, 'Betty Rock', '101 Saint St.', 'NC', 12954, 'bettyrock@gmail.com', 'fisharefood', '432-653-8203');

INSERT INTO Item (ItemID, ItemName, ItemType, ItemColor, ItemPrice, AvailableStock)
VALUES(1, 'Basketball', 'Sporting Goods', 'Orange', 10, 200),
      (2, 'Football', 'Sporting Goods', 'Brown', 9, 400),
      ( 3, 'Baseball', 'Sporting Goods', 'White', 7, 800),
       (4, 'Soccer Ball', 'Sporting Goods', 'White', 10, 300);
       
UPDATE Item
SET ItemName='Golf Ball'
WHERE ItemID=3;

DELETE FROM Item
WHERE ItemColor='Orange';

SELECT ItemName, ItemType
FROM Item
WHERE ItemPrice >=9;


INSERT INTO Item (ItemID, ItemName, ItemType, ItemColor, ItemPrice, AvailableStock)
VALUES(5, 'Knife', 'Home Goods', 'Silver', 8, 400),
	   (6, 'Plate', 'Home Goods', 'White', 5, 70),
       (7, 'Scissor', 'Home Goods', 'Black', 4, 80),
       (8, 'Spoon', 'Home Goods', 'Silver', 1, 35);
       

   


INSERT INTO OrderTable(OrderID, ItemID, ItemQuantity, PriceOfOrder, Discounts, OrderTotal, SupplierID, CustomerID)
VALUES(1, 5, 3, 27, 3, 24, 4, 3),
		(2, 7, 5, 20, 6, 14, 2, 2),
       (3, 3, 7, 49, 4, 45, 1, 4),
       (4, 5, 6, 48, 3, 45, 4, 3
);


SELECT ItemColor, Count(*) 
FROM Item
WHERE ItemID>2
GROUP BY ItemColor
HAVING Count(ItemColor)>=2;


SELECT * 
FROM Item
WHERE AvailableStock>= (SELECT MIN(AvailableStock) FROM Item);


SELECT IT.ItemID, IT.ItemName, IT.ItemType, IT.ItemColor, IT.ItemPrice, OD.SupplierID
FROM Item IT INNER JOIN OrderTable OD
ON IT.ItemID = OD.ItemID
WHERE IT.Itemid>=5;