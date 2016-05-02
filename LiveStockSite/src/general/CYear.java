package general;

public class CYear {
	
	private int id;
	private double revenue;
	private String fname;
	private String lname;
	private int acc;
	
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
	
	public void setAcc(int acc) {
		this.acc = acc;
	}
	public int getAcc() {
		return acc;
	}
}
