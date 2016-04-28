package general;

public class Portfolio {
	
	private String stockSymbol;
	private int numShares;	
	private float stopPrice;
	private String stop;
	private int accNum;
	
	public Portfolio(int accNum, String stockSymbol, int numShares, String stop, float stopPrice) {
		this.accNum = accNum;
		this.stockSymbol = stockSymbol;
		this.numShares = numShares;
		this.stop = stop;
		this.stopPrice = stopPrice;		
	}
	
	public String getStockSymbol() {
		return stockSymbol;
	}
	public void setStockSymbol(String stockSymbol) {
		this.stockSymbol = stockSymbol;
	}
	
	public int getNumShares() {
		return numShares;
	}
	public void setNumShares(int numShares) {
		this.numShares = numShares;
	}
	public String getStop() {
		return stop;
	}
	public void setStop(String stop) {
		this.stop = stop;
	}
	public float getStopPrice() {
		return stopPrice;
	}
	public void setStockSymbol(float stopPrice) {
		this.stopPrice = stopPrice;
	}
	public float getAccNum() {
		return accNum;
	}
	public void setAccNum(int accNum) {
		this.accNum = accNum;
	}

}
