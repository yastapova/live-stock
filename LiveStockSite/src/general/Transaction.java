package general;

import java.sql.Date;

public class Transaction {
	private int id;
	private Date time;
	private	int orderId;
	private float fee;
	private float pps;
	private int month;
	private int year;
	
	public Transaction(int id, int orderId, Date time, float fee, float pps) {
		this.id = id;
		this.time = time;
		this.fee = fee;
		this.pps = pps;
		this.orderId = orderId;
		this.month = Integer.parseInt(time.toString().substring(5,7));
		this.year = Integer.parseInt(time.toString().substring(0,4));
	}
	
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getFee() {
		return fee;
	}
	public void setFee(float fee) {
		this.fee = fee;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public float getPps() {
		return pps;
	}
	public void setPps(float pps) {
		this.pps = pps;
	}
	public int getMonth() {
		return month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public void setMonth(int month) {
		this.month = month;
	}
}
