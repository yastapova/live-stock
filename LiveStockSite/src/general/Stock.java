package general;

public class Stock
{

	private String stocksym;
	private String stockname;
	private String stocktype;
	private float shareprice;
	private int numshares;
	
	public Stock(String stocksym, String stockname, String stocktype, float shareprice, int numshares) {
		this.stocksym = stocksym;
		this.stockname = stockname;
		this.stocktype = stocktype;
		this.shareprice = shareprice;
		this.numshares = numshares;
	}
	
	public String getStocksym() {
		return stocksym;
	}
	public void setStocksym(String stocksym) {
		this.stocksym = stocksym;
	}
	public String getStockname() {
		return stockname;
	}
	public void setStockname(String stockname) {
		this.stockname = stockname;
	}
	public String getStocktype() {
		return stocktype;
	}
	public void setStocktype(String stocktype) {
		this.stocktype = stocktype;
	}
	public float getShareprice() {
		return shareprice;
	}
	public void setShareprice(float shareprice) {
		this.shareprice = shareprice;
	}
	public int getNumshares() {
		return numshares;
	}
	public void setNumshares(int numshares) {
		this.numshares = numshares;
	}
	
}
