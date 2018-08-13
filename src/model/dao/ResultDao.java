package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;

import libralies.ConnectDBLibrary;
import model.bean.Results;
import model.bean.Schedule;


public class ResultDao {

	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public int updateResult(Results result){
		conn=ConnectDBLibrary.getConnection();
		int kq=0;
		String sql = "insert into results(status, class_id, user_id) values(?,?,?)";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, result.getStatus());
			pst.setInt(2, result.getClassId());
			pst.setInt(3, result.getUserId());
			kq = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
		
	}	
	public ArrayList<Results> getResult(int classid){
		conn=ConnectDBLibrary.getConnection();
		ArrayList<Results> result = new ArrayList<>();
		String sql = "SELECT * from results WHERE class_id=?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classid);
			rs = pst.executeQuery();
			while (rs.next()) {
				Results list = new Results();
				list.setStatus(rs.getInt("status"));
				result.add(list);
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public int numberOfResultOfCourse(int course_id, int status_result){
		int count = 0;
		conn= ConnectDBLibrary.getConnection();
		try{
			String sql= "SELECT count(*) FROM results r inner join classes c on r.class_id = c.class_id where c.course_id = ? and r.status = ? ";
			pst= conn.prepareStatement(sql);
			pst.setInt(1, course_id);
			pst.setInt(2, status_result);
			rs = pst.executeQuery();
			if(rs.next()){
				count = rs.getInt("count(*)");
			}
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return count;
	}
	public List<Results> getResultsOfCourse(int course_id, int status_result){
		List<Results> list = new ArrayList<>();
		conn= ConnectDBLibrary.getConnection();
		try{
			String sql= "SELECT r.* FROM results r inner join classes c on r.class_id = c.class_id where c.course_id = ? and r.status = ? ";
			pst= conn.prepareStatement(sql);
			pst.setInt(1, course_id);
			pst.setInt(2, status_result);
			rs = pst.executeQuery();
			while(rs.next()){
				int resultId = rs.getInt("result_id");
				int classId = rs.getInt("class_id");
				int userId = rs.getInt("user_id");
				int status = rs.getInt("status");
				Results result= new Results(resultId, classId, userId, status);
				list.add(result);
			}
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return list;
	}
	
	public List<Results> getResultsOfCourseByYear(int course_id, int status_result, String year){
		List<Results> list = new ArrayList<>();
		conn= ConnectDBLibrary.getConnection();
		try{
			String sql= "SELECT r.* FROM results r"
					+ " inner join classes c on r.class_id = c.class_id"
					+ " inner join users u on r.user_id = u.user_id "
					+ " where c.course_id = ? and r.status = ? and substring_index(u.created_at,'-',1) = ?";
			pst= conn.prepareStatement(sql);
			pst.setInt(1, course_id);
			pst.setInt(2, status_result);
			pst.setString(3, year);
			rs = pst.executeQuery();
			while(rs.next()){
				int resultId = rs.getInt("result_id");
				int classId = rs.getInt("class_id");
				int userId = rs.getInt("user_id");
				int status = rs.getInt("status");
				Results result= new Results(resultId, classId, userId, status);
				list.add(result);
			}
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return list;
	}

}