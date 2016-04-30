package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
			
        request.setAttribute("transactions", tlist);    
        request.setAttribute("id", loginedUser.getId());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/man_finances.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
