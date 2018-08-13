package model.bean;

public class ClassWaiting {
	private int classId;
	private String className;
	private String timeOfDate;
	private String dateOfWeek;
	private int duration;
	private String trainerName;
	private int status;
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getTimeOfDate() {
		return timeOfDate;
	}
	public void setTimeOfDate(String timeOfDate) {
		this.timeOfDate = timeOfDate;
	}
	public String getDateOfWeek() {
		return dateOfWeek;
	}
	public void setDateOfWeek(String dateOfWeek) {
		this.dateOfWeek = dateOfWeek;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public String getTrainerName() {
		return trainerName;
	}
	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public ClassWaiting(int classId, String className, String timeOfDate, String dateOfWeek, int duration,
			String trainerName, int status) {
		super();
		this.classId = classId;
		this.className = className;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.duration = duration;
		this.trainerName = trainerName;
		this.status = status;
	}
	public ClassWaiting() {
		super();
	}
	
	
	

}
