package general;
import java.sql.Timestamp;

public class Stock
{

	private String stocksym;
	private String stockname;
	private String stocktype;
	private float shareprice;
	private int numshares;
	private int numOrders;
	private Timestamp datetime;

	public Stock(String stocksym, String stockname, String stocktype, float shareprice, int numshares) {
		this.stocksym = stocksym;
		this.stockname = stockname;
		this.stocktype = stocktype;
		this.shareprice = shareprice;
		this.numshares = numshares;
	}
	
	public Stock(String stocksym, String stockname, String stocktype, float shareprice, int numshares, int numOrders) {
		this.stocksym = stocksym;
		this.stockname = stockname;
		this.stocktype = stocktype;
		this.shareprice = shareprice;
		this.numshares = numshares;
		this.numOrders = numOrders;
	}
	
	public Stock(String stocksym, String stockname, int numOrders)
	{
		this.stocksym = stocksym;
		this.stockname = stockname;
		this.numOrders = numOrders;
	}
	
	public Stock(String stocksym, float shareprice, Timestamp datetime) {
		this.stocksym = stocksym;
		this.shareprice = shareprice;
		this.datetime = datetime;
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
	public int getNumOrders() {
		return numOrders;
	}
	public void setNumOrders(int numOrders) {
		this.numOrders = numOrders;
	}
	
	public Timestamp getDatetime() {
		return datetime;
	}

	public void setDatetime(Timestamp datetime) {
		this.datetime = datetime;
	}
}
