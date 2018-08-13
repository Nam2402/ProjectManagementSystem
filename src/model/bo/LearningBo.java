package model.bo;

import java.util.ArrayList;

import model.bean.Classes;
import model.bean.Rooms;
import model.bean.TimeLearning;
import model.bean.User;
import model.dao.LearningDao;

public class LearningBo {
	LearningDao learningDao;
	
	public ArrayList<Classes> getClassByDate(String Date){
		learningDao = new LearningDao();
		return learningDao.getClassByDate(Date);
	}
	public int deleteClass(int Class){
		learningDao = new LearningDao();
		return learningDao.deleteClass(Class);
	}
	public  ArrayList<User> countTraineeConflict(int classId , int class_other){
		learningDao = new LearningDao();
		return learningDao.countTraineeConflict(classId,class_other);
	}
	public int checkConflictTraineeClassSameTime(Classes classes, ArrayList<Classes> listClassSameTime){
		learningDao = new LearningDao();
		return learningDao.checkConflictTraineeClassSameTime(classes, listClassSameTime);
	}
	public ArrayList<TimeLearning> getTimeFreeOfClassInDay(Classes classes, String date){
		learningDao = new LearningDao();
		return learningDao.getTimeFreeOfClassInDay(classes, date);
	}
	public ArrayList<Rooms> getRoomFreeInTime(String time , String date){
		learningDao = new LearningDao();
		return learningDao.getRoomFreeInTime(time, date);
	}
}
