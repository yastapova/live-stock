package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

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
        Date start = Date.valueOf(request.getParameter("startdate"));              
   
 
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
        	pstm1.setDate(9,start);
        	pstm1.setFloat(10,Float.parseFloat(hourly));
        	pstm1.setString(11,"CusRep");
        	java.sql.ResultSet rs = pstm1.executeQuery();
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