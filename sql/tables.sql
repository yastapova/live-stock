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

-- Check that the position is in the allowed domain.
CREATE TRIGGER Positions 
	BEFORE INSERT ON Employee FOR EACH ROW
		SET NEW.Position_ = IF
			(NEW.Position_ IN ('Manager', 'CusRep', 'Other'),
			NEW.Position_,
            NULL);
            

-- Make sure share price is positive.
CREATE TRIGGER SharePriceValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.SharePrice = IF
		(NEW.SharePrice > 0,
        NEW.SharePrice,
        NULL);
        
-- Make sure that there is not a negative number of shares available.
CREATE TRIGGER AvailSharesValid
	BEFORE INSERT ON Stock FOR EACH ROW
	SET NEW.NumAvailShares = IF
		(NEW.NumAvailShares > -1,
        NEW.NumAvailShares,
        NULL);

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

-- Check that the rating is between 0 and 10
CREATE TRIGGER Ratings 
	BEFORE INSERT ON Customer FOR EACH ROW
		SET NEW.Rating = IF
			(NEW.Rating > -1 AND NEW.Rating < 11,
			NEW.Rating,
            NULL);

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

-- Make sure the Order being added is for a valid number of shares.
CREATE TRIGGER NumSharesValid
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.NumShares = IF
			(NEW.NumShares <= (SELECT S.NumAvailShares FROM Stock S WHERE S.StockSymbol = NEW.StockSymbol)
            AND NEW.NumShares > 0,
            NEW.NumShares,
            NULL);

-- Change the prices on an inserted Order.
CREATE TRIGGER GetPrices
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.CurSharePrice = (SELECT S.SharePrice FROM Stock S WHERE S.StockSymbol = NEW.StockSymbol);
		
-- Make sure the order type is in the domain allowed.
CREATE TRIGGER OrderTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.OrderType = IF
			(NEW.OrderType IN ('Buy', 'Sell'),
			NEW.OrderType,
            NULL);

-- Make sure that the price type is allowed.
CREATE TRIGGER PriceTypes 
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.PriceType = IF
			(NEW.PriceType IN ('Market', 'Market on Close', 'Trailing Stop', 'Hidden Stop'),
			NEW.PriceType,
            NULL);
            
CREATE TRIGGER CalcStopDiff
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.StopDiff = IF
			(NEW.PriceType IN ('Trailing Stop', 'Hidden Stop'),
            NEW.CurSharePrice - NEW.StopPrice,
            NULL);

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

delimiter |
-- Set price and fee in Transact table.
CREATE TRIGGER GetPrices2
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN 
		SET NEW.PricePerShare = (SELECT S.SharePrice
								 FROM Stock S, Order_ O
								 WHERE S.StockSymbol = O.StockSymbol
										AND O.OrderId = NEW.OrderId);
		SET NEW.TransFee = NEW.PricePerShare * (SELECT O.NumShares FROM Order_ O WHERE O.OrderId = NEW.OrderId) * 0.05;
	END;
|
delimiter ;

delimiter |
CREATE TRIGGER DoTransact
	BEFORE UPDATE ON Order_ FOR EACH ROW
		IF(NEW.Recorded <> OLD.Recorded)
			THEN INSERT INTO Transact(OrderId)
				VALUES(NEW.OrderId);
			SET NEW.Completed = 1;
        END IF;
|
delimiter ;
            
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


-- Check that the stop is in the allowed domain.
CREATE TRIGGER Stops 
	BEFORE INSERT ON Portfolio FOR EACH ROW
		SET NEW.Stop_ = IF
			(NEW.Stop_ IN ('Trailing', 'Hidden', 'None'),
			NEW.Stop_,
            NULL);
            
-- Make sure that there is not a negative number of shares.
CREATE TRIGGER NumSharesValid2
	BEFORE INSERT ON Portfolio FOR EACH ROW
	SET NEW.NumShares = IF
		(NEW.NumShares > -1,
        NEW.NumShares,
        NULL);

delimiter |
CREATE TRIGGER UpdatePortfolio
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE (Portfolio P
        INNER JOIN Account_ C ON (P.AccNum = C.AccNum)) AS J
        INNER JOIN Order_ Q ON (Q.CusAccNum = J.AccNum)
		SET NumShares = NumShares + 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
				FROM Order_ O, Account_ A
				WHERE NEW.OrderId = O.OrderId
				AND O.CusAccNum = A.AccNum
				AND O.StockSymbol = P.StockSymbol
                AND P.AccNum = A.AccNum
				LIMIT 1);
	END;
