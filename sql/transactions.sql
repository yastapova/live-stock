-- ----- MANAGER LEVEL TRANSACTIONS ----- --

delimiter |
-- Sets the share price of a stock.
CREATE PROCEDURE setSharePrice(IN stock_sym VARCHAR(5), IN share_price FLOAT(2))
	BEGIN
		UPDATE Stock
		SET SharePrice = share_price
		WHERE StockSymbol = stock_sym;
    END
| delimiter ;

delimiter |
-- Adds an employee to the database.
CREATE PROCEDURE addEmployee(IN ssn CHAR(9), IN last_name VARCHAR(20),
							 IN first_name VARCHAR(20), IN address VARCHAR(50),
							 IN city VARCHAR(20), IN state VARCHAR(20),
							 IN zipcode CHAR(5), IN telephone CHAR(10),
							 IN start_date DATETIME, IN hourly_rate FLOAT(2),
							 IN pos VARCHAR(7))
	BEGIN
		INSERT INTO Employee(SSN, LastName, FirstName, Address, City, State, ZipCode, Telephone, StartDate, HourlyRate, Position_)
		VALUES (ssn, last_name, first_name, address, city, state, zipcode, telephone, start_date, hourly_rate, pos);
    END
| delimiter ;

delimiter |
-- Updates info for a given employee.
-- Only does the char attributes < does not work, can't put field in set
CREATE PROCEDURE updateEmployee(IN field CHAR(10), IN val CHAR(50), IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET field = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
-- Updates info for a given employee.
-- Only does the Timestamp_ attribute.
CREATE PROCEDURE updateEmployee2(IN val DATETIME, IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET StartDate = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
-- Updates info for a given employee.
-- Only does the HourlyRate attribute.
CREATE PROCEDURE updateEmployee3(IN val FLOAT(2), IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET HourlyRate = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
-- Deletes a given employee from the database.
CREATE PROCEDURE deleteEmployee(IN emp_id INT)
	BEGIN
		DELETE FROM Employee
        WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
-- Gets a sales report for a particular month and year.
CREATE PROCEDURE getSalesReport(IN yr INT, IN mon INT)
	BEGIN
		SELECT T.Transfee, T.OrderId
		FROM Transact T
		WHERE YEAR(T.Timestamp_) = yr
		AND MONTH(T.Timestamp_) = mon;
    END
| delimiter ;

delimiter |
-- Produces a list of all stocks and how many orders are
-- placed for each one.
CREATE PROCEDURE listAllStocks()
	BEGIN
		SELECT S.*, COUNT(O.StockSymbol) AS OrdersPlaced
		FROM Stock S, Order_ O
		WHERE S.StockSymbol = O.StockSymbol
		GROUP BY S.StockSymbol;
	END
| delimiter ;

delimiter |
-- Creates a list of orders that are ordered by stock symbol
-- or customer name.
CREATE PROCEDURE listOrdersBy(IN field CHAR(5))
	BEGIN
		IF(field = 'order')
        THEN SELECT *
			FROM Order_ O
			ORDER BY O.StockSymbol;
		END IF;
		IF(field = 'name')
        THEN SELECT O.*, C.FirstName, C.LastName
			FROM Order_ O, Customer C
			WHERE O.CusAccNum = C.CusId
			ORDER BY C.LastName, C.FirstName;
		END IF;
    END
| delimiter ;

delimiter |
-- Shows the total revenue produced by each stock.
CREATE PROCEDURE showStockRevenue()
	BEGIN
		SELECT S.StockSymbol, S.StockName, S.TotalRevenue
		FROM StockRevenue S;
    END
| delimiter ;

delimiter |
-- Shows the total revenue produced by each stock type. 
CREATE PROCEDURE showStockTypeRevenue()
	BEGIN
		SELECT S.StockType, S.TotalRevenue
		FROM StockTypeRevenue S;
    END
| delimiter ;

delimiter |
-- Shows the total revenue produced by each customer.
CREATE PROCEDURE showCustomerRevenue()
	BEGIN
		SELECT C.CusAccNum, C.FirstName, C.LastName, S.TotalRevenue
		FROM CustomerRevenue C;
    END
| delimiter ;

delimiter |
-- Shows the customer rep that generated the most
-- total revenue.
CREATE PROCEDURE showMaxEmployeeRevenue()
	BEGIN
		SELECT E.EmpId, E.TotalRevenue
		FROM EmployeeRevenue E
		WHERE E.TotalRevenue =
			(SELECT MAX(E.TotalRevenue)
			FROM EmployeeRevenue E);
    END
| delimiter ;

delimiter |
-- Shows the customer that generated the most total
-- revenue.
CREATE PROCEDURE showMaxCustomerRevenue()
	BEGIN
		SELECT C.CusAccNum, C.TotalRevenue
		FROM CustomerRevenue C
		WHERE C.TotalRevenue =
			(SELECT MAX(C.TotalRevenue)
			FROM CustomerRevenue C);
    END
| delimiter ;

delimiter |
-- Shows a list of the top n most actively traded stocks.
CREATE PROCEDURE showMostTradedStocks(IN n INT)
	BEGIN
		SELECT M.StockSymbol, M.StockName, M.NumOrders
		FROM MostTraded M
		ORDER BY NumOrders ASC
		LIMIT n;
    END
| delimiter ;

-- ----- CUSTOMER REPRESENTATIVE LEVEL TRANSACTIONS ----- --
delimiter |
-- Records an order, meaning it is ready to be executed.
CREATE PROCEDURE recordOrder(IN order_id INT)
	BEGIN
		UPDATE Order_ O
		SET Recorded = 1
		WHERE O.OrderId = order_id;
    END
| delimiter ;

delimiter |
-- Adds a customer to the database.
CREATE PROCEDURE addCustomer(IN last_name VARCHAR(20), IN first_name VARCHAR(20),
							 IN address VARCHAR(50), IN city VARCHAR(20),
                             IN state VARCHAR(20), IN zipcode CHAR(5),
                             IN telephone CHAR(10), IN email VARCHAR(50),
							 IN rating INT)
	BEGIN
		INSERT INTO Customer(LastName, FirstName, Address, City, State, ZipCode, Telephone, Email, Rating)
		VALUES (last_name, first_name, address, city, state, zipcode, telephone, email, rating);
    END
| delimiter ;

-- Update customer in db - doesn't work, see update emp for reason
delimiter |
CREATE PROCEDURE updateCustomer(IN field VARCHAR(10), IN val VARCHAR(50), IN cus_id INT)
	BEGIN
		UPDATE Customer C
		SET field = val
		WHERE CusId = cus_id;
    END
| delimiter ;

-- Delete a customer from db
delimiter |
CREATE PROCEDURE deleteCustomer(IN cus_id INT)
	BEGIN
		DELETE FROM Customer
        WHERE CusId = cus_id;
    END
| delimiter ;
-- Create the customer mailing list
delimiter |
CREATE PROCEDURE createCustomerMailingList()
	BEGIN
		SELECT CusId, LastName, FirstName, Email, Address, City, State, ZipCode
		FROM Customer;
    END
| delimiter ;


-- ----- CUSTOMER LEVEL TRANSACTIONS ----- --
-- Get customers current stock holdings
delimiter |
CREATE PROCEDURE getCustomerStockHoldings(IN customer_id INT)
	BEGIN
		SELECT P.AccNum, P.StockSymbol, P.NumShares, P.Stop, P.StopPrice
		FROM Portfolio P, Account A, Customer C
		WHERE P.AccNum = A.AccNum
			AND A.CusId = C.CusId
			AND C.CusId = customer_id;
    END
| delimiter ;

-- The share-price and trailing-stop history for a given conditional order
delimiter |
CREATE PROCEDURE getConditonalOrderTrailingStop(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp_
		FROM CONDITIONALPRICEHISTORY P
		WHERE P.OrderId = orderid  AND P.PriceType = 'Trailing Stop' AND P.StopPrice > 0;
    END
| delimiter ;

-- The share-price and hidden-stop history for a given conditional order
delimiter |
CREATE PROCEDURE getConditonalOrderHiddenStop(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp_
		FROM CONDITIONALPRICEHISTORY P
		WHERE P.OrderId = orderid  AND P.PriceType = 'Hidden Stop' AND P.StopPrice > 0;
    END
| delimiter ;

-- The share-price and hidden-stop history for a given conditional order
delimiter |
CREATE PROCEDURE getConditonalOrderHistory(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp_
		FROM CONDITIONALPRICEHISTORY P
		WHERE P.OrderId = orderid AND P.StopPrice > 0;
    END
| delimiter ;

-- The share-price history of a given stock over a certain period of time (e.g., past six months)
delimiter |
CREATE PROCEDURE getSharePriceHistory(IN stock_symbol VARCHAR(5), IN start_date DATE, IN end_date DATE)
	BEGIN
		SELECT P.SharePrice, P.Timestamp_
		FROM STOCKPRICEHISTORY P
		WHERE P.StockSymbol = stock_symbol 
		AND DATE(P.Timestamp_) BETWEEN start_date AND end_date;
    END
| delimiter ;

-- A history of all current and past orders a customer has placed.
delimiter |
CREATE PROCEDURE getCustomerOrdersHistory(IN customer_id INT)
	BEGIN
		SELECT O.Timestamp_, O.CusAccNum, O.OrderType, O.StockSymbol, O.NumShares, O.CurSharePrice, 	O.PriceType
		FROM Order_ O, Customer C, Account A
		WHERE O.CusAccNum = A.AccNum
		AND A.CusId = C.CusId AND C.CusId = customer_id;
    END
| delimiter ;

-- Stocks available of a particular type 
delimiter |
CREATE PROCEDURE getStockUsingType(IN stock_type CHAR(20)) 
	BEGIN
		SELECT S.*
		FROM STOCK S
		WHERE S.StockType LIKE CONCAT('%', stock_type, '%');

    END
| delimiter ;

-- Most-recent order info of a customer
delimiter |
CREATE PROCEDURE getMostRecentOrderInfo(IN cus_id INTEGER, IN stock_sym VARCHAR(5))
	BEGIN
		SELECT O.*
		FROM ORDER_ O, CUSTOMER C, ACCOUNT_ A
		WHERE O.CusAccNum = A.AccNum AND A.CusId = C.CusId 
			AND C.CusId = cus_id AND O.StockSymbol = stock_sym
			AND TIMESTAMPDIFF(MONTH, NOW(), O.Timestamp_) <= 3;

    END
| delimiter ;

-- Stocks available with a particular keyword or set of keywords in the stock name
delimiter |
CREATE PROCEDURE getStockUsingKeyword(IN stock_keyword CHAR(20)) 
	BEGIN
		SELECT S.*
		FROM STOCK S
		WHERE S.StockName LIKE CONCAT('%', stock_keyword, '%');
    END
| delimiter ;

-- Get the list of best selling stocks
delimiter |
CREATE PROCEDURE getBestSellers() 
	BEGIN
		SELECT B.StockSymbol, B.TotalShares
		FROM BestSellers B
		ORDER BY TotalShares desc 
		LIMIT 25;
    END
| delimiter ;

-- Get the list of best selling stocks in stock table format
delimiter |
CREATE PROCEDURE getBestSellers2() 
	BEGIN
		SELECT B.StockSymbol, B.StockName, B.StockType, B.SharePrice, B.NumAvailShares
		FROM BestSellers2 B
		ORDER BY TotalShares desc 
		LIMIT 25;
    END
| delimiter ;

-- Produce a list of stock suggestions for a given customer (based on that customer's past orders)
delimiter |
CREATE PROCEDURE Suggest(IN cus_id INT)
	BEGIN
		SELECT DISTINCT S.StockSymbol, S.StockName, S.StockType, S.SharePrice, S.NumAvailShares
		FROM Stock S, Order_ O, Account_ A
		WHERE (A.CusId = cus_id AND O.CusAccNum = A.AccNum AND O.StockSymbol = S.StockSymbol)
        GROUP BY S.StockSymbol;
	END
| delimiter ;

delimiter |

-- Adds entry to CondPriceHist for a hidden stop when a stock price changes.
-- Must call after updating stock price.
CREATE Procedure UpdateHiddenStop(IN new_stock_price FLOAT(2), IN old_stock_price FLOAT(2), IN stock_symbol CHAR(5))
	BEGIN
		IF (new_stock_price <> old_stock_price)
			THEN INSERT IGNORE INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
				SELECT DISTINCT O.OrderId, O.PriceType, O.StopPrice, new_stock_price, NOW()
				FROM Order_ O
				WHERE stock_symbol = O.StockSymbol
				AND O.PriceType IN ('Hidden Stop')
				AND O.Completed = 0;
		END IF;
        IF (new_stock_price <> old_stock_price)
			THEN SELECT DISTINCT O.OrderId, new_stock_price, O.StopPrice
				FROM Order_ O
				WHERE stock_symbol = O.StockSymbol
				AND O.PriceType IN ('Hidden Stop')
				AND O.Completed = 0;
        END IF;
    END;
|
delimiter ;

delimiter |
-- Adds entry to CondPriceHist for a trailing stop when a stock price changes.
-- Updates the current stop price if the current share goes up.
-- Must call after updating stock price.
CREATE PROCEDURE UpdateTrailingStop(IN new_stock_price FLOAT(2), IN old_stock_price FLOAT(2), IN stock_symbol CHAR(5))
	BEGIN
		IF (new_stock_price > old_stock_price)
        THEN INSERT IGNORE INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice)
			SELECT DISTINCT O.OrderId, O.PriceType, new_stock_price - O.StopDiff, new_stock_price
			FROM Order_ O, ConditionalPriceHistory C
			WHERE stock_symbol = O.StockSymbol
            AND C.Timestamp_= (SELECT DISTINCT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType = 'Trailing Stop'
            AND O.StopDiff < new_stock_price - C.StopPrice
            AND O.Completed = 0;
        END IF;
        IF (new_stock_price > old_stock_price)
			THEN SELECT DISTINCT O.OrderId, new_stock_price, C.StopPrice
			FROM Order_ O, ConditionalPriceHistory C
			WHERE stock_symbol = O.StockSymbol
            AND C.Timestamp_= (SELECT DISTINCT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType = 'Trailing Stop'
            AND O.StopDiff < new_stock_price - C.StopPrice
            AND O.Completed = 0;
        END IF;
        IF (new_stock_price < old_stock_price)
		THEN INSERT IGNORE INTO ConditionalPriceHistory(OrderId, PriceType, StopPrice, CurSharePrice, Timestamp_)
			SELECT DISTINCT O.OrderId, O.PriceType, C.StopPrice, new_stock_price, NOW()
            FROM Order_ O, ConditionalPriceHistory C
            WHERE stock_symbol = O.StockSymbol
            AND C.Timestamp_= (SELECT DISTINCT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType IN ('Trailing Stop')
            AND O.Completed = 0;
		END IF;
        IF (new_stock_price < old_stock_price)
			THEN SELECT DISTINCT O.OrderId, new_stock_price, C.StopPrice
            FROM Order_ O, ConditionalPriceHistory C
            WHERE stock_symbol = O.StockSymbol
            AND C.Timestamp_= (SELECT DISTINCT MAX(H.Timestamp_)
							  FROM ConditionalPriceHistory H
							  WHERE O.OrderId = H.OrderId)
            AND O.PriceType IN ('Trailing Stop')
            AND O.Completed = 0;
        END IF;
	END;
|
delimiter ;

delimiter |

CREATE PROCEDURE MarkComplete(IN order_id INT, IN cur_share_price FLOAT(2), IN stop_price FLOAT(2)) 
	BEGIN
		IF (cur_share_price <= stop_price
			AND 1 = (SELECT O.Recorded
					FROM ORDER_ O
					WHERE order_id = O.OrderId)
			AND (SELECT O.NumShares
				 FROM Order_ O
                 WHERE O.OrderId = order_id) <= 
                 (SELECT P.NumShares
                  FROM Portfolio P, Order_ O
                  WHERE P.StockSymbol = O.StockSymbol
                  AND O.OrderId = order_id
                  AND O.CusAccNum = P.AccNum))
            THEN UPDATE Order_ O
			SET O.Completed = 1
			WHERE O.OrderId = order_id;
		END IF;
	END;
|
delimiter ;

