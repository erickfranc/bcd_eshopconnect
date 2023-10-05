CREATE DATABASE eshop_connect_a;
USE eshop_connect_a;

CREATE TABLE users(
	pk_userId 	INT NOT NULL,
    name 		VARCHAR(50) NOT NULL,
    phoneNum 	CHAR(12) NOT NULL,
    
    PRIMARY KEY(pk_userid)
);

CREATE TABLE buyer(
	pk_userId		INT NOT NULL,
    
    PRIMARY KEY(pk_userId),
    FOREIGN KEY(pk_userId) references users(pk_userId)
);

CREATE TABLE seller(
	pk_userId		INT NOT NULL,
    
    PRIMARY KEY(pk_userId),
    FOREIGN KEY(pk_userId) references users(pk_userId)
);

CREATE TABLE BankCard(
	pk_cardNumber 	VARCHAR(20) NOT NULL,
    expiryDate 		DATE,
    bank 			VARCHAR(20),
    
    PRIMARY KEY(pk_cardNumber)
);

CREATE TABLE creditCard(
	pk_cardNumber	VARCHAR(20) NOT NULL,
    fk_userId		INT NOT NULL,
    organization 	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) references bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userId) references users(pk_userId)
);

CREATE TABLE debitCard(
	pk_cardNumber	VARCHAR(20) NOT NULL,
    fk_userId		INT NOT NULL,
    organization 	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) references bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userId) references users(pk_userId)
);

CREATE TABLE store(
	pk_sid			INT NOT NULL,
	name 			VARCHAR(20),
    startDate 		DATE,
    customerGrade 	INT,
    streetAddr 		VARCHAR(20),
    city 			VARCHAR(20),
    province 		VARCHAR(20),
    
    PRIMARY KEY		(pk_sid)
);

CREATE TABLE brand(
	pk_brandName	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_brandName)
);

CREATE TABLE product(
	pk_pid 			INT NOT NULL,
    fk_sid 			INT NOT NULL,
    name			VARCHAR(100),
    fk_brand 		VARCHAR(20),
    type 			VARCHAR(50),
    modelNumber 	VARCHAR(50),
    color 			VARCHAR(50),
    amount 			INT,
    price 			INT,
    
    PRIMARY KEY(pk_pid),
    FOREIGN KEY(fk_sid) references store(pk_sid),
    FOREIGN KEY(fk_brand)references brand(pk_brandName)
);

CREATE TABLE OrderItem(
	pk_itemId 		INT NOT NULL,
    fk_pid 			INT NOT NULL,
    price 			Decimal,
    creationTime 	DATE,
    
    PRIMARY KEY(pk_itemId),
    FOREIGN KEY(fk_pid) references product(pk_pid)
);

CREATE TABLE orders(
	pk_orderNumber 	INT NOT NULL,
    paymentState	VARCHAR(12),
    creationTime 	DATE,
    totalAmount 	DECIMAL(10,2),
    
    PRIMARY KEY(pk_orderNumber)
);

CREATE TABLE comments(
	creationTime 	TIME NOT NULL,
    fk_userId 		INT NOT NULL,
    fk_pid 			INT NOT NULL,
    grade 			FLOAT,
    content 		VARCHAR(100),
    
    PRIMARY KEY(creationTime,fk_userId,fk_pid), #CHAVE COMPOSTA
    FOREIGN KEY(fk_userId) references users(pk_userId),
    FOREIGN KEY(fk_pid) references product(pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid 		INT NOT NULL,
    streetaddr 		VARCHAR(40),
    city 			VARCHAR(30),
    province 		VARCHAR(20),
    startTime 		TIME,
    endTime 		TIME,
    
    PRIMARY KEY(pk_spid)
);

CREATE TABLE Save_To_Shopping_Cart(
	pk_userId 		INT NOT NULL,
    pk_pid 			INT NOT NULL,
    addTime 		DATE,
    quantity 		INT,
    
    PRIMARY KEY(pk_userId, pk_pid), #CHAVE COMPOSTA
    FOREIGN KEY(pk_userId) references buyer(pk_userId),
    FOREIGN KEY(pk_pid) references product(pk_pid)
);

CREATE TABLE contain(
	pk_orderNumber	INT NOT NULL,
    fk_itemId 		INT NOT NULL,
    quantity 		INT,
    
    PRIMARY KEY(pk_orderNumber, fk_itemId),
    FOREIGN KEY(pk_orderNumber) references orders(pk_orderNumber),
    FOREIGN KEY(fk_itemId) references orderItem(pk_itemId)
);

CREATE TABLE payment(
	fk_orderNumber INT NOT NULL,
    fk_cardNumber  VARCHAR(25) NOT NULL,
    payTime		   DATETIME,
    
    PRIMARY KEY(fk_orderNumber, fk_cardNumber),
    FOREIGN KEY(fk_orderNumber) references orders(pk_orderNumber),
    FOREIGN KEY(fk_cardNumber) references bankCard(pk_cardNumber)
);

CREATE TABLE address(
	pk_addrId			INT NOT NULL,
    fk_userId			INT NOT NULL,
    name 				VARCHAR(50),
    contactPhoneNumber  VARCHAR(20),
    province 			VARCHAR(100),
    city 				VARCHAR(100),
    streetaddr 			VARCHAR(100),
    postCode			VARCHAR(12),
    
    PRIMARY KEY(pk_addrId),
    FOREIGN KEY(fk_userId) references users(pk_userId)
);

CREATE TABLE deliver_to(
	fk_addrId 			INT NOT NULL,
    fk_orderNumber 		INT NOT NULL,
    timeDelivered 		DATE,
    
    PRIMARY KEY(fk_addrId, fk_orderNumber),
    FOREIGN KEY(fk_addrId) references address(pk_addrId),
    FOREIGN KEY(fk_orderNumber) references orders(pk_orderNumber)
);

CREATE TABLE manage(
	fk_userId 			INT NOT NULL,
    fk_sid 				INT NOT NULL,
    setUpTime 			DATE,
    
    PRIMARY KEY(fk_userId, fk_sid),
    FOREIGN KEY(fk_userId) references seller(pk_userId),
    FOREIGN KEY(fk_sid) references store (pk_sid)
);

CREATE TABLE After_Sales_Service_At(
	fk_brandName 		VARCHAR(20) NOT NULL,
    fk_spid				INT NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) references brand (pk_brandName),
    FOREIGN KEY(fk_spid) references servicePoint(pk_spid)
);

SHOW TABLES