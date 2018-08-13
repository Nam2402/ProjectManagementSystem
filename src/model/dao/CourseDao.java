package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import libralies.ConnectDBLibrary;
import model.bean.Courses;

public class CourseDao {

	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ArrayList<Courses> getCourses() {
		ArrayList<Courses> courses = new ArrayList<>();
		
		conn = ConnectDBLibrary.getConnection();
		String sql = "select course_id, majors.major_id as major_id, duration, courses.status, courses.name , courses.kind, majors.name as major_name from courses " + 
						"inner join majors on courses.major_id = majors.major_id order by courses.course_id desc";
		
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Courses course = new Courses(rs.getInt("course_id"), rs.getInt("major_id"), rs.getString("name"), rs.getInt("duration"), rs.getInt("status"), 
								rs.getString("major_name"), rs.getInt("kind"));
				courses.add(course);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		
		return courses;
	}

	public int changeStatusCourse(int courseId, int status) {
		int kq = 0;
		
		String sql = "update courses set status = ? where course_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, status);
			pst.setInt(2, courseId);
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}

	public int addCourse(Courses course) {
		int kq = 0;
		
		String sql = "INSERT INTO courses(major_id, name, duration, kind) values(?, ?, ?, ?)";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, course.getMajorId());
			pst.setString(2, course.getName());
			pst.setInt(3, course.getDuration());
			pst.setInt(4, course.getKind_of_course());
			
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}

	public Courses getCourseById(int courseId) {
		Courses course = new Courses();
		String sql = "select * from courses where course_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, courseId);
			rs = pst.executeQuery();
			
			while ( rs.next()) {
				course = new Courses(rs.getInt("course_id"), rs.getInt("major_id"), rs.getString("name"), rs.getInt("duration"), rs.getInt("status"), rs.getInt("kind"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return course;
	}

	public int editCourse(Courses course) {
		int kq = 0;
		
		String sql = "update courses set major_id = ?, name = ?, duration = ?, kind = ? where course_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, course.getMajorId());
			pst.setString(2, course.getName());
			pst.setInt(3, course.getDuration());
			pst.setInt(4, course.getKind_of_course());
			pst.setInt(5, course.getCourseId());
			
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}
	
	public int edleteCourse(int courseId) {
		int kq = 0;
		
		String sql = "delete from courses where course_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, courseId);
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}
	
// Kenton
	public List<Courses> getListCourseNameByMajor(int majorId){
		List<Courses> courses = new ArrayList<>();
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql = "select course_id, name from courses where major_id=?";
			pst= conn.prepareStatement(sql);
			pst.setInt(1, majorId);
			rs= pst.executeQuery();
			while(rs.next()){
				Courses list = new Courses();
				list.setCourseId(rs.getInt("course_id"));
				list.setName(rs.getString("name"));
				courses.add(list);
			}
		}
		catch (SQLException e){
			System.out.println(e.getMessage());
		}
		return courses;
	}

	public ArrayList<Courses> getCoursesAnable() {
		ArrayList<Courses> courses = new ArrayList<>();
		
		conn = ConnectDBLibrary.getConnection();
		String sql = "select course_id, majors.major_id as major_id, duration, courses.status, courses.name , courses.kind, majors.name as major_name from courses " + 
						"inner join majors on courses.major_id = majors.major_id where courses.status = 1 order by courses.course_id desc";
		
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while (rs.next()) {
				Courses course = new Courses(rs.getInt("course_id"), rs.getInt("major_id"), rs.getString("name"), rs.getInt("duration"), rs.getInt("status"), 
								rs.getString("major_name"), rs.getInt("kind"));
				courses.add(course);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		
		return courses;
	}

}