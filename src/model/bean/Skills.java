package model.bean;

public class Skills {
	private int skillId;
	private String name;
	private int majorId;
	private int status;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getSkillId() {
		return skillId;
	}
	public void setSkillId(int skillId) {
		this.skillId = skillId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getMajorId() {
		return majorId;
	}
	public void setMajorId(int majorId) {
		this.majorId = majorId;
	}
	public Skills(int skillId, String name, int majorId, int status) {
		super();
		this.skillId = skillId;
		this.name = name;
		this.majorId = majorId;
		this.status = status;
	}
	public Skills() {
		super();
	}

}
