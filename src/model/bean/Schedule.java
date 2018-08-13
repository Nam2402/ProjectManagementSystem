package model.bean;

import java.sql.Date;
import java.util.ArrayList;

public class Schedule {
	private String nameclass;
	private String course;
	private int trainerId;
	private String fullname;
	private Date createAt;
	private String timeOfDate;
	private String dateOfWeek;
	private int countLession;
	private String nameroom;
	private int classid;
	private String username;
	private int duration;
	
	
	
	


	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNameclass() {
		return nameclass;
	}
	public void setNameclass(String nameclass) {
		this.nameclass = nameclass;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public int getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
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

	public int getCountLession() {
		return countLession;
	}

	public void setCountLession(int countLession) {
		this.countLession = countLession;
	}

	public String getNameroom() {
		return nameroom;
	}

	public void setNameroom(String nameroom) {
		this.nameroom = nameroom;
	}

	public int getClassid() {
		return classid;
	}

	public void setClassid(int classid) {
		this.classid = classid;
	}
	

	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public Schedule() {
		super();
	}
	public Schedule(String nameclass, String course, int trainerId, String fullname, Date createAt, String timeOfDate,
			String dateOfWeek, int countLession, String nameroom, int classid, String username, int duration) {
		super();
		this.nameclass = nameclass;
		this.course = course;
		this.trainerId = trainerId;
		this.fullname = fullname;
		this.createAt = createAt;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.countLession = countLession;
		this.nameroom = nameroom;
		this.classid = classid;
		this.username = username;
		this.duration = duration;
	}

	
}