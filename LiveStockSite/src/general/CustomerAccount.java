/**
 * 
 */
package general;

/**
 * @author Yuliya
 *
 */
public class CustomerAccount extends UserAccount {

	private String email;
	private int rating;
	
	public CustomerAccount()
	{
		super();
		this.setUserType("C");
	}
	
	public CustomerAccount(String email, int rating)
	{
		super();
		this.email = email;
		this.rating = rating;
		this.setUserType("C");
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
	public CustomerAccount(int id, String fname, String lname, String usrname,
						   String pwd, String address, String city, String state,
						   String zip, String phone, String email, int rating)
	{
		super(id, fname, lname, usrname, pwd, address, city, state, zip, phone);
		this.email = email;
		this.rating = rating;
		this.setUserType("C");
	}
	
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the rating
	 */
	public int getRating() {
		return rating;
	}
	/**
	 * @param rating the rating to set
	 */
	public void setRating(int rating) {
		this.rating = rating;
	}
}
