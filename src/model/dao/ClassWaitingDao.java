package model.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.ClassWaiting;

public class ClassWaitingDao {
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	
	public ArrayList<ClassWaiting> getClassWaitingofTrainee(int trainee_id){
		ArrayList<ClassWaiting> listClassWaitingofTrainee = new ArrayList<>();
		String sql = "select classes.class_id , classes.time_of_date, classes.date_of_week from classes inner join waiting on classes.class_id = waiting.class_id where waiting.user_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, trainee_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				ClassWaiting classWaiting = new ClassWaiting();
				classWaiting.setClassId(rs.getInt("class_id"));
				classWaiting.setTimeOfDate(rs.getString("time_of_date"));
				classWaiting.setDateOfWeek(rs.getString("date_of_week"));
				listClassWaitingofTrainee.add(classWaiting);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return listClassWaitingofTrainee;
	}
	public int checkConflicRegisterClass(ClassWaiting classWaiting, ArrayList<ClassWaiting> arrayList){
		int class_id =0;
		
		for(ClassWaiting classWaiting2: arrayList){
			class_id = checkConflicDate(classWaiting, classWaiting2);
			if (class_id!=0){
				return class_id;
			}
		}
		
		return class_id;
	}
	
	public ClassWaiting getClassById(int class_id){
		String sql = "select * from classes where class_id=?";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, class_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				ClassWaiting classWaiting = new ClassWaiting();
				classWaiting.setClassId(rs.getInt("class_id"));
				classWaiting.setClassName(rs.getString("name"));
				classWaiting.setTimeOfDate(rs.getString("time_of_date"));
				classWaiting.setDateOfWeek(rs.getString("date_of_week"));
				return classWaiting;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return null;		
	}
//	public static void main (String []args){
//		
//		ClassWaiting classWaiting1 = new ClassWaiting(1, "GIT01", "7:00-9:00", "2,4,6", 12, "Tunner" , 1);
//		ClassWaiting classWaiting2 = new ClassWaiting(1, "GIT01", "6:00-7:00", "2,4", 12, "Tunner" , 1);
//		if (checkConflicDate(classWaiting1, classWaiting2)){
//			System.out.println("Have conflic!");
//		} else {
//			System.out.println("Can register");
//		}
//
//	}
	
	public static int checkConflicDate(ClassWaiting classWaiting1, ClassWaiting classWaiting2){
		int result = 0;
		
		String date1 = classWaiting1.getDateOfWeek();
		String[] date1s = date1.split(",");
		String date2 = classWaiting2.getDateOfWeek();
		String[] date2s = date2.split(",");
		for(int i=0; i< date1s.length;i++){
			for(int j=0; j< date2s.length; j++){
				if(date1s[i].equals(date2s[j])){
					String time1 = classWaiting1.getTimeOfDate();
					String[] time1s = time1.split("-");
					String time2 = classWaiting2.getTimeOfDate();
					String[] time2s = time2.split("-");
					if (checkConflicTime(time1s, time2s)){
						result = classWaiting2.getClassId();
						return result;
					}
					
				}
			}
		}
		return result;
	}
	public static  boolean checkConflicTime (String[] time1s, String[] time2s){
		boolean result = false;
		String timestart1 = time1s[0];
		String timeend1 = time1s[1];
		
		String timestart2 = time2s[0];
		String timeend2 = time2s[1];
		
		if(compareTime(timestart1, timestart2)==1){
			if(compareTime(timeend1,timestart2)==1 || compareTime(timeend1, timestart2)==0){
				result = false;
				return result;
			} else{
				result = true;
				return result;
			}
		} else {
			if(compareTime(timestart1, timestart2)==2){
				if (compareTime(timestart1, timeend2)==2|| compareTime(timestart1, timeend2)==0){
					result = false;
					return result;
				} else {
					result = true;
					return result;
				}
				
			} else {
				return true;
			}
		}
		
	}
	
	
	public static int compareTime(String time1, String time2){
		// time1 early time 2 => 1
		//time 1 lately time 2 =>2
		//time1 equal time 2 => 0		
		int result = 0; 
		String[] hourandminute1 = time1.split(":");
		String[] hourandminute2 = time2.split(":");
		int hour1 = Integer.valueOf(hourandminute1[0]);
		int minute1 = Integer.valueOf(hourandminute1[1]);
		int hour2 = Integer.valueOf(hourandminute2[0]);
		int minute2 = Integer.valueOf(hourandminute2[1]);
		if (hour1<hour2) {
			result = 1;
		} else if (hour1>hour2){
			result = 2;
		} else{
			if (minute1<minute2){
				result = 1;
			} else {
				if (minute1>minute2){
					result = 2;
				} else 
					result =0;
			}
		}
		return result;
		
	}
}
