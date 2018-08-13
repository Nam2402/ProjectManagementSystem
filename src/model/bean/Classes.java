package model.bean;

import java.sql.Date;

public class Classes {
	private int classId;;
	private int courseId;
	private int trainerId;
	private Date createAt;
	private String timeOfDate;
	private String dateOfWeek;
	private int countLession;
	private int roomId;
	private String name;
	private int status;
	private String nameTrainer;
	private String nameCourse;
	private int duration;
	private String nameRoom;
	private int students;
	private int totalStudents;
	
	
	
	public int getTotalStudents() {
		return totalStudents;
	}


	public void setTotalStudents(int totalStudents) {
		this.totalStudents = totalStudents;
	}


	public int getStudents() {
		return students;
	}


	public void setStudents(int students) {
		this.students = students;
	}


	public String getNameRoom() {
		return nameRoom;
	}


	public void setNameRoom(String nameRoom) {
		this.nameRoom = nameRoom;
	}


	public String getNameTrainer() {
		return nameTrainer;
	}


	public void setNameTrainer(String nameTrainer) {
		this.nameTrainer = nameTrainer;
	}


	public String getNameCourse() {
		return nameCourse;
	}


	public void setNameCourse(String nameCourse) {
		this.nameCourse = nameCourse;
	}


	public int getDuration() {
		return duration;
	}


	public void setDuration(int duration) {
		this.duration = duration;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public int getClassId() {
		return classId;
	}


	public void setClassId(int classId) {
		this.classId = classId;
	}


	public int getCourseId() {
		return courseId;
	}


	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}


	public int getTrainerId() {
		return trainerId;
	}


	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
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


	public int getRoomId() {
		return roomId;
	}


	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}


	public Classes(int classId, int courseId, int trainerId, Date createAt, String timeOfDate, String dateOfWeek,
			int countLession, int roomId) {
		super();
		this.classId = classId;
		this.courseId = courseId;
		this.trainerId = trainerId;
		this.createAt = createAt;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.countLession = countLession;
		this.roomId = roomId;
	}

	

	public Classes(int classId, int courseId, int trainerId, Date createAt, String timeOfDate, String dateOfWeek,
			int countLession, int roomId, int status, String name) {
		super();
		this.classId = classId;
		this.courseId = courseId;
		this.trainerId = trainerId;
		this.createAt = createAt;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.countLession = countLession;
		this.roomId = roomId;
		this.name = name;
		this.status = status;
	}

	
	public Classes(int classId, int courseId, int trainerId, Date createAt, String timeOfDate, String dateOfWeek,
			int countLession, int roomId, String name, int status, String nameTrainer, String nameCourse,
			int duration, String nameRoom, int students) {
		super();
		this.classId = classId;
		this.courseId = courseId;
		this.trainerId = trainerId;
		this.createAt = createAt;
		this.timeOfDate = timeOfDate;
		this.dateOfWeek = dateOfWeek;
		this.countLession = countLession;
		this.roomId = roomId;
		this.name = name;
		this.status = status;
		this.nameTrainer = nameTrainer;
		this.nameCourse = nameCourse;
		this.duration = duration;
		this.nameRoom = nameRoom;
		this.students = students;
	}


	public Classes() {
		super();
		// TODO Auto-generated constructor stub
	}
}
