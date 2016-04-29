package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.CYear;
import general.EYear;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/ecYear" })
public class ECYearServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public ECYearServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<EYear> emplist = new ArrayList<EYear>();
        List<CYear> custlist = new ArrayList<CYear>();
        
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "CREATE VIEW CustomerRevenue(CusAccNum, TotalRevenue) AS " 
				+ "SELECT O.CusAccNum, SUM(T.TransFee) AS TotalRevenue "
				+ "FROM Order_ O, Transact T "
				+ "WHERE O.Recorded = 1 AND O.OrderID = T.OrderId "
				+ "GROUP BY O.CusAccNum;";          
            PreparedStatement pstm1 = conn.prepareStatement(sql1);                       
            pstm1.executeUpdate();
            
            String sql11 = "CREATE VIEW EmployeeRevenue(EmpId, TotalRevenue) AS "
							+"SELECT O.EmpId, SUM(T.TransFee) AS TotalRevenue "
							+"FROM ORDER_ O, Transact T "
							+"WHERE O.OrderID=T.OrderId AND O.Recorded = 1 AND O.EmpID <> 0 "
							+"GROUP BY O.EmpId;";        				
                PreparedStatement pstm11 = conn.prepareStatement(sql11);           
                pstm11.executeUpdate();
            
        	String sql2 = "CALL showMaxCustomerRevenue; ";        				
            PreparedStatement pstm2 = conn.prepareStatement(sql2);           
            java.sql.ResultSet rs2;
            rs2 = pstm2.executeQuery();
                
                while(rs2.next()){
                	int id2 = rs2.getInt("CusAccNum");
                	System.out.println(id2);
                	double rev2 = rs2.getDouble("TotalRevenue");              
                	CYear acc2 = new CYear(id2,rev2);                	
                	custlist.add(acc2);
                	System.out.println("Retrieved Customer: " + id2 + " " + rev2);
            }                
                String sql111 = "CALL showMaxEmployeeRevenue; ";        				
                PreparedStatement pstm111 = conn.prepareStatement(sql111);           
                java.sql.ResultSet rs111;
                rs111 = pstm111.executeQuery();
                
                while(rs111.next()){
                	int id = rs111.getInt("EmpId");
                	double rev = rs111.getDouble("TotalRevenue");                	
                	EYear acc = new EYear(id, rev);                	
                	emplist.add(acc);
                	System.out.println("Retrieved Employee: " + id + " " + rev);
                }
            String sqld = "DROP View CustomerRevenue; ";        				
            PreparedStatement pstmd = conn.prepareStatement(sqld);           
            pstmd.executeUpdate();
            String sqle = "DROP View EmployeeRevenue; ";        				
            PreparedStatement pstme = conn.prepareStatement(sqle);           
            pstme.executeUpdate();
            
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("employees", emplist);       
        request.setAttribute("customers", custlist);       
        request.setAttribute("id", loginedUser.getId());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/man_finances_ecyear.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
