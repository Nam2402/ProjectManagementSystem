package model.bo;

import java.util.ArrayList;
import java.util.List;

import model.bean.Courses;
import model.bean.Skills;
import model.dao.CourseDao;
import model.dao.SkillDao;

public class SkillBo {
	SkillDao skillDao= new SkillDao();
	public List<Skills> getSkills(){
		return skillDao.getSkills();
	}
	public String getSkillById(int id){
		return skillDao.getSkillById(id);
	}
	public void addSkill(Skills skills){
	SkillDao skilldao = new SkillDao();
	skilldao.addSkill(skills);
	}
	public boolean checkSkillNameAlreadyExists(String name) {
		skillDao = new SkillDao();
		List<Skills> skills = skillDao.getSkills();
		
		for(Skills skill: skills){
			if(skill.getName().equals(name)){
				return true;
			}
		}
		return false;
	}
	
	public List<Skills> getSkillAll(){
		return skillDao.getSkillAll();
	}

	public Skills getOneSkill(int skillId){
		skillDao = new SkillDao();
		return skillDao.getOneSkill(skillId);
	}
	
	public boolean checkSkillNameAlreadyExistsEdit(String skillName, int skillId){
		skillDao = new SkillDao();
		List<Skills> skills = skillDao.getSkills();
		for(Skills skill: skills){
			if(skill.getSkillId() != skillId && skill.getName().equals(skillName)){
				return true;
			}
		}
		return false;
	}
	public void editSkills(Skills skills){
		SkillDao skillDao = new SkillDao();
		skillDao.editSkill(skills);
	}
	
	public int deleteSkills(int skillId){
		skillDao = new SkillDao();
		return skillDao.deleteSkill(skillId);
	}

	
}
