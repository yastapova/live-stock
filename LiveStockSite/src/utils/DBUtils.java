package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import general.*;


public class DBUtils {

	private static final int CUSTOMER = 1;
	private static final int REP = 2;
	private static final int MANAGER = 3;

	public static UserAccount findUser(Connection conn, String userName, String password) throws SQLException {
		System.out.println("Loooking for user: " + userName);
		String sql = "SELECT L.Usr, L.Pwd, L.AccType, L.Id FROM Login L "
				+ " WHERE L.Usr = ? AND L.Pwd = ?";

		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, userName);
		pstm.setString(2, password);
		ResultSet rs = pstm.executeQuery();

		if (rs.next()) {
			String usr = rs.getString("Usr");
			String pwd = rs.getString("Pwd");
			int accType = rs.getInt("AccType");
			int id = rs.getInt("Id");

			if(accType == CUSTOMER)
			{
				String sql2 = "SELECT C.FirstName, C.LastName, "
							+ "C.Address, C.City, C.State, "
							+ "C.ZipCode, C.Telephone, C.Email, "
							+ "C.Rating, C.CusId FROM Customer C "
							+ "WHERE C.CusId = ?";
				PreparedStatement pstm2 = conn.prepareStatement(sql2);
				pstm2.setInt(1, id);
				ResultSet rs2 = pstm2.executeQuery();
				
				if(rs2.next())
				{
					String first = rs2.getString("FirstName");
					String last = rs2.getString("LastName");
					String addr = rs2.getString("Address");
					String city = rs2.getString("City");
					String state = rs2.getString("State");
					String zip = rs2.getString("ZipCode");
					String phone = rs2.getString("Telephone");
					String email = rs2.getString("Email");
					int rating = rs2.getInt("Rating");
					int cusId = rs2.getInt("CusId");
					
					UserAccount user = new CustomerAccount(cusId, first,
										last, usr, pwd, addr, city, state,
										zip, phone, email, rating);
					System.out.println("Retrieved Customer Account");
					return user;
				}
			}
			else if(accType == REP || accType == MANAGER)
			{
				String sql2 = "SELECT E.SSN, E.FirstName, E.LastName, "
						+ "E.Address, E.City, E.State, "
						+ "E.ZipCode, E.Telephone, E.HourlyRate, "
						+ "E.StartDate, E.EmpId, E.Position_ FROM Employee E "
						+ "WHERE E.EmpId = ?";
				PreparedStatement pstm2 = conn.prepareStatement(sql2);
				pstm2.setInt(1, id);
				ResultSet rs2 = pstm2.executeQuery();
				
				if(rs2.next())
				{
					UserAccount user = new EmployeeAccount();

					((EmployeeAccount)user).setSsn(rs2.getString("SSN"));
					user.setLname(rs2.getString("LastName"));
					user.setFname(rs2.getString("FirstName"));
					user.setAddress(rs2.getString("Address"));
					user.setCity(rs2.getString("City"));
					user.setState(rs2.getString("State"));
					user.setZip(rs2.getString("ZipCode"));
					user.setPhone(rs2.getString("Telephone"));
					((EmployeeAccount)user).setStart(rs2.getDate("StartDate"));
					((EmployeeAccount)user).setHourly(rs2.getInt("HourlyRate"));
					user.setId(rs2.getInt("EmpId"));
					((EmployeeAccount)user).setPos(rs2.getString("Position_"));
					
					System.out.println("Retrieved Employee Account");
					return user;
				}
			}
			else
			{
				return null;
			}
		}
		return null;
	}
	/** TO DO
	public static void insertCustomer(Connection conn, CustomerAccount customer) throws SQLException {
		String sql = "Insert into Customer(Code, Name,Price) values (?,?,?)";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, product.getCode());
		pstm.setString(2, product.getName());
		pstm.setFloat(3, product.getPrice());

		pstm.executeUpdate();
	}
	*/
	/*
	public static void deleteProduct(Connection conn, String code) throws SQLException {
		String sql = "Delete Product where Code= ?";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, code);

		pstm.executeUpdate();
	}
*/
/*
	public static List<Product> queryProduct(Connection conn) throws SQLException {
		String sql = "Select a.Code, a.Name, a.Price from Product a ";

		PreparedStatement pstm = conn.prepareStatement(sql);

		ResultSet rs = pstm.executeQuery();
		List<Product> list = new ArrayList<Product>();
		while (rs.next()) {
			String code = rs.getString("Code");
			String name = rs.getString("Name");
			float price = rs.getFloat("Price");
			Product product = new Product();
			product.setCode(code);
			product.setName(name);
			product.setPrice(price);
			list.add(product);
		}
		return list;
	}

	public static Product findProduct(Connection conn, String code) throws SQLException {
		String sql = "Select a.Code, a.Name, a.Price from Product a where a.Code=?";

		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, code);

		ResultSet rs = pstm.executeQuery();

		while (rs.next()) {
			String name = rs.getString("Name");
			float price = rs.getFloat("Price");
			Product product = new Product(code, name, price);
			return product;
		}
		return null;
	}

	public static void updateProduct(Connection conn, Product product) throws SQLException {
		String sql = "Update Product set Name =?, Price=? where Code=? ";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, product.getName());
		pstm.setFloat(2, product.getPrice());
		pstm.setString(3, product.getCode());
		pstm.executeUpdate();
	}

	public static void insertProduct(Connection conn, Product product) throws SQLException {
		String sql = "Insert into Product(Code, Name,Price) values (?,?,?)";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, product.getCode());
		pstm.setString(2, product.getName());
		pstm.setFloat(3, product.getPrice());

		pstm.executeUpdate();
	}

	public static void deleteProduct(Connection conn, String code) throws SQLException {
		String sql = "Delete Product where Code= ?";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, code);

		pstm.executeUpdate();
	}
*/
}