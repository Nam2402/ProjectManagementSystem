package model.bo;

import java.util.ArrayList;
import java.util.List;

import model.bean.Classes;
import model.bean.Courses;
import model.dao.CourseDao;

public class CourseBo {
	

	public ArrayList<Courses> getCourses() {
		CourseDao courseDao = new CourseDao();
		return courseDao.getCourses();
	}

	public int changeStatusCourse(int courseId, int status) {
		CourseDao courseDao = new CourseDao();
		return courseDao.changeStatusCourse(courseId, status);
	}

	public boolean checkValidateCourse(String name, String major, String duration, String kindOfCourse) {
		if ( "".equals(name) || "".equals(major) || "".equals(duration) || "".equals(kindOfCourse)) {
			return false;
		}
		return true;
	}

	public boolean checkCourseAlreadyExists(String name) {

		ArrayList<Courses> courses = this.getCourses();
		
		for (Courses course : courses) {
			if ( course.getName().equalsIgnoreCase(name)) {
				return true;
			}
		}
		
		return false;
	}

	public int addCourse(Courses course) {
		CourseDao courseDao = new CourseDao();
		return courseDao.addCourse(course);
	}

	public Courses getCourseById(int courseId) {
		CourseDao courseDao = new CourseDao();
		return courseDao.getCourseById(courseId);
	}

	public boolean checkCourseAlreadyExistsEdit(String name, int courseId) {
		ArrayList<Courses> courses = this.getCourses();
		
		for (Courses course : courses) {
			if ( course.getName().equalsIgnoreCase(name) && course.getCourseId() != courseId) {
				return true;
			}
		}
		
		return false;
	}

	public int editCourse(Courses course) {
		CourseDao courseDao = new CourseDao();
		return courseDao.editCourse(course);
	}
	
	public int deleteCourse(int courseId) {
		ClassesBo classBo = new ClassesBo();
		
		ArrayList<Classes> classese = classBo.getClasseseByCourseId(courseId);
		if (classese.size() <= 0 ) {
			return -1;
		} else {
			CourseDao courseDao = new CourseDao();
			return courseDao.edleteCourse(courseId);
		}
	}
// Kenton
	public List<Courses> getCourseByMajor(int majorId){
		CourseDao coursedao = new CourseDao();
		return coursedao.getListCourseNameByMajor(majorId);
	}

	public ArrayList<Courses> getCoursesAnable() {
		CourseDao courseDao = new CourseDao();
		return courseDao.getCoursesAnable();
	}

}