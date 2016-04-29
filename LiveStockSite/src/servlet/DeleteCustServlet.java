package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/deleteCustEmp" })
public class DeleteCustServlet extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

	public DeleteCustServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        int id = Integer.parseInt(request.getParameter("custIdDelete"));
       
        
        System.out.println("Cust Id is: " + id);
   
 
        Connection conn = MyUtils.getStoredConnection(request);
        
        try{
        	String sql1 = "CALL deleteCustomer(?);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setInt(1,id);
        	java.sql.ResultSet rs = pstm1.executeQuery();
        } catch (Exception e) {
			e.printStackTrace();
		}
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/empCust");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}