|
delimiter ;

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

-- Make sure that the price type is allowed.
CREATE TRIGGER PriceTypes2
	BEFORE INSERT ON ConditionalPriceHistory FOR EACH ROW
		SET NEW.PriceType = IF
			(NEW.PriceType IN ('Market', 'Market on Close', 'Trailing Stop', 'Hidden Stop'),
			NEW.PriceType,
            NULL);
            
delimiter |
CREATE TRIGGER SellOrder
	AFTER INSERT ON ConditionalPriceHistory FOR EACH ROW
    BEGIN
		IF (NEW.CurSharePrice <= NEW.StopPrice)
		THEN INSERT INTO Transact (OrderId, PricePerShare)
			VALUES (NEW.OrderId, NEW.CurSharePrice);
		END IF;
	END;
|
delimiter ;

delimiter |
CREATE TRIGGER InitalAddToConditionalPriceHistoryShare
	AFTER INSERT ON Order_ FOR EACH ROW
	BEGIN
		IF (NEW.PriceType IN ('Trailing Stop', 'Hidden Stop'))
		THEN INSERT INTO ConditionalPriceHistory(OrderId, CurSharePrice, PriceType, StopPrice)
			VALUES(NEW.OrderId, NEW.CurSharePrice, NEW. PriceType, NEW.StopPrice);
        END IF;
	END;
|
delimiter ;

delimiter |
CREATE TRIGGER AddToConditionalPriceHistoryShare
	AFTER UPDATE ON Stock FOR EACH ROW
    IF (NEW.SharePrice <> OLD.SharePrice)
		THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
			SELECT O.OrderId, O.PriceType, O.StopPrice, NEW.SharePrice, NOW()
            FROM Order_ O
            WHERE NEW.StockSymbol = O.StockSymbol
            AND O.PriceType IN ('Hidden Stop')
            AND O.Completed = 0;
	END IF;
|
delimiter ;

delimiter |
CREATE TRIGGER UpdateTrailingStop
	AFTER UPDATE ON Stock FOR EACH ROW
	BEGIN
		IF (NEW.SharePrice > OLD.SharePrice)
        THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice)
			(SELECT O.OrderId, O.PriceType, NEW.SharePrice - O.StopDiff, NEW.SharePrice
			FROM Order_ O, ConditionalPriceHistory C
			WHERE NEW.StockSymbol = O.StockSymbol
            AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType = 'Trailing Stop'
            AND O.StopDiff < NEW.SharePrice - C.StopPrice
            AND O.Completed = 0);
        END IF;
        IF (NEW.SharePrice < OLD.SharePrice)
		THEN INSERT INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
			SELECT O.OrderId, O.PriceType, C.StopPrice, NEW.SharePrice, NOW()
            FROM Order_ O, ConditionalPriceHistory C
            WHERE NEW.StockSymbol = O.StockSymbol
            AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType IN ('Trailing Stop')
            AND O.Completed = 0;
		END IF;
	END;
|
delimiter ;

CREATE TABLE StockPriceHistory (
	StockSymbol		VARCHAR(5),
	SharePrice		FLOAT(2),
	Timestamp_		DATETIME DEFAULT NOW(),
	PRIMARY KEY(StockSymbol, Timestamp_),
	FOREIGN KEY(StockSymbol) REFERENCES Stock (StockSymbol)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TRIGGER InitialAddToStockPriceHistory
	AFTER INSERT ON Stock FOR EACH ROW
		INSERT INTO StockPriceHistory(StockSymbol, SharePrice)
        VALUES(NEW.StockSymbol, NEW.SharePrice);

delimiter |
CREATE TRIGGER AddToStockPriceHistory
	AFTER UPDATE ON Stock FOR EACH ROW
    BEGIN
		IF (NEW.SharePrice <> OLD.SharePrice)
		THEN INSERT INTO StockPriceHistory(StockSymbol, SharePrice)
			VALUES(NEW.StockSymbol, NEW.SharePrice);
		END IF;
	END;
|
delimiter ;
        
