package model.bean;

import java.sql.Date;

public class MyMessages {
	private int msgId;
	private int notiId;
	private String notiContent;
	private String title;
	private int status;
	private Date createdDate;
	
	
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public int getMsgId() {
		return msgId;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}
	public int getNotiId() {
		return notiId;
	}
	public void setNotiId(int notiId) {
		this.notiId = notiId;
	}
	public String getNotiContent() {
		return notiContent;
	}
	public void setNotiContent(String notiContent) {
		this.notiContent = notiContent;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	

	public MyMessages(int msgId, int notiId, String notiContent, String title, int status) {
		super();
		this.msgId = msgId;
		this.notiId = notiId;
		this.notiContent = notiContent;
		this.title = title;
		this.status = status;
	}
	

	public MyMessages(int msgId, int notiId, String notiContent, String title, int status, Date createdDate) {
		super();
		this.msgId = msgId;
		this.notiId = notiId;
		this.notiContent = notiContent;
		this.title = title;
		this.status = status;
		this.createdDate = createdDate;
	}

	public MyMessages() {
		super();
	} 
	

}