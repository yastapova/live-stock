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
 
@WebServlet(urlPatterns = { "/most_actively_traded" })
public class MostActiveStocksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public MostActiveStocksServlet() {
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
        String table = "Most Actively Traded Stocks";
        String num = request.getParameter("numstocks");
        
        System.out.println(table);
        
        try{
        	String sql1 = "CALL showMostTradedStocks(?)";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	if(num != null && !("".equals(num)))
        	{
        		pstm1.setInt(1, Integer.parseInt(num));
        	}
        	else
        	{
        		pstm1.setInt(1, 10);
        	}
        	java.sql.ResultSet rs  = pstm1.executeQuery();
            
            while (rs.next()) {
                String sksym = rs.getString("StockSymbol");
                String sknm = rs.getString("StockName");
                int numOrd = rs.getInt("NumOrders");
                Stock data = new Stock(sksym, sknm, numOrd);
                list.add(data);
                System.out.println("Obtained Data: "+sksym+" "+sknm+" "+numOrd);
            }
        } catch (Exception e) {
			e.printStackTrace();
		}
			
        request.setAttribute("stocks", list);
        request.setAttribute("table", table);
        request.setAttribute("userType", loginedUser.getUserType());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/most_active_stocks.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
