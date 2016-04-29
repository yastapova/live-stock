package general;

public class CYear {
	private int id;	
	private double revenue;	
	
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
}
