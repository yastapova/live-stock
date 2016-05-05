package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/addAcc" })
public class AddAccountServlet extends HttpServlet {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AddAccountServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        long cardNum = Long.parseLong(request.getParameter("cardNum"));        
      
        System.out.println(cardNum);
   
        HttpSession session = request.getSession();
        Connection conn = MyUtils.getStoredConnection(request);
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        
        try{
        	String sql1 = "INSERT INTO Account_(AccCreDate, CreditCNum, CusId) "
        			+ "VALUES(?, ?, ?);";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	Date date = new Date();
        	pstm1.setTimestamp(1, new Timestamp(date.getTime()));
        	pstm1.setLong(2,cardNum);
        	pstm1.setInt(3, loginedUser.getId());
        	pstm1.executeUpdate();
        } catch (Exception e) {
			e.printStackTrace();
		}
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/portfolio");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}