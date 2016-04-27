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
import utils.MyUtils;
 
@WebServlet(urlPatterns = { "/stocks" })
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
        	String sql1 = "SELECT * FROM Stock";
            PreparedStatement pstm1 = conn.prepareStatement(sql1);
            java.sql.ResultSet rs;
            rs = pstm1.executeQuery();
            
            /*System.out.println("Doing stock query");
            String sql2 = "INSERT INTO STOCK VALUES(?,?,?,?,?)";
            PreparedStatement pstm2 = conn.prepareStatement(sql2);
            pstm2.setString(1, "Q");
            pstm2.setString(2, "Quail");
            pstm2.setString(3, "Bird");
            pstm2.setFloat(4, (float) 50.0);
            pstm2.setInt(5, 1000);
            pstm2.executeUpdate();*/
            
            //rs = stmt.executeQuery("SELECT * FROM Stock");
            
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
		/*} finally {
			try {
				//conn.close();
			} catch (Exception ee) {};*/
		}
			
        request.setAttribute("stocks", list);
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEB-INF/views/cust_stocks.jsp");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
