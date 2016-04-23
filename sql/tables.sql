CREATE TABLE Stock (
	StockSymbol		VARCHAR(5) NOT NULL,
	StockName		VARCHAR(20) NOT NULL,
	StockType		VARCHAR(20),
	SharePrice		FLOAT(2) NOT NULL,
	NumAvailShares	INTEGER NOT NULL,
	PRIMARY KEY (StockSymbol),
	UNIQUE (StockName)
);

CREATE TABLE Employee (
	SSN				CHAR(9) NOT NULL,
	LastName		VARCHAR(20),
	FirstName		VARCHAR(20),
	Address			VARCHAR(50),
	City			VARCHAR(20),
	State			VARCHAR(20),
	ZipCode			CHAR(5),
	Telephone		CHAR(10),
	StartDate		DATETIME,
	HourlyRate		FLOAT(2),
	EmpId			INTEGER AUTO_INCREMENT NOT NULL,
	Position_		VARCHAR(7) NOT NULL,
	PRIMARY KEY (EmpId),
	UNIQUE (SSN)
);


CREATE TABLE Customer (
	LastName		VARCHAR(20) NOT NULL,
	FirstName		VARCHAR(20) NOT NULL,
	Address			VARCHAR(50),
	City			VARCHAR(20),
	State			VARCHAR(20),
	ZipCode			CHAR(5),
	Telephone		CHAR(10),
	Email			VARCHAR(50),
	Rating			INTEGER NOT NULL,
	CusId			INTEGER AUTO_INCREMENT NOT NULL,
	PRIMARY KEY (CusId)
);

-- AccType: 1 for customer, 2 for employee, 3 for manager
CREATE TABLE Login (
	Usr				VARCHAR(20) NOT NULL,
	Pwd				VARCHAR(20) NOT NULL,
	AccType			INTEGER NOT NULL,
	Id				INTEGER NOT NULL,
	PRIMARY KEY (Usr)
);

CREATE TABLE Account_ (
	AccNum			INTEGER AUTO_INCREMENT NOT NULL,
	AccCreDate		DATETIME,
	CreditCNum		VARCHAR(16) NOT NULL,
	CusId			INTEGER NOT NULL,
	PRIMARY KEY (AccNum),
	FOREIGN KEY (CusId) REFERENCES Customer (CusId)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);

CREATE TABLE Order_ (
	OrderId			INTEGER AUTO_INCREMENT,
	StockSymbol		VARCHAR(5),
	OrderType		VARCHAR(4) NOT NULL,
	NumShares		INTEGER NOT NULL,
	CusAccNum		INTEGER DEFAULT 0,
	Timestamp_		DATETIME DEFAULT NOW() NOT NULL,
	PriceType		VARCHAR(15) NOT NULL,
	StopPrice		FLOAT(2) DEFAULT 0,
    StopDiff		FLOAT(2),
	CurSharePrice	FLOAT(2),
	EmpId			INTEGER DEFAULT 0,
	Recorded		BOOLEAN DEFAULT 0,
    Completed		BOOLEAN DEFAULT 0,
	PRIMARY KEY (OrderId),
	UNIQUE (StockSymbol, Timestamp_, CusAccNum, EmpId),
	FOREIGN KEY (StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (CusAccNum) REFERENCES Account_ (AccNum)
		ON DELETE SET NULL	-- changed from SET DEFAULT
		ON UPDATE CASCADE,
	FOREIGN KEY (EmpId) REFERENCES Employee (EmpId)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

CREATE TABLE Transact (
	Id 				INTEGER AUTO_INCREMENT, 
	OrderId			INTEGER,
	TransFee 		FLOAT(2), 
	TimeStamp_ 		DATETIME DEFAULT NOW() NOT NULL, 
	PricePerShare 	FLOAT(2),
	PRIMARY KEY (Id),
	FOREIGN KEY (OrderId) REFERENCES Order_ (OrderId)
		ON DELETE SET NULL
		ON UPDATE CASCADE
 );

            
CREATE TABLE Portfolio (
	AccNum			INTEGER,
	StockSymbol		CHAR(5),
	NumShares		INTEGER,
	Stop_			VARCHAR(8) NOT NULL,
	StopPrice		FLOAT(2),
	PRIMARY KEY (AccNum, StockSymbol),
	FOREIGN KEY (AccNum) REFERENCES Account_ (AccNum)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE ConditionalPriceHistory (
	OrderId			INTEGER,
	CurSharePrice	FLOAT(2),
	PriceType		VARCHAR(15) NOT NULL,
	StopPrice		FLOAT(2),
	Timestamp_		DATETIME DEFAULT NOW(),
	PRIMARY KEY(OrderId, PriceType, Timestamp_),
	FOREIGN KEY(OrderId) REFERENCES Order_ (OrderId)
		ON DELETE CASCADE	-- fix
		ON UPDATE CASCADE
);

CREATE TABLE StockPriceHistory (
	StockSymbol		VARCHAR(5),
	SharePrice		FLOAT(2),
	Timestamp_		DATETIME DEFAULT NOW(),
	PRIMARY KEY(StockSymbol, Timestamp_),
	FOREIGN KEY(StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
