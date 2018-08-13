package model.bean;

public class RequestTakDayOff {

	private int request_id;
	private int class_id;
	private String class_name;
	private int trainer_id;
	private String trainer_name;
	private String date_off;
	private String date_change;
	private String time_change;
	private String room_name;
	private int status;
	private String note;
	
	
	
	
	
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getTrainer_id() {
		return trainer_id;
	}
	public void setTrainer_id(int trainer_id) {
		this.trainer_id = trainer_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getRequest_id() {
		return request_id;
	}
	public void setRequest_id(int request_id) {
		this.request_id = request_id;
	}
	public int getClass_id() {
		return class_id;
	}
	public void setClass_id(int class_id) {
		this.class_id = class_id;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getTrainer_name() {
		return trainer_name;
	}
	public void setTrainer_name(String trainer_name) {
		this.trainer_name = trainer_name;
	}
	public String getDate_off() {
		return date_off;
	}
	public void setDate_off(String date_off) {
		this.date_off = date_off;
	}
	public String getDate_change() {
		return date_change;
	}
	public void setDate_change(String date_change) {
		this.date_change = date_change;
	}
	public String getTime_change() {
		return time_change;
	}
	public void setTime_change(String time_change) {
		this.time_change = time_change;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public RequestTakDayOff(int request_id, int class_id, String class_name, String trainer_name, String date_off,
			String date_change, String time_change, String room_name) {
		super();
		this.request_id = request_id;
		this.class_id = class_id;
		this.class_name = class_name;
		this.trainer_name = trainer_name;
		this.date_off = date_off;
		this.date_change = date_change;
		this.time_change = time_change;
		this.room_name = room_name;
	}
	public RequestTakDayOff() {
		super();
	}
	public RequestTakDayOff(int request_id, int class_id, String class_name, int trainer_id, String trainer_name,
			String date_off, String date_change, String time_change, String room_name, int status, String note) {
		super();
		this.request_id = request_id;
		this.class_id = class_id;
		this.class_name = class_name;
		this.trainer_id = trainer_id;
		this.trainer_name = trainer_name;
		this.date_off = date_off;
		this.date_change = date_change;
		this.time_change = time_change;
		this.room_name = room_name;
		this.status = status;
		this.note = note;
	}
	
	
}