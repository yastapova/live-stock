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

@WebServlet(urlPatterns = { "/orders" })
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrdersServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		// Check User has logged on
		UserAccount loginedUser = MyUtils.getLoginedUser(session);
		System.out.println("Logged in user is " + loginedUser);

		// Not logged in
		if (loginedUser == null) {

			// Redirect to login page.
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		List<Order> list = new ArrayList<Order>();
		List<CustomerAccount> custlist = new ArrayList<CustomerAccount>();
		List<Stock> stocklist = new ArrayList<Stock>();
		Connection conn = MyUtils.getStoredConnection(request);
		boolean history = false;

		if (loginedUser instanceof CustomerAccount) {
			int id = loginedUser.getId();
			String id_param = request.getParameter("order_id");
			if (id_param == null || "".equals(id_param)) {
				System.out.println("No values.");
				
				try {
					String sql1 = "SELECT O.OrderId, O.Timestamp_, O.CusAccNum, "
							+ "O.StockSymbol, O.NumShares, O.PriceType, "
							+ "O.StopPrice, O.OrderType, O.Recorded, O.Completed " + "FROM Order_ O, Account_ A "
							+ "WHERE O.CusAccNum = A.AccNum " + "AND A.CusId = ?";
					PreparedStatement pstm1 = conn.prepareStatement(sql1);
					pstm1.setInt(1, id);
					java.sql.ResultSet rs;
					rs = pstm1.executeQuery();

					while (rs.next()) {
						Order order = new Order();
						order.setId(rs.getInt("OrderId"));
						order.setOrderType(rs.getString("OrderType"));
						order.setTimestamp(rs.getTimestamp("Timestamp_"));
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					String sql1 = "CALL getConditonalOrderHistory(?)";
					PreparedStatement pstm1 = conn.prepareStatement(sql1);
					pstm1.setInt(1, Integer.parseInt(id_param));
					java.sql.ResultSet rs;
					rs = pstm1.executeQuery();
					
					while (rs.next()) {
						Order order = new Order();
						order.setId(Integer.parseInt(id_param));
						order.setCurSharePrice(rs.getFloat("CurSharePrice"));
						order.setTimestamp(rs.getTimestamp("Timestamp_"));
						order.setStopPrice(rs.getFloat("StopPrice"));
						list.add(order);
					}
					history = true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			request.setAttribute("orders", list);
			request.setAttribute("isHistory", history);

			RequestDispatcher dispatcher = this.getServletContext()
					.getRequestDispatcher("/WEB-INF/views/cust_orders.jsp");
			dispatcher.forward(request, response);
		} else {
			if (((EmployeeAccount) loginedUser).isManager()) {
				System.out.println("Manager!");
				RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/manOrders");
				dispatcher.forward(request, response);
			} else {
				String[] id_param = request.getParameterValues("order_ids");

				if (id_param == null || "".equals(id_param)) {
					System.out.println("No values.");
				} else {
					System.out.println("Recording");
					try {
						String sql = "CALL recordOrder(?)";
						PreparedStatement pst1 = conn.prepareStatement(sql);
						System.out.println("Passed # values: " + id_param.length);
						for (String s : id_param) {
							pst1.setInt(1, Integer.parseInt(s));
							pst1.executeUpdate();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				System.out.println("Loading");
				try {
					String sql1 = "SELECT O.OrderId, O.Timestamp_, O.CusAccNum, "
							+ "O.StockSymbol, O.NumShares, O.PriceType, "
							+ "O.StopPrice, O.OrderType, O.Recorded, O.Completed " + "FROM Order_ O";
					PreparedStatement pstm1 = conn.prepareStatement(sql1);
					java.sql.ResultSet rs;
					rs = pstm1.executeQuery();

					while (rs.next()) {
						Order order = new Order();
						order.setId(rs.getInt("OrderId"));
						order.setOrderType(rs.getString("OrderType"));
						order.setTimestamp(rs.getTimestamp("Timestamp_"));
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
				} catch (Exception e) {
					e.printStackTrace();
				}
				request.setAttribute("orders", list);
				RequestDispatcher dispatcher = this.getServletContext()
						.getRequestDispatcher("/WEB-INF/views/rep_orders.jsp");
				dispatcher.forward(request, response);
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
