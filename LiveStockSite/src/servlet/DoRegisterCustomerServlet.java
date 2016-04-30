package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import general.CustomerAccount;
import utils.DBUtils;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/doRegisterCustomer" })
public class DoRegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public DoRegisterCustomerServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");        
        String lastName = request.getParameter("last_name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        
        System.out.println("Username is: " + userName);
        System.out.println("Password is: " + password);
        System.out.println("FirstName is: " + firstName);
        System.out.println("LastName is: " + lastName);
        System.out.println("Address is: " + address);
        System.out.println("City is: " + city);
        System.out.println("State is: " + state);
        System.out.println("Zipcode is: " + zipcode);
        System.out.println("Phone is: " + phone);
        System.out.println("Email is: " + email);
         
        CustomerAccount customer = null;
        boolean hasError = false;
        String errorString = null;
 
        if (userName == null || password == null || firstName == null || lastName == null || address == null || city == null
        		|| state == null || zipcode == null || phone == null || email == null
                 || userName.length() == 0 || password.length() == 0 || firstName.length() == 0 || lastName.length() == 0 || address.length() == 0 
                 || city.length() == 0 || state.length() == 0 || zipcode.length() == 0 || phone.length() == 0 || email.length() == 0 ) {
            hasError = true;
            errorString = "Required information missing!";
        } else {
        	customer = new CustomerAccount();
        	customer.setUsername(userName);
        	customer.setFname(firstName);
        	customer.setLname(lastName);
        	customer.setAddress(address);
        	customer.setCity(city);
        	customer.setState(state);
        	customer.setZip(zipcode);
        	customer.setPhone(phone);
        	customer.setEmail(email);
        	customer.setRating(0);
        	
            Connection conn = MyUtils.getStoredConnection(request);
            try {
            	System.out.println("Trying connection in DoRegisterCustomer!");
            	String sql1 = "CALL addCustomer(?, ?, ?, ?, ?, ?, ?, ?, ?)";
            	PreparedStatement pstm1 = conn.prepareStatement(sql1);
            	pstm1.setString(1, lastName);
            	pstm1.setString(2, firstName);
            	pstm1.setString(3, address);
            	pstm1.setString(4, city);
            	pstm1.setString(5, state);
            	pstm1.setString(6, zipcode);
            	pstm1.setString(7, phone);
            	pstm1.setString(8, email);
            	pstm1.setInt(9, 0);
            	pstm1.executeUpdate();
            	
            	System.out.println("Inserted into Customer table");
            	
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
            	pstm2.setString(6, zipcode);
            	pstm2.setString(7, phone);
            	pstm2.setString(8, email);
            	pstm2.setInt(9, 0);
            	ResultSet rs = pstm2.executeQuery();
            	
            	int id = -1;
            	if(rs.next())
            	{
            		id = rs.getInt("CusId");
            		customer.setId(id);
            	}
            	System.out.println("Updated id");
            	
            	String sql = "INSERT INTO Login(Usr, Pwd, AccType, Id)"
        				+ " VALUES (?, ?, ?, ?);";

        		PreparedStatement pstm = conn.prepareStatement(sql);
        		pstm.setString(1, userName);
        		pstm.setString(2, password);
        		pstm.setInt(3, 1);
        		pstm.setInt(4, id);
        		pstm.executeUpdate();
        		
        		System.out.println("Inserted into Login table");
        		
            } catch (SQLException e) {
                e.printStackTrace();
                hasError = true;
                errorString = e.getMessage();
            }
            catch(Exception e){
            	System.out.println(e.getMessage());
            }
            
        }
        
        // If error, forward to /WEB-INF/views/login.jsp
        if (hasError) {
        	System.out.println("Error occured during registration!");
            customer = new CustomerAccount();
            customer.setUsername(userName);
            customer.setPassword(password);
            
             
        
            // Store information in request attribute, before forward.
            request.setAttribute("errorString", errorString);
            request.setAttribute("customer", customer);
 
       
            // Forward to /WEB-INF/views/login.jsp
            RequestDispatcher dispatcher //
            = this.getServletContext().getRequestDispatcher("/WEB-INF/index.jsp");
 
            dispatcher.forward(request, response);
        }
     
        // If no error
        // Store user information in Session
        // And redirect to userInfo page.
        else {
        	System.out.println("Trying to get session for customer!");
            HttpSession session = request.getSession();
            MyUtils.storeLoginedUser(session, customer);
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
            response.sendRedirect(request.getContextPath() + "/customerAccInfo");
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}