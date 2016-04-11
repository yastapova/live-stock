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

