package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
        String positionStr = request.getParameter("position");
        String hourly = request.getParameter("hourly");
        String start = request.getParameter("start");
        //boolean position = "manager".equals(positionStr);
        
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
        //System.out.println("Position is: " + position + " KEY: false = cust_rep / true = manager");
         
        EmployeeAccount employee = null;
        boolean hasError = false;
        String errorString = null;

        if (userName == null || password == null || firstName == null || lastName == null || address == null || city == null
        		|| ssn == null || state == null || zipcode == null || phone == null || userName.length() == 0 || password.length() == 0 || firstName.length() == 0 || lastName.length() == 0 || address.length() == 0 
                 || city.length() == 0 || state.length() == 0 || zipcode.length() == 0 || phone.length() == 0 || ssn.length() == 0 ) {
            hasError = true;
            errorString = "Required information missing!";
        } else {
        	Date startDate = Date.valueOf(start);
        	int hourlyRate = Integer.parseInt(hourly);
        	employee = new EmployeeAccount();
        	employee.setUsername(userName);
        	employee.setFname(firstName);
        	employee.setLname(lastName);
        	employee.setAddress(address);
        	employee.setCity(city);
        	employee.setState(state);
        	employee.setZip(zipcode);
        	employee.setPhone(phone);
        	employee.setPos(positionStr);
        	employee.setStart(startDate);
        	employee.setHourly(hourlyRate);
        	
        	Connection conn = MyUtils.getStoredConnection(request);
            try
            {
            	System.out.println("Trying connection in DoRegisterEmployee!");
                
            	String sql1 = "INSERT INTO Employee (SSN, LastName, FirstName, Address, "
            				+ " City, State, ZipCode, Telephone, StartDate, HourlyRate, "
            				+ " Position_) "
            				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            	PreparedStatement pstm1 = conn.prepareStatement(sql1);
            	pstm1.setString(1, ssn);
            	pstm1.setString(2, lastName);
            	pstm1.setString(3, firstName);
            	pstm1.setString(4, address);
            	pstm1.setString(5, city);
            	pstm1.setString(6, state);
            	pstm1.setString(7, zipcode);
            	pstm1.setString(8, phone);
            	pstm1.setDate(9, startDate);
            	pstm1.setInt(10, hourlyRate);
            	pstm1.setString(11, positionStr);
            	pstm1.executeUpdate();
            	
            	System.out.println("Inserted into Employee table");
            	
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
            	pstm2.setString(7, zipcode);
            	pstm2.setString(8, phone);
            	pstm2.setDate(9, startDate);
            	pstm2.setInt(10, hourlyRate);
            	pstm2.setString(11, positionStr);
            	ResultSet rs = pstm2.executeQuery();
            	
            	int id = -1;
            	if(rs.next())
            	{
            		id = rs.getInt("EmpId");
            		employee.setId(id);
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
        	System.out.println("Trying to get session for employee!");
            HttpSession session = request.getSession();
            MyUtils.storeLoginedUser(session, employee);
        	
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
            */
            // Redirect to userInfo page.
            response.sendRedirect(request.getContextPath() + "/repAccInfo");
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}