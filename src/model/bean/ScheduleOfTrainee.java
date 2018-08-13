package model.bean;

public class ScheduleOfTrainee {
	private int classid;
	private String nameClass;
	private String nameTrainer;
	private String timeofday;
	private String dateofweek;
	private int countLession;
	private String nameRoom;
	private int duration;
	private int status;
	
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public String getNameClass() {
		return nameClass;
	}
	public void setNameClass(String nameClass) {
		this.nameClass = nameClass;
	}
	public String getNameTrainer() {
		return nameTrainer;
	}
	public void setNameTrainer(String nameTrainer) {
		this.nameTrainer = nameTrainer;
	}
	public String getTimeofday() {
		return timeofday;
	}
	public void setTimeofday(String timeofday) {
		this.timeofday = timeofday;
	}
	public String getDateofweek() {
		return dateofweek;
	}
	public void setDateofweek(String dateofweek) {
		this.dateofweek = dateofweek;
	}
	public int getCountLession() {
		return countLession;
	}
	public void setCountLession(int countLession) {
		this.countLession = countLession;
	}
	public String getNameRoom() {
		return nameRoom;
	}
	public void setNameRoom(String nameRoom) {
		this.nameRoom = nameRoom;
	}
	
	public int getClassid() {
		return classid;
	}
	public void setClassid(int classid) {
		this.classid = classid;
	}
	public ScheduleOfTrainee() {
		super();
	}
	public ScheduleOfTrainee(int classid, String nameClass, String nameTrainer, String timeofday, String dateofweek,
			int countLession, String nameRoom) {
		super();
		this.classid = classid;
		this.nameClass = nameClass;
		this.nameTrainer = nameTrainer;
		this.timeofday = timeofday;
		this.dateofweek = dateofweek;
		this.countLession = countLession;
		this.nameRoom = nameRoom;
	}
	public ScheduleOfTrainee(int classid, String nameClass, String nameTrainer, String timeofday, String dateofweek,
			int countLession, String nameRoom, int duration) {
		super();
		this.classid = classid;
		this.nameClass = nameClass;
		this.nameTrainer = nameTrainer;
		this.timeofday = timeofday;
		this.dateofweek = dateofweek;
		this.countLession = countLession;
		this.nameRoom = nameRoom;
		this.duration = duration;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public ScheduleOfTrainee(int classid, String nameClass, String nameTrainer, String timeofday, String dateofweek,
			int countLession, String nameRoom, int duration, int status) {
		super();
		this.classid = classid;
		this.nameClass = nameClass;
		this.nameTrainer = nameTrainer;
		this.timeofday = timeofday;
		this.dateofweek = dateofweek;
		this.countLession = countLession;
		this.nameRoom = nameRoom;
		this.duration = duration;
		this.status = status;
	}
	
	


}
