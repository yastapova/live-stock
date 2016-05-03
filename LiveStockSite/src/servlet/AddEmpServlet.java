package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/addEmpMan" })
public class AddEmpServlet extends HttpServlet {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AddEmpServlet() {
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
        String hourly = request.getParameter("hourly");
        Timestamp start = Timestamp.valueOf(request.getParameter("startdate"));     
        String username = request.getParameter("username");
        String password  = request.getParameter("password");
   
 
        Connection conn = MyUtils.getStoredConnection(request);
        
        try{
        	String sql1 = "CALL addEmployee(?,?,?,?,?,?,?,?,?,?,?);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setString(1,ssn);
        	pstm1.setString(2,lastName);
        	pstm1.setString(3,firstName);
        	pstm1.setString(4,address);
        	pstm1.setString(5,city);
        	pstm1.setString(6,state);
        	pstm1.setString(7,zip);
        	pstm1.setString(8,phone);
        	pstm1.setTimestamp(9,start);
        	pstm1.setFloat(10,Float.parseFloat(hourly));
        	pstm1.setString(11,"CusRep");
        	java.sql.ResultSet rs = pstm1.executeQuery();
        	
        	String sql2 = "SELECT E.EmpId FROM Employee E "
        			+ "WHERE E.SSN = ? AND E.LastName = ? AND E.FirstName = ? AND "
					+ "E.Address = ? AND E.City = ? AND E.State = ? AND "
					+ "E.ZipCode = ? AND E.Telephone = ? AND E.StartDate = ? AND "
					+ "E.HourlyRate = ? AND E.Position_ = ?;";
        	PreparedStatement pstm2 = conn.prepareStatement(sql2);
        	pstm2.setString(1, ssn);
        	pstm2.setString(2, lastName);
        	pstm2.setString(3, firstName);
        	pstm2.setString(4, address);
        	pstm2.setString(5, city);
        	pstm2.setString(6, state);
        	pstm2.setString(7, zip);
        	pstm2.setString(8, phone);
        	pstm2.setTimestamp(9, start);
        	pstm2.setInt(10, Integer.parseInt(hourly));
        	pstm2.setString(11, "CusRep");
        	ResultSet rs2 = pstm2.executeQuery();
        	
        	int id = -1;
        	if(rs2.next())
        	{
        		id = rs2.getInt("EmpId");        		
        	}
        	System.out.println("Updated id");
        	
        	String sql = "INSERT INTO Login(Usr, Pwd, AccType, Id)"
    				+ " VALUES (?, ?, ?, ?);";

    		PreparedStatement pstm = conn.prepareStatement(sql);
    		pstm.setString(1, username);
    		pstm.setString(2, password);
    		pstm.setInt(3, 2);    		
    		pstm.setInt(4, id);
    		pstm.executeUpdate();
        } catch (Exception e) {
			e.printStackTrace();
		}
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/manEmp");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}