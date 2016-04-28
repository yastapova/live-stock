package servlet;

import java.io.IOException;
import java.sql.Connection;
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
import general.UserAccount;
import utils.DBUtils;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/doLogin" })
public class DoLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String MANAGER = "Manager";
    private static final String CUSREP = "CusRep";
 
    public DoLoginServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("Username is: " + userName);
        System.out.println("Password is: " + password);
         
        UserAccount user = null;
        boolean hasError = false;
        String errorString = null;
 
        if (userName == null || password == null
                 || userName.length() == 0 || password.length() == 0) {
            hasError = true;
            errorString = "Required username and password!";
        } else {
            Connection conn = MyUtils.getStoredConnection(request);
            try {
            	System.out.println("Trying connection in DoLogin!");
                user = DBUtils.findUser(conn, userName, password);
                 
                if (user == null) {
                    hasError = true;
                    errorString = "User Name or password invalid";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                hasError = true;
                errorString = e.getMessage();
            }
        }
        
        // If error, forward to /WEB-INF/views/login.jsp
        if (hasError) {
        	System.out.println("Error occured during login!");
            user = new UserAccount();
            user.setUsername(userName);
            user.setPassword(password);
             
        
            // Store information in request attribute, before forward.
            request.setAttribute("errorString", errorString);
            request.setAttribute("user", user);
 
       
            // Forward to /WEB-INF/views/login.jsp
            RequestDispatcher dispatcher //
            = this.getServletContext().getRequestDispatcher("/login");
 
            dispatcher.forward(request, response);
        }
     
        // If no error
        // Store user information in Session
        // And redirect to userInfo page.
        else {
        	HttpSession session = request.getSession();
            MyUtils.storeLoginedUser(session, user);
            System.out.println("Class: " + user.getClass());
        	if(user instanceof CustomerAccount){
        		// Redirect to userInfo page.
        		System.out.println("I am a customer!");
                response.sendRedirect(request.getContextPath() + "/customerAccInfo");
        	}
        	else
        	{
        		if(MANAGER.equals(((EmployeeAccount) user).getPos()))
        		{
	        		// Redirect to userInfo page.
        			System.out.println("I am a manager!");
	                response.sendRedirect(request.getContextPath() + "/manAccInfo");
        		}
        		else
        		{
        			System.out.println("I am a customer rep!");
        			response.sendRedirect(request.getContextPath() + "/repAccInfo");
        		}
        	}
        	System.out.println("Something weird in redirect");
             /*
             // If user checked "Remember me".
            if(remember)  {
                MyUtils.storeUserCookie(response,user);
            }
    
            // Else delete cookie.
            else  {
                MyUtils.deleteUserCookie(response);
            }                       
            */
            // Redirect to userInfo page.
            //response.sendRedirect(request.getContextPath() + "/customerRepAccInfo");
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}