package model.bo;

import java.util.ArrayList;

import model.bean.Classes;
import model.bean.TimeClass;
import model.dao.ClassesDao;

public class ClassesBo {

	public ArrayList<Classes> getClasseseByCourseId(int courseId) {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.getClasseseByCourseId(courseId);
	}
	
	public String getNameClass(int classId){
		ClassesDao classDao = new ClassesDao();
		return classDao.getNameClass(classId);
		
	}
	
	public int updateStatusClass(int Class){
		ClassesDao classDao = new ClassesDao();
		return classDao.changeStatus(Class, 2);
	}

	public ArrayList<Classes> getClassese() {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.getClassese();
	}

	public ArrayList<Classes> getClasseseWaiting() {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.getClasseseWaiting();
	}

	public ArrayList<Classes> getClasseseOpenning() {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.getClasseseOpenning();
	}

	public ArrayList<Classes> getClasseseFinished() {

		ClassesDao classDao = new ClassesDao();
		
		return classDao.getClasseseFinished();
	}

	public int changeStatus(int classId, int status) {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.changeStatus(classId, status);
	}

	public ArrayList<Integer> getTraineeWaitingByClass(int classId) {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.getTraineeWaitingByClass(classId);
	}

	public int delTraieeWaitting(int classId) {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.delTraieeWaitting(classId);
	}

	public int addTraineeLearning(Integer integer, int classId) {
		ClassesDao classDao = new ClassesDao();
		
		return classDao.addTraineeLearning(integer, classId);
	}
	
	public ArrayList<TimeClass> getFreeTime(int roomId){
		ClassesDao classDao = new ClassesDao();
		
		ArrayList<TimeClass> timeFrees = new ArrayList<>();
		ArrayList<TimeClass> times = classDao.getTimeClass();
		
		int i = 0;
		for ( int day = 2; day < 8; day++) {
			for (TimeClass time : times) {
				if (classDao.checkTimeAlready(time.getTimeOfDate(), String.valueOf(day), roomId) == false) {

					TimeClass timefree = new TimeClass(i, time.getTimeOfDate(), day, time.getDuration());
					if ( checkTime(timeFrees, time.getTimeOfDate()) == false) {
						timeFrees.add(timefree);
					}
					i++;
				}
			}
		}
		
		return timeFrees;
	}

	public ArrayList<TimeClass> getFreeTimeInDay(int duration, ArrayList<String> days, int roomId, int trainerId) {
		ClassesDao classDao = new ClassesDao();
		
		ArrayList<TimeClass> timeFrees = new ArrayList<>();
		ArrayList<TimeClass> times = classDao.getTimeClassByDuration(duration);
		ArrayList<TimeClass> timeBusy = new ArrayList<>();
		ArrayList<TimeClass> newTimeBusy = new ArrayList<>();
		
		for (String day : days) {
			ArrayList<TimeClass> timeInDay = classDao.getTimeInDayAndRoom(day, roomId, trainerId);
			
			for (TimeClass timeClass : timeInDay) {
				timeBusy.add(timeClass);
			}
		}
		
		
		for(TimeClass time : times ) {
			for (TimeClass timebusy : timeBusy) {
				System.out.println(time.getTimeOfDate() + " and busy " + timebusy.getTimeOfDate() + " : " 
			+ (checkConflictTime(timebusy.getTimeOfDate(), time.getTimeOfDate()) == false && checkTime(timeFrees, time.getTimeOfDate()) == false));
				
				if ( (checkConflictTime(timebusy.getTimeOfDate(), time.getTimeOfDate()) == false)
						&& (checkTime(timeFrees, time.getTimeOfDate()) == false )
						&& (checkTime(newTimeBusy, time.getTimeOfDate()) == false)) {
					timeFrees.add(time);
				} else {
					newTimeBusy.add(time);
				}
			}
		}
		
		return timeFrees;
	}
	
	public boolean checkConflictTime(String time1, String time2) {
		
		int startTimeOfTime1 = Integer.parseInt(time1.substring(0, 2));
		int endTimeOfTime1 = Integer.parseInt(time1.substring(6, 8));

		int startTimeOfTime2 = Integer.parseInt(time2.substring(0, 2));
		int endTimeOfTime2 = Integer.parseInt(time2.substring(6, 8));
		
		if ( (startTimeOfTime1 <= startTimeOfTime2 && startTimeOfTime2 < endTimeOfTime1) || (startTimeOfTime1 < endTimeOfTime2 && endTimeOfTime2 <= endTimeOfTime1)) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean checkTime(ArrayList<TimeClass> times, String time) {
		for (TimeClass timeClass : times) {
			if ( timeClass.getTimeOfDate().equals(time)) {
				return true;
			}
		}
		return false;
	}

	public int addClass(Classes newClass) {
		ClassesDao classDao = new ClassesDao();
		return classDao.addClass(newClass);
	}
	
	public boolean checkClassAlreadyExists(String name) {
		ClassesDao classDao = new ClassesDao();
		
		ArrayList<Classes> classes =  classDao.getClassese();
		for (Classes classes2 : classes) {
			if (classes2.getName().equalsIgnoreCase(name)) {
				return true;
			}
		}
		return false;
	}


}