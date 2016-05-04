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

import general.Stock;
import general.UserAccount;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/repSuggestStocks" })
public class DoRepSuggestStock extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public DoRepSuggestStock() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check User has logged on
        UserAccount loginedUser = MyUtils.getLoginedUser(session);
        System.out.println("Logged in user is " + loginedUser);
        
        List<Stock> list = new ArrayList<Stock>();
        Connection conn = MyUtils.getStoredConnection(request);
        int id = Integer.parseInt(request.getParameter("cusIdEdit"));
        
        try{
        	String sql1 = "CALL Suggest(?)";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	pstm1.setInt(1,id);
        	java.sql.ResultSet rs  = pstm1.executeQuery();
            
            while (rs.next()) {
                String sksym = rs.getString("StockSymbol");
                String sknm = rs.getString("StockName");
                String sktp = rs.getString("StockType");
                float shpr = rs.getFloat("SharePrice");
                int numsh = rs.getInt("NumAvailShares");
                Stock data = new Stock(sksym, sknm, sktp, shpr, numsh);
                list.add(data);
                System.out.println("Obtained Data: "+sksym+" "+sknm+" "+sktp+" "+shpr+" "+numsh);
            }
        } catch (Exception e) {
			e.printStackTrace();
		}
			
        request.setAttribute("stocks", list);
        request.setAttribute("userType", loginedUser.getUserType());
        request.setAttribute("suggestCus", id);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/views/mailing_list.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}