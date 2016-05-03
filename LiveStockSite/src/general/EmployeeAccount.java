/**
 * 
 */
package general;

import java.sql.Timestamp;

/**
 * @author Yuliya
 *
 */
public class EmployeeAccount extends UserAccount {

	private String ssn;
	private String pos;
	private int hourly;
	private Timestamp start;
	
	/**
	 * 
	 */
	public EmployeeAccount()
	{
		super();
		setUserType("E");
	}
	
	public EmployeeAccount(String ssn, String pos,
						   int hourly, Timestamp start)
	{
		super();
		this.ssn = ssn;
		this.pos = pos;
		this.hourly = hourly;
		this.start = start;
		if("Manager".equals(this.pos))
		{
			setUserType("M");
		}
		else
		{
			setUserType("R");
		}
	}

	/**
	 * @param id
	 * @param fname
	 * @param lname
	 * @param usrname
	 * @param pwd
	 * @param address
	 * @param city
	 * @param state
	 * @param zip
	 * @param phone
	 */
	public EmployeeAccount(int id, String fname, String lname,
			String usrname, String pwd, String address, String city,
			String state, String zip, String phone, String ssn,
			String pos, int hourly, Timestamp start)
	{
		super(id, fname, lname, usrname, pwd, address, city, state, zip, phone);
		this.ssn = ssn;
		this.pos = pos;
		this.hourly = hourly;
		this.start = start;
		if("Manager".equals(this.pos))
		{
			setUserType("M");
		}
		else
		{
			setUserType("R");
		}
	}

	/**
	 * Determine whether an employee is a manager.
	 * @return  true if manager, false otherwise
	 */
	public boolean isManager()
	{
		if("Manager".equals(pos))
		{
			return true;
		}
		return false;
	}
	
	/**
	 * @return the ssn
	 */
	public String getSsn() {
		return ssn;
	}

	/**
	 * @param ssn the ssn to set
	 */
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}

	/**
	 * @return the pos
	 */
	public String getPos() {
		return pos;
	}

	/**
	 * @param pos the pos to set
	 */
	public void setPos(String pos) {
		this.pos = pos;
		if("Manager".equals(this.pos))
		{
			setUserType("M");
		}
		else
		{
			setUserType("R");
		}
	}
	
	/**
	 * @return the hourly
	 */
	public int getHourly() {
		return hourly;
	}

	/**
	 * @param hourly the hourly to set
	 */
	public void setHourly(int hourly) {
		this.hourly = hourly;
	}

	/**
	 * @return the start
	 */
	public Timestamp getStart() {
		return start;
	}

	/**
	 * @param start the start to set
	 */
	public void setStart(Timestamp start) {
		this.start = start;
	}
}
