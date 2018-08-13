package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.Classes;
import model.bean.TimeClass;

public class ClassesDao {

	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ArrayList<Classes> getClasseseByCourseId(int courseId) {
		ArrayList<Classes> classes = new ArrayList<>();
		
		conn  = ConnectDBLibrary.getConnection();
		String sql = "select * from classes where course_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Classes classE = new Classes(rs.getInt("class_id"), rs.getInt("course_id"), rs.getInt("trainer_id"), rs.getDate("created_at"), rs.getString("time_of_date"),
									rs.getString("date_of_week"), rs.getInt("count_lesson"), rs.getInt("room_id"), rs.getInt("status"), rs.getString("name"));
				classes.add(classE);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return classes;
	}

	public String getNameClass(int classId){
		conn= ConnectDBLibrary.getConnection();
		String classname = "";
		try{
			
			String sql= "select * from classes WHERE class_id = ?";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classId);
			rs = pst.executeQuery();
			while(rs.next()) {
				classname = rs.getString("name");
				
			}
		}
		catch(SQLException e){
			System.out.println(e);
		}
		return classname;
	}


	public ArrayList<Classes> getClassese() {
		ArrayList<Classes> classes = new ArrayList<>();
		
		conn  = ConnectDBLibrary.getConnection();
		String sql = "select class_id, classes.name, classes.status, classes.created_at, time_of_date, date_of_week, count_lesson, courses.course_id, courses.name as courseName, trainer_id " + 
				", courses.duration, classes.count_lesson, users.username as nameTrainer, classes.room_id, rooms.name as nameRoom from classes " +
				"inner join courses on classes.course_id = courses.course_id  " + 
				"inner join users on classes.trainer_id = users.user_id  inner join rooms on classes.room_id = rooms.room_id" +
				" order by classes.class_id desc";
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Classes classE = new Classes(rs.getInt("class_id"), rs.getInt("course_id"), rs.getInt("trainer_id"), rs.getDate("created_at"), rs.getString("time_of_date"),
									rs.getString("date_of_week"), rs.getInt("count_lesson"), rs.getInt("room_id"), rs.getString("name"), rs.getInt("status"), 
									rs.getString("nameTrainer"),rs.getString("courseName"),  rs.getInt("duration"), rs.getString("nameRoom"), 0);
				classes.add(classE);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return classes;
	}

	public ArrayList<Classes> getClasseseWaiting() {
		ArrayList<Classes> classes = new ArrayList<>();
		
		conn  = ConnectDBLibrary.getConnection();
		String sql = "select classes.class_id, classes.name, classes.status, classes.created_at, time_of_date, date_of_week, count_lesson, courses.course_id, courses.name as courseName, trainer_id " + 
				", courses.duration, classes.count_lesson, users.username as nameTrainer, classes.room_id, rooms.name as nameRoom, count(waiting.user_id) as students from classes " +
				"inner join courses on classes.course_id = courses.course_id  left join waiting on classes.class_id = waiting.class_id " + 
				"left join users on classes.trainer_id = users.user_id  inner join rooms on classes.room_id = rooms.room_id where classes.status = 0 group by classes.class_id" +
				" order by classes.class_id desc";

		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Classes classE = new Classes(rs.getInt("class_id"), rs.getInt("course_id"), rs.getInt("trainer_id"), rs.getDate("created_at"), rs.getString("time_of_date"),
									rs.getString("date_of_week"), rs.getInt("count_lesson"), rs.getInt("room_id"), rs.getString("name"), rs.getInt("status"), 
									rs.getString("nameTrainer"),rs.getString("courseName"),  rs.getInt("duration"), rs.getString("nameRoom"), rs.getInt("students"));
				
				classes.add(classE);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return classes;
	}

	public ArrayList<Classes> getClasseseOpenning() {
		ArrayList<Classes> classes = new ArrayList<>();
		
		conn  = ConnectDBLibrary.getConnection();
		String sql = "select classes.class_id, classes.name, classes.status, classes.created_at, time_of_date, date_of_week, count_lesson, courses.course_id, courses.name as courseName, trainer_id " + 
				", courses.duration, classes.count_lesson, users.username as nameTrainer, classes.room_id, rooms.name as nameRoom, count(learning.user_id) as students from classes " +
				"inner join courses on classes.course_id = courses.course_id  left join learning on classes.class_id = learning.class_id " + 
				"inner join users on classes.trainer_id = users.user_id  inner join rooms on classes.room_id = rooms.room_id where classes.status = 1 group by classes.class_id" +
				" order by classes.class_id desc";
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Classes classE = new Classes(rs.getInt("class_id"), rs.getInt("course_id"), rs.getInt("trainer_id"), rs.getDate("created_at"), rs.getString("time_of_date"),
									rs.getString("date_of_week"), rs.getInt("count_lesson"), rs.getInt("room_id"), rs.getString("name"), rs.getInt("status"), 
									rs.getString("nameTrainer"),rs.getString("courseName"),  rs.getInt("duration"), rs.getString("nameRoom"), rs.getInt("students"));
				classes.add(classE);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return classes;
	}

	public ArrayList<Classes> getClasseseFinished() {
		ArrayList<Classes> classes = new ArrayList<>();
		
		conn  = ConnectDBLibrary.getConnection();
		String sql = "select classes.class_id, classes.name, classes.status, classes.created_at, time_of_date, date_of_week, count_lesson, courses.course_id, courses.name as courseName, trainer_id " + 
				" , courses.duration, classes.count_lesson, users.username as nameTrainer, classes.room_id, rooms.name as nameRoom, " + 
				" (select count(user_id) from results inner join classes on results.class_id = classes.class_id where results.status = 0)  as traineeFailed, " +
				" (select count(user_id) from results inner join classes on results.class_id = classes.class_id )  as students from classes " + 
				" inner join courses on classes.course_id = courses.course_id  left join results on classes.class_id = results.class_id  " + 
				" inner join users on classes.trainer_id = users.user_id  inner join rooms on classes.room_id = rooms.room_id where classes.status = 2 group by classes.class_id " +
				" order by classes.class_id desc";
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Classes classE = new Classes(rs.getInt("class_id"), rs.getInt("course_id"), rs.getInt("trainer_id"), rs.getDate("created_at"), rs.getString("time_of_date"),
									rs.getString("date_of_week"), rs.getInt("count_lesson"), rs.getInt("room_id"), rs.getString("name"), rs.getInt("status"), 
									rs.getString("nameTrainer"),rs.getString("courseName"),  rs.getInt("duration"), rs.getString("nameRoom"), rs.getInt("traineeFailed"));
				classE.setTotalStudents(rs.getInt("students"));
				classes.add(classE);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return classes;
	}

	public int changeStatus(int classId, int status) {
		int kq = 0;
		String sql = "update classes set status = ? where class_id = ?";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, status);
			pst.setInt(2, classId);
			kq = pst.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}

	public ArrayList<Integer> getTraineeWaitingByClass(int classId) {
		ArrayList<Integer> traineeIds = new ArrayList<>();
		String sql = "select * from waiting where class_id = ?";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classId);
			rs = pst.executeQuery();
			while (rs.next()) {
				int traineeId = rs.getInt("user_id");
				traineeIds.add(traineeId);		
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return traineeIds;
	}

	public int delTraieeWaitting(int classId) {
		int kq = 0;
		String sql = "delete from waiting where class_id = ?";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classId);
			kq = pst.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}

	public int addTraineeLearning(Integer integer, int classId) {
		int kq = 0;
		String sql = "insert into learning(class_id, user_id) values(?, ?)";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classId);
			pst.setInt(2, integer);
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}
	
	public ArrayList<TimeClass> getTimeClassAlready(){
		ArrayList<TimeClass> times = new ArrayList<>();
		
		String sql = "select class_id, time_of_date, date_of_week from classes where   status = 1 or status = 0";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				TimeClass time =  new TimeClass(rs.getInt("class_id"), rs.getString("time_of_date"), rs.getString("date_of_week"), 0);
				times.add(time);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return times;
	}
	
	
	public ArrayList<TimeClass> getTimeClass(){
		ArrayList<TimeClass> times = new ArrayList<>();
		
		String sql = "select * from timetable";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				TimeClass time =  new TimeClass(rs.getInt("time_id"), rs.getString("time"), 0, rs.getInt("duration"));
				times.add(time);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return times;
	}
	
	public boolean checkTimeAlready(String time, String day, int roomId) {
		boolean check = false;
		
		conn = ConnectDBLibrary.getConnection();
		String sql  = "select * from classes where time_of_date like '%" + time + "%' and date_of_week like '%" + day + "%' and ( status = 1 or status = 0 ) and room_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, roomId);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				check = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
				
		return check;
		
	}

	public ArrayList<TimeClass> getTimeClassByDuration(int duration) {
		ArrayList<TimeClass> times = new ArrayList<>();
		
		String sql = "select * from timetable where duration = ?";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, duration);
			rs = pst.executeQuery();
			while (rs.next()) {
				TimeClass time =  new TimeClass(rs.getInt("time_id"), rs.getString("time"), 0, rs.getInt("duration"));
				times.add(time);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return times;
	}

	public ArrayList<TimeClass> getTimeInDayAndRoom(String day, int roomId,int trainerId) {
		ArrayList<TimeClass> times = new ArrayList<>();
		
		conn = ConnectDBLibrary.getConnection();
		String sql  = "select * from classes where date_of_week like '%" + day + "%' and "  + 
						"(status = 1 or status = 0) and (room_id = ? or trainer_id = ?) order by class_id desc";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, roomId);
			pst.setInt(2, trainerId);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				TimeClass time = new TimeClass(rs.getInt("class_id"), rs.getString("time_of_date"), rs.getString("date_of_week"), 0);
				times.add(time);		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
				
		return times;
	}

	public int addClass(Classes newClass) {
		int kq = 0;
		
		conn = ConnectDBLibrary.getConnection();
		String sql  = "insert into classes(created_at, time_of_date, date_of_week, count_lesson, course_id, trainer_id, room_id, name, status) values(?,?,?,?,?,?,?,?,?)";
		try {
			pst = conn.prepareStatement(sql);
			
			pst.setDate(1, newClass.getCreateAt());
			pst.setString(2, newClass.getTimeOfDate());
			pst.setString(3, newClass.getDateOfWeek());
			pst.setInt(4, 0);
			pst.setInt(5, newClass.getCourseId());
			pst.setInt(6, newClass.getTrainerId());
			pst.setInt(7, newClass.getRoomId());
			pst.setString(8, newClass.getName());
			pst.setInt(9, 0);
			
			kq = pst.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
	
}