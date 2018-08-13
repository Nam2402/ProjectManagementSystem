package model.bo;


import java.util.ArrayList;

import com.sun.org.apache.regexp.internal.recompile;

import model.bean.ClassWaiting;
import model.dao.ClassWaitingDao;

public class ClassWatingBo {
	ClassWaitingDao classWaitingDao;
	public ClassWaiting getClassWaitingById(int class_id){
		classWaitingDao = new ClassWaitingDao();
		return classWaitingDao.getClassById(class_id);
	}
	
	public int checkConflicRegisterClass(ClassWaiting classWaiting, ArrayList<ClassWaiting> arrayList){
		classWaitingDao = new ClassWaitingDao();
		return classWaitingDao.checkConflicRegisterClass(classWaiting, arrayList);
		
	}
	
	public ArrayList<ClassWaiting> getClassWaitingOfTrainee(int trainee_id){
		classWaitingDao = new ClassWaitingDao();
		return classWaitingDao.getClassWaitingofTrainee(trainee_id);
	}
}
