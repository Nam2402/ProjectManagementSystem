package model.bo;

import java.util.ArrayList;
import java.util.List;

import model.bean.Results;
import model.dao.ResultDao;
import model.dao.UserDao;

public class ResultBo {
	ResultDao resultDao;
	
	public int updateResult(Results result){
		resultDao = new ResultDao();
		return resultDao.updateResult(result);
	}
	public ArrayList<Results> getResult(int classid){
		resultDao = new ResultDao();
		return resultDao.getResult(classid);
	}
	
	public int numberOfResultOfCourse(int course_id, int status_result){
		resultDao = new ResultDao();
		return resultDao.numberOfResultOfCourse(course_id, status_result);
	}
	
	public List<Results> getResultsOfCourse(int course_id, int status_result){
		resultDao = new ResultDao();
		return resultDao.getResultsOfCourse(course_id, status_result);
	}
	public List<Results> getResultsOfCourseByYear(int course_id, int status_result, String year){
		resultDao = new ResultDao();
		return resultDao.getResultsOfCourseByYear(course_id, status_result, year);
	}

}