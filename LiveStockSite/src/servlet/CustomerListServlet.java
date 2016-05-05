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
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/empCust" })
public class CustomerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public CustomerListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<CustomerAccount> custlist = new ArrayList<CustomerAccount>();
        
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "SELECT * FROM Customer; ";        				
            PreparedStatement pstm1 = conn.prepareStatement(sql1);           
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            while(rs.next()){
            	int id = rs.getInt("CusId");
            	String email = rs.getString("Email");
            	int rating = rs.getInt("Rating");            	
            	String fname = rs.getString("FirstName");
            	String lname = rs.getString("LastName");
            	String address = rs.getString("Address");
            	String city = rs.getString("City");
            	String state = rs.getString("State");
            	String zip = rs.getString("ZipCode");
            	String phone = rs.getString("Telephone");
          
            	CustomerAccount acc = new CustomerAccount(email,rating);
            	acc.setFname(fname);
            	acc.setLname(lname);
            	acc.setAddress(address);
            	acc.setCity(city);
            	acc.setState(state);
            	acc.setZip(zip);
            	acc.setPhone(phone);     
            	acc.setId(id);
            	custlist.add(acc);
            	System.out.println("Retrieved Customer: " + fname + " " + lname);
            }                
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("customers", custlist);       
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/emp_custlist.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
