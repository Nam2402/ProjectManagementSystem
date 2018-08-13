package model.bean;

public class Accessment {
	private int userid;
	private String username;
	private String fullname;
	private String email;
	private String phone;
	private int status;
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Accessment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Accessment(int userid, String username, String fullname, String email, String phone, int status) {
		super();
		this.userid = userid;
		this.username = username;
		this.fullname = fullname;
		this.email = email;
		this.phone = phone;
		this.status = status;
	}
	
	
	
	
	
}
