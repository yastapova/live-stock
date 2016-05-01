package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.CYear;
import general.EYear;
import general.Stock;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/revenueStocks", "/revenueStockTypes", "/revenueCustomers" })
public class RevenueSummaryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public RevenueSummaryServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        int selection = Integer.parseInt(request.getParameter("selection"));
        
        List<String[]> stocklist = null;
        List<CYear> custlist = null;
        List<String[]> typelist = null;
        String table = "";
        
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	switch(selection)
        	{
        		case 1:
        			table = "Summary of Revenues by Stock";
        			stocklist = new ArrayList<String[]>();
        			String st = request.getParameter("stockEdit");
        			
        			String sql1 = "CREATE VIEW StockRevenue (StockSymbol, StockName, TotalRevenue) AS "
        						+ "SELECT O.StockSymbol, S.StockName, SUM(T.TransFee) AS TotalRevenue "
        						+ "FROM Order_ O, Transact T, Stock S "
        						+ "WHERE O.Recorded = 1 AND O.OrderId = T.OrderId "
        						+ "AND O.StockSymbol = S.StockSymbol "
        						+ "GROUP BY O.StockSymbol;";
		            PreparedStatement pstm1 = conn.prepareStatement(sql1);                       
		            pstm1.executeUpdate();
		            
		            String sql2 = "SELECT * FROM StockRevenue S "
		            			+ "WHERE S.StockSymbol = ?; ";
		            PreparedStatement pstm2 = conn.prepareStatement(sql2);
		            pstm2.setString(1, st);
		            ResultSet rs2;
		            rs2 = pstm2.executeQuery();
		            
		            while(rs2.next())
		            {
	                	String[] stock = new String[3];
	                	stock[2] = ((Float) rs2.getFloat("TotalRevenue")).toString();
	                	stock[1] = rs2.getString("StockName");
	                	stock[0] = rs2.getString("StockSymbol");
	                	stocklist.add(stock);
		            }
		            
		            String sqld = "DROP VIEW StockRevenue; ";        				
		            PreparedStatement pstmd = conn.prepareStatement(sqld);           
		            pstmd.executeUpdate();
	    			break;
        			
        		case 2:
        			table = "Summary of Revenues by Stock Type";
        			typelist = new ArrayList<String[]>();
        			String ty = request.getParameter("typeEdit");
        			
        			String sql12 = "CREATE VIEW StockTypeRevenue (StockType, TotalRevenue) "
        					+ "AS SELECT S.StockType, SUM(T.TransFee) AS TotalRevenue "
        					+ "FROM Stock S, Transact T, Order_ O "
        					+ "WHERE O.StockSymbol = S.StockSymbol AND O.Recorded = 1 "
        					+ "AND O.OrderID = T.OrderId "
        					+ "GROUP BY S.StockType;";
		            PreparedStatement pstm12 = conn.prepareStatement(sql12);                       
		            pstm12.executeUpdate();
		            
		            String sql22 = "SELECT * FROM StockTypeRevenue S "
		            			 + "WHERE S.StockType = ?; ";        				
		            PreparedStatement pstm22 = conn.prepareStatement(sql22);
		            pstm22.setString(1, ty);
		            ResultSet rs22;
		            rs22 = pstm22.executeQuery();
		            
		            while(rs22.next())
		            {
	                	String[] type = new String[2];
	                	type[1] = ((Float) rs22.getFloat("TotalRevenue")).toString();
	                	type[0] = rs22.getString("StockType");
	                	typelist.add(type);
		            }
		            
		            String sqld2 = "DROP VIEW StockTypeRevenue; ";        				
		            PreparedStatement pstmd2 = conn.prepareStatement(sqld2);           
		            pstmd2.executeUpdate();
        			break;
        			
        		case 3:
        			table = "Summary of Revenues by Customer";
        			custlist = new ArrayList<CYear>();
        			int cusid = Integer.parseInt(request.getParameter("cusIdEdit"));
        			
        			String sql11 = "CREATE VIEW CustomerRevenue(CusAccNum, CusId, FirstName, LastName, TotalRevenue) "
        						+ "AS SELECT O.CusAccNum, C.CusId, C.FirstName, C.LastName, SUM(T.TransFee) AS TotalRevenue "
        						+ "FROM Order_ O, Transact T, Customer C, Account_ A "
        						+ "WHERE O.Recorded = 1 AND O.OrderID = T.OrderId "
        						+ "AND O.CusAccNum = A.AccNum AND A.CusId = C.CusId "
        						+ "GROUP BY O.CusAccNum;";          
    	            PreparedStatement pstm11 = conn.prepareStatement(sql11);                       
    	            pstm11.executeUpdate();
    	            
    	            String sql21 = "SELECT * FROM CustomerRevenue C "
    	            			 + "WHERE C.CusId = ?; ";        				
    	            PreparedStatement pstm21 = conn.prepareStatement(sql21);
    	            pstm21.setInt(1, cusid);
    	            ResultSet rs21;
    	            rs21 = pstm21.executeQuery();
    	            
    	            while(rs21.next())
    	            {
                    	int id2 = rs21.getInt("CusId");
                    	System.out.println(id2);
                    	CYear cus = new CYear();
                    	cus.setAccNum(rs21.getInt("CusAccNum"));
                    	cus.setId(id2);
                    	cus.setRevenue(rs21.getDouble("TotalRevenue"));
                    	cus.setFname(rs21.getString("FirstName"));
                    	cus.setLname(rs21.getString("LastName"));
                    	custlist.add(cus);
    	            }
    	            
    	            String sqld1 = "DROP VIEW CustomerRevenue; ";        				
    	            PreparedStatement pstmd1 = conn.prepareStatement(sqld1);           
    	            pstmd1.executeUpdate();
        			break;
        			
        		default:
        			break;
        	}
        } catch (Exception e) {
			e.printStackTrace();
		}
		
        request.setAttribute("table", table);
        request.setAttribute("types", typelist);
        request.setAttribute("stocks", stocklist);       
        request.setAttribute("customers", custlist);       
        request.setAttribute("id", loginedUser.getId());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/man_revenue_summary.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
