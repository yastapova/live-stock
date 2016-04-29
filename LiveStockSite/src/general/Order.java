package general;

import java.sql.Date;

public class Order
{
	private int id;
	private String stockSymbol;
	private String orderType;
	private int numShares;
	private int cusAccNum;
	private Date timestamp;
	private String priceType;
	private float stopPrice;
	private float stopDiff;
	private float curSharePrice;
	private int empId;
	private boolean recorded;
	private boolean completed;
	
	public Order()
	{
		
	}

	
	public Order(int id, String stockSymbol, String orderType, 
			int numShares, int cusAccNum, Date timestamp,
			String priceType, float stopPrice, float stopDiff, 
			float curSharePrice, int empId, boolean recorded,
			boolean completed)
	{
		this.id = id;
		this.stockSymbol = stockSymbol;
		this.orderType = orderType;
		this.numShares = numShares;
		this.cusAccNum = cusAccNum;
		this.timestamp = timestamp;
		this.priceType = priceType;
		this.stopPrice = stopPrice;
		this.stopDiff = stopDiff;
		this.curSharePrice = curSharePrice;
		this.empId = empId;
		this.recorded = recorded;
		this.completed = completed;
	}



	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the stockSymbol
	 */
	public String getStockSymbol() {
		return stockSymbol;
	}

	/**
	 * @param stockSymbol the stockSymbol to set
	 */
	public void setStockSymbol(String stockSymbol) {
		this.stockSymbol = stockSymbol;
	}

	/**
	 * @return the orderType
	 */
	public String getOrderType() {
		return orderType;
	}

	/**
	 * @param orderType the orderType to set
	 */
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	/**
	 * @return the numShares
	 */
	public int getNumShares() {
		return numShares;
	}

	/**
	 * @param numShares the numShares to set
	 */
	public void setNumShares(int numShares) {
		this.numShares = numShares;
	}

	/**
	 * @return the cusAccNum
	 */
	public int getCusAccNum() {
		return cusAccNum;
	}

	/**
	 * @param cusAccNum the cusAccNum to set
	 */
	public void setCusAccNum(int cusAccNum) {
		this.cusAccNum = cusAccNum;
	}

	/**
	 * @return the timestamp
	 */
	public Date getTimestamp() {
		return timestamp;
	}

	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	/**
	 * @return the priceType
	 */
	public String getPriceType() {
		return priceType;
	}

	/**
	 * @param priceType the priceType to set
	 */
	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}

	/**
	 * @return the stopPrice
	 */
	public float getStopPrice() {
		return stopPrice;
	}

	/**
	 * @param stopPrice the stopPrice to set
	 */
	public void setStopPrice(float stopPrice) {
		this.stopPrice = stopPrice;
	}

	/**
	 * @return the stopDiff
	 */
	public float getStopDiff() {
		return stopDiff;
	}

	/**
	 * @param stopDiff the stopDiff to set
	 */
	public void setStopDiff(float stopDiff) {
		this.stopDiff = stopDiff;
	}

	/**
	 * @return the curSharePrice
	 */
	public float getCurSharePrice() {
		return curSharePrice;
	}

	/**
	 * @param curSharePrice the curSharePrice to set
	 */
	public void setCurSharePrice(float curSharePrice) {
		this.curSharePrice = curSharePrice;
	}

	/**
	 * @return the empId
	 */
	public int getEmpId() {
		return empId;
	}

	/**
	 * @param empId the empId to set
	 */
	public void setEmpId(int empId) {
		this.empId = empId;
	}

	/**
	 * @return the recorded
	 */
	public boolean isRecorded() {
		return recorded;
	}

	/**
	 * @param recorded the recorded to set
	 */
	public void setRecorded(boolean recorded) {
		this.recorded = recorded;
	}

	/**
	 * @return the completed
	 */
	public boolean isCompleted() {
		return completed;
	}

	/**
	 * @param completed the completed to set
	 */
	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
}
