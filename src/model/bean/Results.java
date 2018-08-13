package model.bean;

public class Results {
	private int reaultId;
	private int classId;
	private int userId;
	private int status;
	private String className;
	
	public int getReaultId() {
		return reaultId;
	}
	public void setReaultId(int reaultId) {
		this.reaultId = reaultId;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String  className) {
		this.className = className;
	}
	public Results(int reaultId, int classId, int userId, int status) {
		super();
		this.reaultId = reaultId;
		this.classId = classId;
		this.userId = userId;
		this.status = status;
	}
	public Results() {
		super();
		// TODO Auto-generated constructor stub
	}
}
