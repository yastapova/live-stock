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

@WebServlet(urlPatterns = {"/order_stock"})
public class OrderStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public OrderStockServlet()
	{
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
		HttpSession session = request.getSession();
        Connection conn = MyUtils.getStoredConnection(request);
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        String stocksym = request.getParameter("stockOrder");
        try {
        	String sql1 = "SELECT S.NumAvailShares FROM Stock S "
        				+ "WHERE S.StockSymbol = ?";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setString(1, stocksym);
        	ResultSet rs1 = pstm1.executeQuery();
        	int availshares = 0;
        	if(rs1.next())
        	{
        		availshares = rs1.getInt("NumAvailShares");
        	}
        	request.setAttribute("numavailshares", availshares);
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        if(loginedUser instanceof CustomerAccount)
        {

        	List<CustomerAccount> customers = new ArrayList<CustomerAccount>();
        	System.out.println("User id: " + loginedUser.getId());
        	
        	try {
	        	String sql2 = "SELECT A.AccNum "
	        				+ "FROM Account_ A "
	        				+ "WHERE A.CusId = ?;";
	        	PreparedStatement pstm2 = conn.prepareStatement(sql2);
	        	pstm2.setInt(1, loginedUser.getId());
	        	ResultSet rs2 = pstm2.executeQuery();
	        	
	        	while(rs2.next())
	        	{
	        		CustomerAccount cus = new CustomerAccount();
	        		cus.setId(loginedUser.getId());
	        		cus.setFname(loginedUser.getFname());
	        		cus.setLname(loginedUser.getLname());
	        		cus.setAccnum(rs2.getInt("AccNum"));
	        		customers.add(cus);
	        	}
	        	
        	} catch (Exception e) {
            	e.printStackTrace();
            }
        	request.setAttribute("cusid", loginedUser.getId());
        	request.setAttribute("customers", customers);
        }
        else if(loginedUser instanceof EmployeeAccount)
        {
        	List<CustomerAccount> customers = new ArrayList<CustomerAccount>();
        	
        	try {
            	String sql = "SELECT DISTINCT C.CusId, C.FirstName, C.LastName, A.AccNum "
            			   + "FROM Customer C, Account_ A "
            			   + "WHERE C.CusId = A.CusId;";
            	PreparedStatement pstm = conn.prepareStatement(sql);
            	ResultSet rs = pstm.executeQuery();
            	
            	while(rs.next())
            	{
            		CustomerAccount cus = new CustomerAccount();
            		cus.setId(rs.getInt("CusId"));
            		cus.setFname(rs.getString("FirstName"));
            		cus.setLname(rs.getString("LastName"));
            		cus.setAccnum(rs.getInt("AccNum"));
            		customers.add(cus);
            	}
            } catch (Exception e) {
            	e.printStackTrace();
            }
        	request.setAttribute("customers", customers);
        	request.setAttribute("empid", loginedUser.getId());
        }
        
        request.setAttribute("stocksym", stocksym);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/order_stock.jsp");
        dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
