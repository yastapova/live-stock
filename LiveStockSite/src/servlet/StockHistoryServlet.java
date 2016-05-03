package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
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
 
@WebServlet(urlPatterns = { "/history_stocks" })
public class StockHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public StockHistoryServlet() {
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
        int id = loginedUser.getId();
        System.out.println("Userid: "+id);
        String stockSymbol = request.getParameter("stocksymbol");
        System.out.println("Symbol: "+stockSymbol);
        String startDate = request.getParameter("startdate");
        System.out.println("StartDate: "+startDate);
        String endDate = request.getParameter("enddate");
        System.out.println("EndDate: "+endDate);
        String table = "Results for "+stockSymbol+" in the range "+startDate+" to "+endDate;
        System.out.println(table);

        try{
        	
        	String sql1;
        	PreparedStatement pstm1 = null;
        	java.sql.ResultSet rs = null;
            if ((stockSymbol!=null) & (startDate!=null) & (endDate!=null)) {
            	sql1 = "CALL getSharePriceHistory(?,?,?)";
            	pstm1 = conn.prepareStatement(sql1);
            	pstm1.setString(1,stockSymbol);
            	pstm1.setString(2,startDate);
            	pstm1.setString(3,endDate);
                rs = pstm1.executeQuery();
            }

            if (rs!=null) {
                while (rs.next()) {
                    String sksym = stockSymbol;
                    float shpr = rs.getFloat("SharePrice");
                    Timestamp ts = rs.getTimestamp("TimeStamp_");
                    Stock data = new Stock(sksym, shpr, ts);
                    list.add(data);
                    System.out.println("Obtained Data: "+sksym+" "+shpr+" "+ts);
                }
            }

            System.out.println("After while");
        } catch (Exception e) {
			e.printStackTrace();
		}
			
        request.setAttribute("stocks", list);
        request.setAttribute("table", table);
        request.setAttribute("userType", loginedUser.getUserType());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_stock_history.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
