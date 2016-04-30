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

import general.CustomerAccount;
import general.EmployeeAccount;
import general.Order;
import general.Stock;
import general.UserAccount;
import utils.MyUtils;

@WebServlet(urlPatterns = { "/manOrdersStock" })
public class ManOrderStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ManOrderStockServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String stockSym = request.getParameter("stockSym");

		// Check User has logged on
		UserAccount loginedUser = MyUtils.getLoginedUser(session);
		System.out.println("Logged in user is " + loginedUser);

		// Not logged in
		if (loginedUser == null) {

			// Redirect to login page.
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		List<CustomerAccount> custlist = new ArrayList<CustomerAccount>();
		List<Stock> stocklist = new ArrayList<Stock>();
		List<Order> list = new ArrayList<Order>();
		List<String> stringlist = new ArrayList<String>();
		Connection conn = MyUtils.getStoredConnection(request);

		try {
			String sql1 = "SELECT * FROM Order_;";
			PreparedStatement pstm1 = conn.prepareStatement(sql1);
			java.sql.ResultSet rs;
			rs = pstm1.executeQuery();

			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("OrderId"));
				order.setOrderType(rs.getString("OrderType"));
				order.setTimestamp(rs.getDate("Timestamp_"));
				order.setCusAccNum(rs.getInt("CusAccNum"));
				order.setStockSymbol(rs.getString("StockSymbol"));
				order.setNumShares(rs.getInt("NumShares"));
				order.setPriceType(rs.getString("PriceType"));
				order.setStopPrice(rs.getFloat("StopPrice"));
				order.setRecorded(rs.getBoolean("Recorded"));
				order.setCompleted(rs.getBoolean("Completed"));
				list.add(order);
			}
			System.out.println("Found items: " + list.size());

			// Customers and Stocks
			String sql2 = "SELECT * FROM Customer; ";
			PreparedStatement pstm2 = conn.prepareStatement(sql2);
			java.sql.ResultSet rs2;
			rs2 = pstm2.executeQuery();

			while (rs2.next()) {
				int id = rs2.getInt("CusId");
				String email = rs2.getString("Email");
				int rating = rs2.getInt("Rating");
				String fname = rs2.getString("FirstName");
				String lname = rs2.getString("LastName");
				String address = rs2.getString("Address");
				String city = rs2.getString("City");
				String state = rs2.getString("State");
				String zip = rs2.getString("ZipCode");
				String phone = rs2.getString("Telephone");

				CustomerAccount acc = new CustomerAccount(email, rating);
				acc.setFname(fname);
				acc.setLname(lname);
				acc.setAddress(address);
				acc.setCity(city);
				acc.setState(state);
				acc.setZip(zip);
				acc.setPhone(phone);
				acc.setId(id);
				custlist.add(acc);
				System.out.println("Retrieved Customer: " + fname + " " + lname);
			}
			String sql3 = "SELECT S.StockSymbol FROM Stock S WHERE S.StockSymbol = ?;";
			PreparedStatement pstm3 = conn.prepareStatement(sql3);
			pstm3.setString(1, stockSym);
			java.sql.ResultSet rs3;
			rs3 = pstm3.executeQuery();

			while (rs3.next()) {
				stockSym = rs3.getString("StockSymbol");
				stringlist.add(stockSym);
				System.out.println("Obtained Symbol: " + stockSym);
			}

			request.setAttribute("orders", list);
			request.setAttribute("customers", custlist);
			request.setAttribute("stocks", stocklist);
			request.setAttribute("stockSyms", stringlist);
			
			RequestDispatcher dispatcher = this.getServletContext()
					.getRequestDispatcher("/WEB-INF/views/man_orders_stock.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
