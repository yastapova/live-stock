package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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

import general.Account;
import general.Portfolio;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/portfolio" })
public class PortfolioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public PortfolioServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<Portfolio> plist = new ArrayList<Portfolio>();
        List<Account> alist = new ArrayList<Account>();
        Connection conn = MyUtils.getStoredConnection(request);
        try{
        	String sql1 = "SELECT A.AccNum, A.AccCreDate, A.CreditCNum "
        				+ "FROM Account_ A "
        				+ "WHERE A.CusId = ?;";
            PreparedStatement pstm1 = conn.prepareStatement(sql1);
            pstm1.setInt(1, loginedUser.getId());
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            while(rs.next()){
            	Date accCreateDate = rs.getDate("AccCreDate");
            	int id = rs.getInt("AccNum");
            	long creditCardNum = rs.getLong("CreditCNum");
            	Account acc = new Account(id, accCreateDate, creditCardNum);
            	alist.add(acc);
            	System.out.println("Retrieved account: " + accCreateDate + " " + creditCardNum);
            }
            for(int i = 0; i < alist.size(); i++){
            	String sql2 = "SELECT P.StockSymbol, P.NumShares, P.Stop_, P.StopPrice "
        				+ "FROM Portfolio P "
        				+ "WHERE P.AccNum = ?;";
    	        PreparedStatement pstm2 = conn.prepareStatement(sql2);
    	        int id = alist.get(i).getAccId();
    	        pstm2.setInt(1, id);
    	        java.sql.ResultSet rs2;
    	        rs2 = pstm2.executeQuery();
    	        
    	        while(rs2.next()){
    	        	String stockSymbol = rs2.getString("StockSymbol");
    	        	int numShares = rs2.getInt("NumShares");
    	        	float stopPrice = rs2.getFloat("StopPrice");
    	        	String stop = rs2.getString("Stop_");
    	        	Portfolio p = new Portfolio(id, stockSymbol, numShares, stop, stopPrice);
    	        	plist.add(p);
    	        	System.out.println("Retrieved portfolio: " + id + " " + stockSymbol + " " + numShares + " " + stop + " " + stopPrice);
    	        }
            }         
        } catch (Exception e) {
			e.printStackTrace();
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("accounts", alist);
        request.setAttribute("portfolios", plist);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_portfolio.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
