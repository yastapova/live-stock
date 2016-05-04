package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
import general.Transaction;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/finances" })
public class TransactionListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public TransactionListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<Transaction> tlist = new ArrayList<Transaction>();
        List<String> ssyms = new ArrayList<String>();
        List<String> stypes = new ArrayList<String>();
        List<CustomerAccount> customers = new ArrayList<CustomerAccount>();
        
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "SELECT * FROM Transact; ";        				
            PreparedStatement pstm1 = conn.prepareStatement(sql1);           
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            while(rs.next()){
            	int id = rs.getInt("Id");
            	Date time = rs.getDate("TimeStamp_");
            	int orderId = rs.getInt("OrderId");
            	float fee =  rs.getFloat("TransFee");
            	float pps = rs.getFloat("PricePerShare");
            	Transaction trans = new Transaction(id, orderId, time, fee, pps);
            	tlist.add(trans);
            	System.out.println("Retrieved Trans: " + id + " " + orderId + " " + time + " " + fee);
            }                
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
        try {
        	String sql = "SELECT DISTINCT S.StockSymbol FROM Stock S;";
        	PreparedStatement pstm = conn.prepareStatement(sql);
        	ResultSet rs = pstm.executeQuery();
        	
        	while(rs.next())
        	{
        		ssyms.add(rs.getString("StockSymbol"));
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        try {
        	String sql = "SELECT DISTINCT S.StockType FROM Stock S;";
        	PreparedStatement pstm = conn.prepareStatement(sql);
        	ResultSet rs = pstm.executeQuery();
        	
        	while(rs.next())
        	{
        		stypes.add(rs.getString("StockType"));
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        try {
        	String sql = "SELECT DISTINCT C.CusId, C.FirstName, C.LastName FROM Customer C;";
        	PreparedStatement pstm = conn.prepareStatement(sql);
        	ResultSet rs = pstm.executeQuery();
        	
        	while(rs.next())
        	{
        		CustomerAccount cus = new CustomerAccount();
        		cus.setId(rs.getInt("CusId"));
        		cus.setFname(rs.getString("FirstName"));
        		cus.setLname(rs.getString("LastName"));
        		customers.add(cus);
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        request.setAttribute("customers", customers);
        request.setAttribute("types", stypes);
        request.setAttribute("stocksyms", ssyms);
        request.setAttribute("transactions", tlist);    
        request.setAttribute("id", loginedUser.getId());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/man_finances.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
