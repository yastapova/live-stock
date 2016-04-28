package general;

import java.sql.Date;

public class Account {
	private int accId;
	private Date accCreationDate;
	private long creditCardNum;	
	
	public Account(int accId, Date accCreationDate, long creditCardNum) {
		this.accId = accId;
		this.accCreationDate = accCreationDate;
		this.creditCardNum = creditCardNum;
	}
	
	public Date getAccCreationDate() {
		return accCreationDate;
	}
	public void setAccCreationDate(Date accCreationDate) {
		this.accCreationDate = accCreationDate;
	}
	public long getCreditCardNum() {
		return creditCardNum;
	}
	public void setCreditCardNum(long creditCardNum) {
		this.creditCardNum = creditCardNum;
	}
	public int getAccId() {
		return accId;
	}
	public void setAccId(int accId) {
		this.accId = accId;
	}
}
