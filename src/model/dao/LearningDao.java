package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.Classes;
import model.bean.Rooms;
import model.bean.TimeLearning;
import model.bean.User;
public class LearningDao {

	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ArrayList<Classes> getClassByDate(String Date){
		conn = ConnectDBLibrary.getConnection();
		ArrayList<Classes> classes = new ArrayList<>();
		String sql = "SELECT class_id FROM classes WHERE date_of_week LIKE ? and status =1";
		try {
			String chen = "%" +Date+"%";
			pst = conn.prepareStatement(sql);
			pst.setString(1,chen);
			rs = pst.executeQuery();
			while (rs.next()) {
			Classes list = new Classes();
			list.setClassId(rs.getInt("class_id"));
			classes.add(list);
				
				
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		 
		return classes;
		
	}
	public int deleteClass(int Class){
		conn = ConnectDBLibrary.getConnection();
		int result=0;
		String sql = "DELETE from learning where class_id=?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, Class);
			while(pst.execute()) {
				result =1;	
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return result;
		
	}
public  ArrayList<User> countTraineeConflict(int classId , int class_other){
		
		ArrayList<User> listTraineeConflict = new ArrayList<>();
		try {
			String sql = "select * from learning where class_id = ? and user_id = any (select user_id from learning where class_id = ? )";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, class_other);
			pst.setInt(2, classId);
			rs = pst.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				listTraineeConflict.add(user);
			}

		} catch (SQLException e) {
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return listTraineeConflict;
	}
	
	public int checkConflictTraineeClassSameTime(Classes classes, ArrayList<Classes> listClassSameTime){		
		int count = 0;
		int class_id = classes.getClassId();
		for(Classes classSameTime: listClassSameTime){
			int classSameTime_id = classSameTime.getClassId();
			ArrayList<User> listUserAreConflict = new ArrayList<>();
			listUserAreConflict = countTraineeConflict(class_id, classSameTime_id);
			if(listUserAreConflict.size()>0){
				count++;
			}
			
		}
		
		return count;
	}
	
	public ArrayList<TimeLearning> getTimeFreeOfClassInDay(Classes classes, String date){
		
		ArrayList<TimeLearning> listTimeLearning = new ArrayList<>();
		conn = ConnectDBLibrary.getConnection();
		
		try {
			String sql = "select time from timetable where time != all (select DISTINCT time_of_date from classes" 
+ " inner join learning on classes.class_id = learning.class_id where date_of_week like ? and  learning.user_id = all  (select user_id from learning where class_id = ?))  and time != all  (select DISTINCT time_of_date from classes  where date_of_week like ? and  trainer_id = (select trainer_id from classes where class_id = ?)) and duration = ?";
			pst = conn.prepareStatement(sql);
			String chen = "%" +date+"%";
			pst.setString(1, chen);
			pst.setInt(2, classes.getClassId());
			pst.setString(3, chen);
			pst.setInt(4, classes.getClassId());
			pst.setInt(5, 2);
			rs = pst.executeQuery();
			while (rs.next()) {
				TimeLearning timeLearning = new TimeLearning();
				timeLearning.setTimeString(rs.getString("time"));
				listTimeLearning.add(timeLearning);
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return listTimeLearning;
	
	}
	
	public ArrayList<TimeLearning> getTimeBusyOf(Classes classes, ArrayList<User> listUser, int date){
		ArrayList<TimeLearning> listTimeBusyOfClass = new ArrayList<>();
		
		
		return listTimeBusyOfClass;
	}
	
	public ArrayList<Rooms> getRoomFreeInTime(String time , String date){
		ArrayList<Rooms> listRoomFree = new ArrayList<>();
		conn = ConnectDBLibrary.getConnection();
		try {
			String sql = "select room_id, name from rooms where room_id != all (Select room_id from classes where date_of_week like ? and time_of_date = ?) and rooms.status = ?";
			pst = conn.prepareStatement(sql);
			String chen = "%" +date+"%";
			pst.setString(1, chen);
			pst.setString(2, time);
			pst.setInt(3, 1);
			rs = pst.executeQuery();
			while (rs.next()) {
				Rooms rooms = new Rooms();
				rooms.setRoomId(rs.getInt("room_id"));
				rooms.setName(rs.getString("name"));
				listRoomFree.add(rooms);
			}

		} catch (SQLException e) {
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return listRoomFree;
	}
	

}
