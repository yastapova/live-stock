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

import general.Stock;
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/stock" })
public class StockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public StockServlet() {
        super();
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        List<Stock> list = new ArrayList<Stock>();
        Connection conn = MyUtils.getStoredConnection(request);
        try{
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs;
            rs = stmt.executeQuery("SELECT * FROM Stock");
            
            while (rs.next()) {
                String sksym = rs.getString("StockSymbol");
                String sknm = rs.getString("StockName");
                String sktp = rs.getString("StockType");
                float shpr = rs.getFloat("SharePrice");
                int numsh = rs.getInt("NumAvailShares");
                Stock data = new Stock(sksym, sknm, sktp, shpr, numsh);
                list.add(data);
            }
        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception ee) {};
		}

        session.setAttribute("list", list);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_stocks.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
