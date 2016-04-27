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

import general.CustomerAccount;
import general.EmployeeAccount;
import general.Order;
import general.Stock;
import general.UserAccount;
import utils.MyUtils;

@WebServlet(urlPatterns = { "/orders" })
public class OrdersServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	public OrdersServlet()
	{
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
  
        // Not logged in
        if (loginedUser == null) {
       
            // Redirect to login page.
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Order> list = new ArrayList<Order>();
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "SELECT O.OrderId, O.Timestamp_, O.CusAccNum, "
        				+ "O.StockSymbol, O.NumShares, O.PriceType, "
        				+ "O.StopPrice, O.OrderType, O.Recorded, O.Completed "
        				+ "FROM Order_ O";
            PreparedStatement pstm1 = conn.prepareStatement(sql1);
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            while (rs.next()) {
            	Order order = new Order();
            	order.setId(rs.getInt("OrderId"));
            	order.setOrderType(rs.getString("OrderType"));
            	order.setTimestamp(rs.getDate("Timestamp_"));
            	order.setCusAccNum(rs.getInt("CusAccNum"));
            	order.setStockSymbol(rs.getString("StockSymbol"));
            	order.setNumShares(rs.getInt("NumShares"));
            	order.setPriceType(rs.getString("PriceType"));
            	order.setStopPrice(rs.getFloat("StopPrice"));
            	order.setRecorded(rs.getBoolean("Recorded"));
            	order.setCompleted(rs.getBoolean("Completed"));
                list.add(order);
            }
            System.out.println("Found items: " + list.size());
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("orders", list);
 
        if(loginedUser instanceof CustomerAccount)
        {
	        // Logged in, forward to /WEB-INF/views/userInfoView.jsp
	        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/cust_orders.jsp");
	        dispatcher.forward(request, response);
        }
        else
        {
        	if(((EmployeeAccount)loginedUser).isManager())
        	{
        		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/man_help.jsp");
		        dispatcher.forward(request, response);
        	}
        	else
        	{
	        	RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/rep_orders.jsp");
		        dispatcher.forward(request, response);
        	}
        }
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		doGet(request, response);
	}
}
