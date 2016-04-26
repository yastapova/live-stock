package servlet;

import java.io.IOException;

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
 
@WebServlet(urlPatterns = { "/customerAccInfo", "/repAccInfo" })
public class AccInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public AccInfoServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
 
 
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
  
        // Not logged in
        if (loginedUser == null) {
       
            // Redirect to login page.
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
  
        // Store info in request attribute
        request.setAttribute("user", loginedUser);
 
        if(loginedUser instanceof CustomerAccount)
        {
	        // Logged in, forward to /WEB-INF/views/userInfoView.jsp
	        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_acc_info.jsp");
	        dispatcher.forward(request, response);
        }
        else
        {
        	if(((EmployeeAccount)loginedUser).isManager())
        	{
        		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/man_acc_info.jsp");
    	        dispatcher.forward(request, response);
        	}
        	else
        	{
        		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/rep_acc_info.jsp");
    	        dispatcher.forward(request, response);
        	}
        }
 
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
