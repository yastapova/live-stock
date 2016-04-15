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

-- Check that the rating is between 0 and 10
CREATE TRIGGER Ratings 
	BEFORE INSERT ON Customer FOR EACH ROW
		SET NEW.Rating = IF
			(NEW.Rating > -1 AND NEW.Rating < 11,
			NEW.Rating,
            NULL);

-- Make sure the Order being added is for a valid number of shares.
CREATE TRIGGER NumSharesValid
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.NumShares = IF
			(NEW.NumShares > 0,
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

-- Calculates the difference between stop price and current price.
CREATE TRIGGER CalcStopDiff
	BEFORE INSERT ON Order_ FOR EACH ROW
		SET NEW.StopDiff = IF
			(NEW.PriceType IN ('Trailing Stop', 'Hidden Stop'),
            NEW.CurSharePrice - NEW.StopPrice,
            NULL);

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
-- Executes a transaction for an order.
-- Checks to make sure that the number of shares being
-- bought or sold is correct.
CREATE TRIGGER DoTransact
	BEFORE UPDATE ON Order_ FOR EACH ROW
		IF(NEW.Recorded <> OLD.Recorded)
			THEN IF(NEW.OrderType = 'Sell')
				THEN IF(NEW.PriceType = 'Market')
					THEN IF(NEW.NumShares <= 
							(SELECT P.NumShares
							FROM Portfolio P
							WHERE NEW.CusAccNum = P.AccNum
							AND NEW.StockSymbol = P.StockSymbol))
						THEN INSERT INTO Transact(OrderId)
							VALUES(NEW.OrderId);
						SET NEW.Completed = 1;
					END IF;
				END IF;
                IF(NEW.PriceType <> 'Market')
					THEN IF(NEW.NumShares <= 
							(SELECT P.NumShares
							FROM Portfolio P
							WHERE NEW.CusAccNum = P.AccNum
							AND NEW.StockSymbol = P.StockSymbol)
                            AND EXISTS(SELECT *
										FROM ConditionalPriceHistory C
                                        WHERE C.CurSharePrice <= C.StopPrice
                                        AND C.OrderId = NEW.OrderId)
                                        AND C.Timestamp_= (SELECT MAX(H.Timestamp_)
															FROM ConditionalPriceHistory H
															WHERE O.OrderId = H.OrderId))
						THEN INSERT INTO Transact(OrderId)
							VALUES(NEW.OrderId);
						SET NEW.Completed = 1;
					END IF;
                END IF;
			END IF;
            IF(NEW.OrderType = 'Buy')
				THEN IF(NEW.NumShares <= 
						(SELECT S.NumAvailShares
						FROM Stock S
						WHERE NEW.StockSymbol = S.StockSymbol))
					THEN INSERT INTO Transact(OrderId)
						VALUES(NEW.OrderId);
					SET NEW.Completed = 1;
				END IF;
			END IF;
        END IF;
|
delimiter ;

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
-- Adds or subtracts shares from the portfolio following an order transaction.
CREATE TRIGGER UpdatePortfolio
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Portfolio P
		SET P.NumShares = P.NumShares + 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
				FROM Order_ O, Account_ A
				WHERE NEW.OrderId = O.OrderId
				AND O.CusAccNum = A.AccNum
				AND O.StockSymbol = P.StockSymbol
                AND P.AccNum = A.AccNum
				LIMIT 1)
		WHERE P.AccNum = 
			(SELECT A.AccNum
            FROM Account_ A, Order_ O
            WHERE NEW.OrderID = O.OrderId
			AND O.CusAccNum = A.AccNum
            AND O.StockSymbol = P.StockSymbol);
	END;
|
delimiter ;

-- Make sure that the price type is allowed.
CREATE TRIGGER PriceTypes2
	BEFORE INSERT ON ConditionalPriceHistory FOR EACH ROW
		SET NEW.PriceType = IF
			(NEW.PriceType IN ('Market', 'Market on Close', 'Trailing Stop', 'Hidden Stop'),
			NEW.PriceType,
            NULL);
            
delimiter |
-- Execute a transact for an order with a stop price.
CREATE TRIGGER SellOrder
	AFTER INSERT ON ConditionalPriceHistory FOR EACH ROW
    BEGIN
		IF (NEW.CurSharePrice <= NEW.StopPrice 
			AND 1 = (SELECT O.Recorded
					FROM ORDER_ O
					WHERE NEW.OrderId = O.OrderId))
		THEN INSERT INTO Transact (OrderId, PricePerShare)
			VALUES (NEW.OrderId, NEW.CurSharePrice);
		END IF;
	END;
|
delimiter ;

delimiter |
-- Adds an entry to CondPriceHist when an order is placed with a stock.
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
-- Adds entry to CondPriceHist for a hidden stop when a stock price changes.
CREATE TRIGGER UpdateHiddenStop
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
-- Adds entry to CondPriceHist for a trailing stop when a stock price changes.
-- Updates the current stop price if the current share goes up.
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

-- Adds an entry to StockPriceHistory when a stock is created.
CREATE TRIGGER InitialAddToStockPriceHistory
	AFTER INSERT ON Stock FOR EACH ROW
		INSERT INTO StockPriceHistory(StockSymbol, SharePrice)
        VALUES(NEW.StockSymbol, NEW.SharePrice);

delimiter |
-- Adds an entry to StockPriceHistory when a stock price changes.
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

delimiter |
-- Updates the number of available shares of a stock
-- after an order is executed.
CREATE TRIGGER UpdateStockQuantity
	BEFORE INSERT ON Transact FOR EACH ROW
    BEGIN
		UPDATE Stock S
		SET S.NumAvailShares = S.NumAvailShares - 
			(SELECT O.NumShares * POW(-1, O.OrderType = 'Sell')
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId)
		WHERE S.StockSymbol = 
			(SELECT O.StockSymbol
			FROM Order_ O
			WHERE NEW.OrderId = O.OrderId);
	END;
|
delimiter ;

delimiter |
-- Updates rating for customer after an order is placed.
CREATE TRIGGER UpdateRating
	BEFORE INSERT ON Order_ FOR EACH ROW
    BEGIN
		UPDATE Customer C
        SET C.Rating = MAX(C.Rating+1, 10)
		WHERE C.CusId = (SELECT A.CusId
						FROM Account A
                        WHERE NEW.CusAccNum=A.AccNum)
    END;

delimiter ;