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

import general.CustomerAccount;
import general.EmployeeAccount;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/users" })
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public UserListServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<EmployeeAccount> emplist = new ArrayList<EmployeeAccount>();
        List<CustomerAccount> custlist = new ArrayList<CustomerAccount>();
        
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "SELECT * FROM Employee; ";        				
            PreparedStatement pstm1 = conn.prepareStatement(sql1);           
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            while(rs.next()){
            	String ssn = rs.getString("SSN");
            	String pos = rs.getString("Position_");
            	int hourly = (int)rs.getFloat("HourlyRate");
            	Date start = rs.getDate("StartDate");
            	String fname = rs.getString("FirstName");
            	String lname = rs.getString("LastName");
            	String address = rs.getString("Address");
            	String city = rs.getString("City");
            	String state = rs.getString("State");
            	String zip = rs.getString("ZipCode");
            	String phone = rs.getString("Telephone");
            	int id = rs.getInt("EmpId");
            	EmployeeAccount acc = new EmployeeAccount(ssn, pos, hourly, start);
            	acc.setFname(fname);
            	acc.setLname(lname);
            	acc.setAddress(address);
            	acc.setCity(city);
            	acc.setState(state);
            	acc.setZip(zip);
            	acc.setPhone(phone);
            	acc.setId(id);
            	emplist.add(acc);
            	System.out.println("Retrieved Employee: " + fname + " " + lname + " " + ssn + " " + pos);
            }
            	String sql2 = "SELECT * FROM Customer; ";        				
                PreparedStatement pstm2 = conn.prepareStatement(sql2);           
                java.sql.ResultSet rs2;
                rs2 = pstm2.executeQuery();
                
                while(rs2.next()){
                	int id2 = rs2.getInt("CusId");
                	String email2 = rs2.getString("Email");
                	int rating = rs2.getInt("Rating");            	
                	String fname2 = rs2.getString("FirstName");
                	String lname2 = rs2.getString("LastName");
                	String address2 = rs2.getString("Address");
                	String city2 = rs2.getString("City");
                	String state2 = rs2.getString("State");
                	String zip2 = rs2.getString("ZipCode");
                	String phone2 = rs2.getString("Telephone");
              
                	CustomerAccount acc2 = new CustomerAccount(email2,rating);
                	acc2.setFname(fname2);
                	acc2.setLname(lname2);
                	acc2.setAddress(address2);
                	acc2.setCity(city2);
                	acc2.setState(state2);
                	acc2.setZip(zip2);
                	acc2.setPhone(phone2);     
                	acc2.setId(id2);
                	custlist.add(acc2);
                	System.out.println("Retrieved Customer: " + fname2 + " " + lname2);
            }                
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("employees", emplist);       
        request.setAttribute("customers", custlist);       
        request.setAttribute("id", loginedUser.getId());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/man_userlist.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}