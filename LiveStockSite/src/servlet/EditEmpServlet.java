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
 
@WebServlet(urlPatterns = { "/editEmpMan" })
public class EditEmpServlet extends HttpServlet {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public EditEmpServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String select = request.getParameter("empEditField");        
        int id = Integer.parseInt(request.getParameter("empIdEdit"));
        String edit = request.getParameter("new");
        Connection conn = MyUtils.getStoredConnection(request);
        
        try{
        	System.out.println(select);
	        switch(select){
		        case "firstname": 
		        	String sql1 = "UPDATE Employee " 
		        			+ "SET FirstName = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
		        	pstm1.setString(1, edit);
		        	pstm1.setInt(2, id);
		        	pstm1.executeUpdate();
		        	break;
		        case "lastname":
		        	String sql2 = "UPDATE Employee " 
		        			+ "SET LastName = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm2 = conn.prepareStatement(sql2);
		        	pstm2.setString(1, edit);
		        	pstm2.setInt(2, id);
		        	pstm2.executeUpdate();
		        	break;
		        case "address":
		        	String sql3 = "UPDATE Employee " 
		        			+ "SET Address = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm3 = conn.prepareStatement(sql3);
		        	pstm3.setString(1, edit);
		        	pstm3.setInt(2, id);
		        	pstm3.executeUpdate();
		        	break;
		        case "city":
		        	String sql4 = "UPDATE Employee " 
		        			+ "SET City = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm4 = conn.prepareStatement(sql4);
		        	pstm4.setString(1, edit);
		        	pstm4.setInt(2, id);
		        	pstm4.executeUpdate();
		        	break;
		        case "state":
		        	String sql5 = "UPDATE Employee " 
		        			+ "SET State = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm5 = conn.prepareStatement(sql5);
		        	pstm5.setString(1, edit);
		        	pstm5.setInt(2, id);
		        	pstm5.executeUpdate();
		        	break;
		        case "zipcode":
		        	String sql6 = "UPDATE Employee " 
		        			+ "SET ZipCode = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm6 = conn.prepareStatement(sql6);
		        	pstm6.setString(1, edit);
		        	pstm6.setInt(2, id);
		        	pstm6.executeUpdate();
		        	break;
		        case "telephone":
		        	String sql7 = "UPDATE Employee " 
		        			+ "SET Telephone = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm7 = conn.prepareStatement(sql7);
		        	pstm7.setString(1, edit);
		        	pstm7.setInt(2, id);
		        	pstm7.executeUpdate();
		        	break;
		        case "startdate":
		        	String sql8 = "CALL UpdateEmployee2(?,?);";
		        	PreparedStatement pstm8 = conn.prepareStatement(sql8);
		        	pstm8.setDate(1, Date.valueOf(edit));
		        	pstm8.setInt(2, id);
		        	pstm8.executeUpdate();
		        	break;
		        case "hourly":
		        	String sql9 = "CALL UpdateEmployee3(?,?);";
		        	PreparedStatement pstm9 = conn.prepareStatement(sql9);
		        	pstm9.setFloat(1, Float.parseFloat(edit));
		        	pstm9.setInt(2, id);
		        	pstm9.executeUpdate();
		        	break;
		        case "ssn":
		        	String sql = "UPDATE Employee " 
		        			+ "SET SSN = ? "
		        			+ "WHERE EmpId = ?; ";
		        	PreparedStatement pstm = conn.prepareStatement(sql);
		        	pstm.setString(1, edit);
		        	pstm.setInt(2, id);
		        	pstm.executeUpdate();
		        	break;
	        };
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