package model.bean;

public class TimeLearning {
	private int timeLearning_id;
	private int startTime;
	private int endTime;
	private String timeString;
	public int getTimeLearning_id() {
		return timeLearning_id;
	}
	public void setTimeLearning_id(int timeLearning_id) {
		this.timeLearning_id = timeLearning_id;
	}
	public int getStartTime() {
		return startTime;
	}
	public void setStartTime(int startTime) {
		this.startTime = startTime;
	}
	public int getEndTime() {
		return endTime;
	}
	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}
	public String getTimeString() {
		return timeString;
	}
	public void setTimeString(String timeString) {
		this.timeString = timeString;
	}
	public TimeLearning(int timeLearning_id, int startTime, int endTime, String timeString) {
		super();
		this.timeLearning_id = timeLearning_id;
		this.startTime = startTime;
		this.endTime = endTime;
		this.timeString = timeString;
	}
	public TimeLearning() {
		super();
	}
	

}
