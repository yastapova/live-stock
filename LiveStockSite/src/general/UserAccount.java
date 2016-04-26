package general;

public class UserAccount
{
	private String fname;
	private String lname;
	private String username;
	private String password;
	private String address;
	private String city;
	private String state;
	private String zip;
	private String phone;
	private int id;
	
	public UserAccount()
	{
		
	}
	
	public UserAccount(int id, String fname, String lname, String usrname,
						String password, String address, String city,
						String state, String zip, String phone)
	{
		this.id = id;
		this.fname = fname;
		this.lname = lname;
		this.username = usrname;
		this.password = password;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.phone = phone;
	}
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String usrname) {
		this.username = usrname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Override
	public String toString()
	{
		return username + ": " + fname + " " + lname;
	}
}
