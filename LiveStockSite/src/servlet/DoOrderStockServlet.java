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

import general.CustomerAccount;
import general.EmployeeAccount;
import general.UserAccount;
import utils.MyUtils;

@WebServlet(urlPatterns = {"/do_order_stock"})
public class DoOrderStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public DoOrderStockServlet()
	{
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
		HttpSession session = request.getSession();
        Connection conn = MyUtils.getStoredConnection(request);
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        String stocksym = request.getParameter("stocksym");
        String ordertype = request.getParameter("orderType");
        int numshares = Integer.parseInt(request.getParameter("numshares"));
        String priceType = null;
        if("Buy".equals(ordertype))
        {
        	priceType = "Market";
        }
        else
        {
        	priceType = request.getParameter("priceType");
        }
        String stopPrice = request.getParameter("stopPrice");
        int cusAcc = Integer.parseInt(request.getParameter("cusAccount"));
        int empId = 1;
        try {
        	empId = Integer.parseInt(request.getParameter("empId"));
        } catch(NumberFormatException e){}
        
        try {
        	String sql1 = "INSERT INTO Order_(StockSymbol, OrderType, NumShares, CusAccNum, PriceType, StopPrice, EmpId, Recorded) "
        			+ "VALUES (?, ?, ?, ?, ?, ?, ?, 0);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setString(1, stocksym);
        	pstm1.setString(2, ordertype);
        	pstm1.setInt(3, numshares);
        	pstm1.setInt(4, cusAcc);
        	pstm1.setString(5, priceType);
        	pstm1.setInt(7, empId);
        	if(!("Market".equals(priceType)))
        	{
        		pstm1.setFloat(6, Float.parseFloat(stopPrice));
        	}
        	else
        	{
        		pstm1.setNull(6, java.sql.Types.FLOAT);
        	}
        	pstm1.executeUpdate();
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/orders");
        dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
