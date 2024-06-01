CREATE TABLE SHOP (
    ShopID NUMBER(4) NOT NULL PRIMARY KEY,
    shopName VARCHAR2(50),
    shopAddress VARCHAR2(50),
    postcode NUMBER(4),
    phone NUMBER(11),
    email VARCHAR2(50),
    managerID NUMBER(4)
);


CREATE TABLE catalog (
    catalogID NUMBER(4) NOT NULL PRIMARY KEY,
    ShopID NUMBER(4),
    productID NUMBER(4),
    price NUMBER(4),
    stock NUMBER(4),
    FOREIGN KEY (ShopID) REFERENCES SHOP(ShopID)
);

-- create the data for the tables

INSERT INTO SHOP (ShopID, shopName, shopAddress, postcode, phone, email, managerID) VALUES (1, 'Example Shop 1', '123 Main Street', 12345, 1234567890, 'example1@example.com', 101);
INSERT INTO SHOP (ShopID, shopName, shopAddress, postcode, phone, email, managerID) VALUES (2, 'Example Shop 2', '456 Elm Street', 54321, 9876543210, 'example2@example.com', 102);
INSERT INTO SHOP (ShopID, shopName, shopAddress, postcode, phone, email, managerID) VALUES (3, 'Example Shop 3', '789 Oak Street', 67890, 5678901234, 'example3@example.com', 103);

INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (1, 1, 1001, 2999, 50);
INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (2, 1, 1002, 1999, 30);
INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (3, 2, 1003, 3999, 20);
INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (4, 2, 1004, 4999, 10);
INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (5, 3, 1005, 5999, 15);
INSERT INTO catalog (catalogID, ShopID, productID, price, stock) VALUES (6, 3, 1006, 6999, 25);


select price, count(*) * 100.0 / (select count(*) from catalog) as Tax
from catalog
group by price;

SELECT 
    price, 
    Tax, 
    price + Tax AS total
FROM 
    (SELECT 
        price, 
        ROUND(count(*) * 100.0 / (SELECT count(*) FROM catalog), 2) AS Tax
     FROM 
        catalog
     GROUP BY 
        price) subquery;

-- calculate the total cost of all the shop and the shop name with stock

SELECT  shopname
FROM SHOP;
SELECT stock
FROM catalog;

-- join 

SELECT  shopname
FROM SHOP;
FULL OUTER JOIN catalog
on shop.ShopID = catalog.ShopID
where stock > 20;


SELECT 
    shop.shopName, 
    SUM(catalog.stock ) AS totalStock,
    SUM(catalog.price * catalog.stock) AS totalValue
FROM 
    SHOP
FULL OUTER JOIN 
    catalog ON shop.ShopID = catalog.ShopID
GROUP BY 
    shop.shopName;

