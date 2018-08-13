package model.bo;

import java.util.ArrayList;
import java.util.List;

import model.bean.Majors;
import model.dao.MajorDao;

public class MajorBo {
	
	public MajorBo() {
		
	}
	
	public ArrayList<Majors> getMajors(){
		MajorDao majorDao= new MajorDao();
		return majorDao.getMajors();
	}
	
	public Majors getMajorById(int id){
		MajorDao majorDao= new MajorDao();
		return majorDao.getMajorById(id);
	}
	
	public void addMajor(Majors majors){
		MajorDao majorDao= new MajorDao();
		majorDao.addMajor(majors);
	}
	
	public boolean checkMajorNameAlreadyExists(String name) {
		MajorDao majorDao= new MajorDao();
		List<Majors> majors = majorDao.getMajors();
		
		for(Majors major: majors){
			if(major.getName().equals(name)){
				return true;
			}
		}
		return false;
	}
	
	public Majors getOneMajor(int majorId){
		MajorDao majorDao= new MajorDao();
		return majorDao.getOneMajor(majorId);
	}
	
	public boolean checkMajorNameAlreadyExistsEdit(String majorName, int majorId){
		MajorDao majorDao= new MajorDao();
		List<Majors> majors = majorDao.getMajors();
		for(Majors major: majors){
			if(major.getMajorId() != majorId && major.getName().equals(majorName)){
				return true;
			}
		}
		return false;
	}
	
	public void editMajors(Majors majors){
		MajorDao majorDao = new MajorDao();
		majorDao.editMajor(majors);
	}
	
	public int deleteMajor(int majorId) {
		MajorDao majorDao= new MajorDao();
		return majorDao.deleteMajor(majorId);
	}
}