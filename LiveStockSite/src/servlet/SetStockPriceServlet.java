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
 
@WebServlet(urlPatterns = { "/price_stocks" })
public class SetStockPriceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public SetStockPriceServlet() {
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
        String table = "Prices Have Been Set";
        System.out.println(table);
        
        String[] stockPrice = request.getParameterValues("stockprice");
		
		if(stockPrice == null || "".equals(stockPrice))
		{
			System.out.println("No values.");
		}
		else
		{
			System.out.println("Setting Prices");
			try {
    			String sql1 = "CALL setSharePrice(?,?)";
    			String sql2 = "CALL updateTrailingStop(?,?,?)";
    			String sql3 = "CALL updateHiddenStop(?,?,?)";
    			PreparedStatement pst1 = conn.prepareStatement(sql1);
    			PreparedStatement pst2 = conn.prepareStatement(sql2);
    			PreparedStatement pst3 = conn.prepareStatement(sql3);
    			
    			System.out.println("Passed # values: " + stockPrice.length);
    			for(int i=0; i<stockPrice.length; i=i+3)
    			{
    				String newPrice = stockPrice[i];
    				if(newPrice.equals("")){
    					continue;
    				}
    				String oldPrice = stockPrice[i+1];
    				String symbol = stockPrice[i+2];
    				pst1.setString(1, symbol);
    				pst1.setFloat(2, Float.parseFloat(newPrice));
    				pst1.executeUpdate();
    				System.out.println(pst1);
    				pst2.setFloat(1, Float.parseFloat(newPrice));
    				pst2.setFloat(2, Float.parseFloat(oldPrice));
    				pst2.setString(3, symbol);
    				java.sql.ResultSet rs = pst2.executeQuery();
    				System.out.println(pst2);
    			
    				while(rs.next()) {
    					String sql4 = "CALL MarkComplete(?,?,?)";
    		        	PreparedStatement pst4 = conn.prepareStatement(sql4);
    		        	int order_id = rs.getInt("OrderId");
    		        	float cur_price = rs.getFloat("new_stock_price");
    		        	float stop_price = rs.getFloat("StopPrice");
    		        	pst4.setInt(1, order_id);
    		        	pst4.setFloat(2, cur_price);
    		        	pst4.setFloat(3, stop_price);
    		        	pst4.executeUpdate();
    		        	System.out.println(pst4);
    				}
    				
    				pst3.setFloat(1, Float.parseFloat(newPrice));
    				pst3.setFloat(2, Float.parseFloat(oldPrice));
    				pst3.setString(3, symbol);
    				rs = pst3.executeQuery();
    				System.out.println(pst3);
    				
    				while(rs.next()) {
    					String sql4 = "CALL MarkComplete(?,?,?)";
    		        	PreparedStatement pst4 = conn.prepareStatement(sql4);
    		        	int order_id = rs.getInt("OrderId");
    		        	float cur_price = rs.getFloat("new_stock_price");
    		        	float stop_price = rs.getFloat("StopPrice");
    		        	pst4.setInt(1, order_id);
    		        	pst4.setFloat(2, cur_price);
    		        	pst4.setFloat(3, stop_price);
    		        	pst4.executeUpdate();
    		        	System.out.println(pst4);
    				}

    			}
			} catch (Exception e) {
    			e.printStackTrace();
            }
		}
        
        try{
        	String sql1 = "SELECT * FROM Stock";
        	PreparedStatement pstm1 = conn.prepareStatement(sql1);
        	java.sql.ResultSet rs = pstm1.executeQuery();
            
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
        request.setAttribute("table", table);
        request.setAttribute("userType", loginedUser.getUserType());
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/stocks");
        dispatcher.forward(request, response);
        
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
 
}
