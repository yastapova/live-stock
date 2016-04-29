package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/addUserCustMan" })
public class AddCustUserServlet extends HttpServlet {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AddCustUserServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String firstName = request.getParameter("firstname");        
        String lastName = request.getParameter("lastname");
        String ssn = request.getParameter("ssn");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zipcode");
        String phone = request.getParameter("telephone");
        String email = request.getParameter("email");
        int rating = Integer.parseInt(request.getParameter("rating"));    
        String username = request.getParameter("username");
        String password  = request.getParameter("password");
        
        System.out.println(rating);
   
 
        Connection conn = MyUtils.getStoredConnection(request);
        
        try{
        	String sql1 = "CALL addCustomer(?,?,?,?,?,?,?,?,?);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setString(1,lastName);
        	pstm1.setString(2,firstName);
        	pstm1.setString(3,address);
        	pstm1.setString(4,city);
        	pstm1.setString(5,state);
        	pstm1.setString(6,zip);
        	pstm1.setString(7,phone);
        	pstm1.setString(8,email);
        	pstm1.setInt(9,rating);
        	java.sql.ResultSet rs = pstm1.executeQuery();
        	
        	String sql2 = "SELECT C.CusId FROM Customer C "
        			+ "WHERE C.LastName = ? AND C.FirstName = ? AND "
					+ "C.Address = ? AND C.City = ? AND C.State = ? AND "
					+ "C.ZipCode = ? AND C.Telephone = ? AND C.Email = ? AND "
					+ "C.Rating = ?;";
        	PreparedStatement pstm2 = conn.prepareStatement(sql2);
        	pstm2.setString(1, lastName);
        	pstm2.setString(2, firstName);
        	pstm2.setString(3, address);
        	pstm2.setString(4, city);
        	pstm2.setString(5, state);
        	pstm2.setString(6, zip);
        	pstm2.setString(7, phone);
        	pstm2.setString(8, email);
        	pstm2.setInt(9, rating);
        	ResultSet rs2 = pstm2.executeQuery();
        	
        	int id = -1;
        	if(rs2.next())
        	{
        		id = rs2.getInt("CusId");        		
        	}
        	System.out.println("Updated id");
        	
        	String sql = "INSERT INTO Login(Usr, Pwd, AccType, Id)"
    				+ " VALUES (?, ?, ?, ?);";

    		PreparedStatement pstm = conn.prepareStatement(sql);
    		pstm.setString(1, username);
    		pstm.setString(2, password);
    		pstm.setInt(3, 1);
    		pstm.setInt(4, id);
    		pstm.executeUpdate();
        } catch (Exception e) {
			e.printStackTrace();
		}
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/users");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}