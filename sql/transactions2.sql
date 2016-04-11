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

delimiter |
CREATE PROCEDURE getConditonalOrderTrailingStop(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp
		FROM CONDITIONALPRICEHISTORY P, ORDER_ O
		WHERE P.OrderId = orderid  AND P.PriceType = 'Trailing Stop' AND P.StopPrice > 0;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getConditonalOrderHiddenStop(IN orderid INT)
	BEGIN
		SELECT P.CurSharePrice, P.StopPrice, P.TimeStamp
		FROM CONDITIONALPRICEHISTORY P, ORDER_ O
		WHERE P.OrderId = orderid  AND P.PriceType = 'Hidden Stop' AND P.StopPrice > 0;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getSharePriceHistory(IN month_past INT)
	BEGIN
		SELECT P.SharePrice, P.TimeStamp
		FROM STOCKPRICEHISTORY P
		WHERE P.StockSymbol = :stock_symbol 
		AND MONTH(TIMEDIFF(NOW(), P.TimeStamp)) < month_past;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getCustomerOrdersHistory(IN customer_id INT)
	BEGIN
		SELECT O.Timestamp, O.CusAccNum, O.OrderType, O.StockSymbol, O.NumShares, O.CurSharePrice, 	O.PriceType
		FROM Order_ O, Customer C, Account A
		WHERE O.CusAccNum = A.AccNum
		AND A.CusId = C.CusId AND C.CusId = customer_id;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getStockUsingType(IN stocktype CHAR(5)) 
	BEGIN
		SELECT O.*
		FROM STOCK S, Order_ O
		WHERE S.StockType LIKE '%stocktype%' AND O.StockSymbol = S.StockSymbol;

    END
| delimiter ;

delimiter |
CREATE PROCEDURE getMostRecentOrderInfo()
	BEGIN
		SELECT O.*
	FROM ORDER_ O, CUSTOMER C, ACCOUNT_ A
	WHERE O.CusAccNum = A.AccNum AND A.CusId = C.CusId AND C.CusId = 4
	AND MONTH(TIMEDIFF(NOW(), O.Timestamp)) <= 3;

    END
| delimiter ;

delimiter |
CREATE PROCEDURE getStockUsingKeyword(IN stocksymbol CHAR(5)) 
	BEGIN
		SELECT O.*
		FROM STOCK S, Order_ O
		WHERE S.StockSymbol LIKE '%stocksymbol%' AND O.StockSymbol = S.StockSymbol;
    END
| delimiter ;

delimiter |
CREATE PROCEDURE getBestSellers() 
	BEGIN
		SELECT B.StockSymbol, B.TotalShares
		FROM BestSellers B
		ORDER BY TotalShares desc 
		LIMIT 25;
    END
| delimiter ;
