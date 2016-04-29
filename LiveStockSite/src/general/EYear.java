package general;

public class EYear {
	private int id;	
	private double revenue;	
	
	public EYear(int id, double revenue) {
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
