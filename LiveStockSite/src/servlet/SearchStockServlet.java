package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.Stock;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/search_stocks" })
public class SearchStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public SearchStockServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<Stock> list = new ArrayList<Stock>();
        Connection conn = MyUtils.getStoredConnection(request);
        int id = loginedUser.getId();
        String table = "Search Results";
        System.out.println(table);
        System.out.println("Userid: "+id);
        String stockType = request.getParameter("stocktype");
        System.out.println("Type: "+stockType);
        String stockKeyword = request.getParameter("stockkeyword");
        System.out.println("Keyword: "+stockKeyword);
        try{
        	
        	String sql1;
        	PreparedStatement pstm1 = null;
        	java.sql.ResultSet rs = null;
            if(stockType!=null) {
            	sql1 = "CALL getStockUsingType(?)";
            	pstm1 = conn.prepareStatement(sql1);
            	pstm1.setString(1,stockType);
                rs = pstm1.executeQuery();
            }
            else if (stockKeyword!=null) {
            	sql1 = "CALL getStockUsingKeyword(?)";
            	pstm1 = conn.prepareStatement(sql1);
            	pstm1.setString(1,stockKeyword);
                rs = pstm1.executeQuery();
            }

            if (rs!=null) {
                while (rs.next()) {
                    String sksym = rs.getString("StockSymbol");
                    String sknm = rs.getString("StockName");
                    String sktp = rs.getString("StockType");
                    float shpr = rs.getFloat("SharePrice");
                    int numsh = rs.getInt("NumAvailShares");
                    Stock data = new Stock(sksym, sknm, sktp, shpr, numsh);
                    list.add(data);
                    System.out.println("Obtained Data: "+sksym+" "+sknm+" "+sktp+" "+shpr+" "+numsh);
                }
            }

            System.out.println("After while");
        } catch (Exception e) {
			e.printStackTrace();
		}
			
        request.setAttribute("stocks", list);
        request.setAttribute("table", table);
        request.setAttribute("userType", loginedUser.getUserType());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/cust_stocks.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
