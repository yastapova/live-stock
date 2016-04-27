package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.CustomerAccount;
import utils.MyUtils;

@WebServlet(urlPatterns = { "/mailing_list" })
public class MailingListServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    
	public MailingListServlet()
	{
		super();
	}
	
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        List<CustomerAccount> list = new ArrayList<CustomerAccount>();
        Connection conn = MyUtils.getStoredConnection(request);
        try {
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs;
            rs = stmt.executeQuery("SELECT C.FirstName, C.LastName, "
            					 + "C.Address, C.City, C.State, C.ZipCode, "
            					 + "C.Email FROM Customer C");
            
            while (rs.next())
            {
            	CustomerAccount customer = new CustomerAccount();
            	customer.setFname(rs.getString("FirstName"));
            	customer.setLname(rs.getString("LastName"));
            	customer.setAddress(rs.getString("Address"));
            	customer.setCity(rs.getString("City"));
            	customer.setZip(rs.getString("ZipCode"));
            	customer.setEmail(rs.getString("Email"));
                list.add(customer);
            }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			/*
			try {
				conn.close();
			} catch (Exception ee) {};
			*/
		}
        System.out.println("Found items: " + list.size());
        session.setAttribute("list", list);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/mailing_list.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
