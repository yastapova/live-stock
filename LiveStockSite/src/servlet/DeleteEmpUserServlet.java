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
import javax.servlet.http.HttpSession;

import general.CustomerAccount;
import general.EmployeeAccount;
import general.Stock;
import general.UserAccount;
import utils.DBUtils;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/deleteUserEmpMan" })
public class DeleteEmpUserServlet extends HttpServlet {
 
    public DeleteEmpUserServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        int id = Integer.parseInt(request.getParameter("empIdDelete"));
       
        
        System.out.println("Emp Id is: " + id);
   
 
        Connection conn = MyUtils.getStoredConnection(request);
        
        try{
        	String sql1 = "CALL deleteEmployee(?);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setInt(1,id);
        	java.sql.ResultSet rs = pstm1.executeQuery();
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