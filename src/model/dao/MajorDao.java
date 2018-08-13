package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.Majors;

public class MajorDao {

	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ArrayList<Majors> getMajors(){
		ArrayList<Majors> majors= new ArrayList<>();
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql= "select * from majors";
			pst= conn.prepareStatement(sql);
			rs= pst.executeQuery();
			while(rs.next()){
				Majors major= new Majors(rs.getInt("major_id"), rs.getString("name"));
				majors.add(major);
			}
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		return majors;
	}
	
	public Majors getMajorById(int majorId){
		conn = ConnectDBLibrary.getConnection();
		Majors major = new Majors();
		try {
			String sql = "select u.* from majors u where u.major_id=?";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, majorId);
			rs = pst.executeQuery();
			while (rs.next()) {
				String majorName = rs.getString("name");
				major = new Majors(majorId, majorName);

			}

		} catch (SQLException e) {
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return major;
	
	}
	
	public Majors getOneMajor(int majorId){
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		Majors oneMajor = new Majors();
		try{
			String sql = "select * from majors where major_id=?";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, majorId);
			rs = pst.executeQuery();
			while (rs.next()){
				oneMajor.setMajorId(majorId);
				oneMajor.setName(rs.getString(2));
			}
			
		}catch (SQLException e) {
			System.out.println(e);
		}finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return oneMajor;
	}
	
	public int editMajor(Majors majors) {
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql = "update majors set name=? where major_id=?";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, majors.getName());
			pst.setInt(2, majors.getMajorId());
			
			kq = pst.executeUpdate();
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
	
	public int deleteMajor(int majorId) {
		
		int kq = 0;
		
		String sql = "delete from majors where major_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, majorId);
			kq = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return kq;
	}
	
	public int addMajor(Majors majors){
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql = "insert into majors value(0,?)";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, majors.getName());
			
			kq = pst.executeUpdate();
		}
		catch(SQLException e){
			System.out.println(e);
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
}
