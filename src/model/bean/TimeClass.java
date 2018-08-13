package model.bean;

public class TimeClass {
	
	private int id;
	private String timeOfDate;
	private int dateOfWeek;
	private String dateOfWeekStr;
	private int duration;
	
	
	public String getDateOfWeekStr() {
		return dateOfWeekStr;
	}
	public void setDateOfWeekStr(String dateOfWeekStr) {
		this.dateOfWeekStr = dateOfWeekStr;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTimeOfDate() {
		return timeOfDate;
	}
	public void setTimeOfDate(String timeOfDate) {
		this.timeOfDate = timeOfDate;
	}
	public int getDateOfWeek() {
		return dateOfWeek;
	}
	public void setDateOfWeek(int dateOfWeek) {
		this.dateOfWeek = dateOfWeek;
	}
	public TimeClass(int id, String timeOfDate, int dateOfWeek, int duration) {
		super();
		this.id = id;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.duration = duration;
	}
	
	
	public TimeClass(int id, String timeOfDate, String dateOfWeekStr, int duration) {
		super();
		this.id = id;
		this.timeOfDate = timeOfDate;
		this.dateOfWeekStr = dateOfWeekStr;
		this.duration = duration;
	}
	public TimeClass() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
