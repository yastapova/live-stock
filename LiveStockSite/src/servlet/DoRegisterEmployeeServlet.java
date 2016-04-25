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
 
import general.EmployeeAccount;
import utils.DBUtils;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/doRegisterEmployee" })
public class DoRegisterEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public DoRegisterEmployeeServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");        
        String lastName = request.getParameter("last_name");
        String ssn = request.getParameter("ssn");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String phone = request.getParameter("phone");
        //String email = request.getParameter("position");
        
        System.out.println("Username is: " + userName);
        System.out.println("Password is: " + password);
        System.out.println("FirstName is: " + firstName);
        System.out.println("LastName is: " + lastName);
        System.out.println("SSN is: " + ssn);
        System.out.println("Address is: " + address);
        System.out.println("City is: " + city);
        System.out.println("State is: " + state);
        System.out.println("Zipcode is: " + zipcode);
        System.out.println("Phone is: " + phone);
        //System.out.println("Position is: " + position);
         
        EmployeeAccount employee = null;
        boolean hasError = false;
        String errorString = null;
        // update this
        if (userName == null || password == null || firstName == null || lastName == null || address == null || city == null
        		|| ssn == null || state == null || zipcode == null || phone == null || userName.length() == 0 || password.length() == 0 || firstName.length() == 0 || lastName.length() == 0 || address.length() == 0 
                 || city.length() == 0 || state.length() == 0 || zipcode.length() == 0 || phone.length() == 0 || ssn.length() == 0 ) {
            hasError = true;
            errorString = "Required information missing!";
        } else {
        	/*
            Connection conn = MyUtils.getStoredConnection(request);
            try {
            	System.out.println("Trying connection in DoLogin!");
                customer = DBUtils.findUser(conn, userName, password);
                 
                if (customer == null) {
                    hasError = true;
                    errorString = "User Name or password invalid";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                hasError = true;
                errorString = e.getMessage();
            }
            */
        }
        
        // If error, forward to /WEB-INF/views/login.jsp
        if (hasError) {
        	System.out.println("Error occured during registration!");
            employee = new EmployeeAccount();
            employee.setUsername(userName);
            employee.setPassword(password);
            
             
        
            // Store information in request attribute, before forward.
            request.setAttribute("errorString", errorString);
            request.setAttribute("employee", employee);
 
       
            // Forward to /WEB-INF/views/login.jsp
            RequestDispatcher dispatcher //
            = this.getServletContext().getRequestDispatcher("/WEB-INF/index.jsp");
 
            dispatcher.forward(request, response);
        }
     
        // If no error
        // Store user information in Session
        // And redirect to userInfo page.
        else {
        	/*
            HttpSession session = request.getSession();
            //MyUtils.storeLoginedUser(session, user);
             /*
             // If user checked "Remember me".
            if(remember)  {
                MyUtils.storeUserCookie(response,user);
            }
    
            // Else delete cookie.
            else  {
                MyUtils.deleteUserCookie(response);
            }                       
            
            // Redirect to userInfo page.
            response.sendRedirect(request.getContextPath() + "/userInfo");*/
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}