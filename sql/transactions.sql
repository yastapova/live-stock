-- ----- MANAGER LEVEL TRANSACTIONS ----- --

delimiter |
CREATE PROCEDURE setSharePrice(IN stock_sym VARCHAR(5), IN share_price FLOAT(2))
	BEGIN
		UPDATE Stock
		SET SharePrice = share_price
		WHERE StockSymbol = stock_sym;
    END
| delimiter ;

delimiter |
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
CREATE PROCEDURE updateEmployee(IN field CHAR(10), IN val CHAR(50), IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET field = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE updateEmployee2(IN val DATETIME, IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET StartDate = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE updateEmployee3(IN val FLOAT(2), IN emp_id INT)
	BEGIN
		UPDATE Employee
		SET HourlyRate = val
		WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE deleteEmployee(IN emp_id INT)
	BEGIN
		DELETE FROM Employee
        WHERE EmpId = emp_id;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getSalesReport(IN yr INT, IN mon INT) -- check mon and yr type
	BEGIN
		SELECT T.Transfee, T.OrderId
		FROM Transact T
		WHERE YEAR(T.Timestamp_) = yr
		AND MONTH(T.Timestamp_) = mon;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE listAllStocks()
	BEGIN
		SELECT S.*, COUNT (O.StockSymbol) AS OrdersPlaced
		FROM Stock S, Order_ O
		WHERE S.StockSymbol = O.StockSymbol
		GROUP BY S.StockSymbol;
	END
| delimiter ;

delimiter |
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
CREATE PROCEDURE showStockRevenue()
	BEGIN
		SELECT S.StockSymbol, S.TotalRevenue
		FROM StockRevenue S;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE showStockTypeRevenue()
	BEGIN
		SELECT S.StockType, S.TotalRevenue
		FROM StockTypeRevenue S;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE showCustomerRevenue()
	BEGIN
		SELECT C.CusAccNum, S.TotalRevenue
		FROM CustomerRevenue C;
    END
| delimiter ;

delimiter |
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
CREATE PROCEDURE showMostTradedStocks()
	BEGIN
		SELECT M.StockSymbol, M.NumOrders
		FROM MostTraded M
		ORDER BY NumOrders ASC
		LIMIT 25;
    END
| delimiter ;

-- ----- CUSTOMER REPRESENTATIVE LEVEL TRANSACTIONS ----- --
delimiter |
CREATE PROCEDURE recordOrder(IN order_id INT)
	BEGIN
		UPDATE Order_ O
		SET Recorded = 1
		WHERE O.OrderId = order_id;
    END
| delimiter ;

delimiter |
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

-- Update customer in db
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
		SELECT LastName, FirstName, Email, Address, City, State, ZipCode
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
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp
		FROM CONDITIONALPRICEHISTORY P, ORDER_ O
		WHERE P.OrderId = orderid  AND P.PriceType = 'Trailing Stop' AND P.StopPrice > 0;
    END
| delimiter ;

-- The share-price and hidden-stop history for a given conditional order
delimiter |
CREATE PROCEDURE getConditonalOrderHiddenStop(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp
		FROM CONDITIONALPRICEHISTORY P, ORDER_ O
		WHERE P.OrderId = orderid  AND P.PriceType = 'Hidden Stop' AND P.StopPrice > 0;
    END
| delimiter ;

-- The share-price history of a given stock over a certain period of time (e.g., past six months
delimiter |
CREATE PROCEDURE getSharePriceHistory(IN month_past INT)
	BEGIN
		SELECT P.SharePrice, P.TimeStamp
		FROM STOCKPRICEHISTORY P
		WHERE P.StockSymbol = stock_symbol 
		AND MONTH(TIMEDIFF(NOW(), P.TimeStamp)) < month_past;
    END
| delimiter ;

-- A history of all current and past orders a customer has placed.
delimiter |
CREATE PROCEDURE getCustomerOrdersHistory(IN customer_id INT)
	BEGIN
		SELECT O.Timestamp, O.CusAccNum, O.OrderType, O.StockSymbol, O.NumShares, O.CurSharePrice, 	O.PriceType
		FROM Order_ O, Customer C, Account A
		WHERE O.CusAccNum = A.AccNum
		AND A.CusId = C.CusId AND C.CusId = customer_id;
    END
| delimiter ;

-- Stocks available of a particular type 
delimiter |
CREATE PROCEDURE getStockUsingType(IN stocktype CHAR(5)) 
	BEGIN
		SELECT O.*
		FROM STOCK S, Order_ O
		WHERE S.StockType LIKE '%stocktype%' AND O.StockSymbol = S.StockSymbol;

    END
| delimiter ;

-- Most-recent order info of a customer
delimiter |
CREATE PROCEDURE getMostRecentOrderInfo()
	BEGIN
		SELECT O.*
	FROM ORDER_ O, CUSTOMER C, ACCOUNT_ A
	WHERE O.CusAccNum = A.AccNum AND A.CusId = C.CusId AND C.CusId = 4
	AND MONTH(TIMEDIFF(NOW(), O.Timestamp)) <= 3;

    END
| delimiter ;

-- Stocks available with a particular keyword or set of keywords in the stock name, and most-recent order info.
delimiter |
CREATE PROCEDURE getStockUsingKeyword(IN stocksymbol CHAR(5)) 
	BEGIN
		SELECT O.*
		FROM STOCK S, Order_ O
		WHERE S.StockSymbol LIKE '%stocksymbol%' AND O.StockSymbol = S.StockSymbol;
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