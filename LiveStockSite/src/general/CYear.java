package general;

public class CYear {
	private int id;	
	private int accnum;
	private double revenue;
	private String fname;
	private String lname;
	
	public CYear(){
		
	}
	
	public CYear(int id, double revenue) {
		this.id = id;
		this.revenue = revenue;		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getRevenue() {
		return revenue;
	}
	public void setRevenue(double revenue) {
		this.revenue = revenue;
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
	
	public void setAccNum(int accNum) {
		this.accnum = accNum;
	}
	public int getAccNum() {
		return accnum;
	}
}
