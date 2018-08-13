package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.Classes;
import model.bean.RequestTakDayOff;
import model.bean.User;

public class RequestTakeDateOffDao {
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	public int addRequestTakeaDayOff(String dateoff, String datechange,  String timechange , Classes classes , User trainer, int room_id){
		conn = ConnectDBLibrary.getConnection();
		int kq = 0;
		try{
			String sql= "insert into requestDayOff values(0,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classes.getClassId());
			pst.setInt(2, trainer.getUserId());
			pst.setString(3, dateoff);
			pst.setString(4, datechange );
			pst.setString(5, timechange);
			pst.setInt(6, room_id);
			pst.setInt(7, 0);
			
			kq=pst.executeUpdate();
			
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
	
	public int changeStatusRequestTakeDayOff(int request_id, int status){
		int kq=0;
		conn=ConnectDBLibrary.getConnection();
		String sql = "UPDATE requestDayOff SET status = 1 WHERE request_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, request_id);
			kq = pst.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		} 
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
		
	}
	
	public ArrayList<RequestTakDayOff> getRequestTakeaDayOffs(){
		ArrayList<RequestTakDayOff> listRequest = new ArrayList<>();
		String sql = "select request_id,requestDayOff.class_id,  classes.name, users.fullname, date_off, date_change,time_change,"
				+ " rooms.name, requestDayOff.status from requestDayOff inner join classes "
				+ "on classes.class_id = requestDayOff.class_id "
				+ "inner join rooms on rooms.room_id = requestDayOff.room_id inner join users on users.user_id = requestDayOff.trainer_id where requestDayOff.status = 0  order by requestDayOff.request_id DESC  ;";
		
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);			
			rs = pst.executeQuery();
			while(rs.next()) {
				RequestTakDayOff  requestTakDayOff = new RequestTakDayOff();
				requestTakDayOff.setRequest_id(rs.getInt("request_id"));
				requestTakDayOff.setClass_id(rs.getInt("class_id"));
				requestTakDayOff.setClass_name(rs.getString("name"));
				requestTakDayOff.setTrainer_name(rs.getString("fullname"));
				requestTakDayOff.setDate_off(rs.getString("date_off"));
				requestTakDayOff.setDate_change(rs.getString("date_change"));
				requestTakDayOff.setTime_change(rs.getString("time_change"));
				requestTakDayOff.setRoom_name(rs.getString("name"));
				requestTakDayOff.setStatus(rs.getInt("status"));
				listRequest.add(requestTakDayOff);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return listRequest;
	}
	
	public RequestTakDayOff  getRequestByID(int request_id){
		RequestTakDayOff requestTakDayOff = new RequestTakDayOff();
		String sql = "select request_id,requestDayOff.class_id,  classes.name , requestDayOff.trainer_id, users.fullname, date_off, date_change,time_change,"
				+ " rooms.name as nameroom, requestDayOff.status ,requestDayOff.note  from requestDayOff inner join classes "
				+ "on classes.class_id = requestDayOff.class_id "
				+ "inner join rooms on rooms.room_id = requestDayOff.room_id inner join users on users.user_id = requestDayOff.trainer_id where request_id = ? ;";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, request_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				requestTakDayOff.setRequest_id(rs.getInt("request_id"));
				requestTakDayOff.setClass_id(rs.getInt("class_id"));
				requestTakDayOff.setClass_name(rs.getString("name"));
				requestTakDayOff.setTrainer_id(rs.getInt("trainer_id"));
				requestTakDayOff.setTrainer_name(rs.getString("fullname"));
				requestTakDayOff.setDate_off(rs.getString("date_off"));
				requestTakDayOff.setDate_change(rs.getString("date_change"));
				requestTakDayOff.setTime_change(rs.getString("time_change"));
				requestTakDayOff.setRoom_name(rs.getString("nameroom"));
				requestTakDayOff.setStatus(rs.getInt("status"));
				requestTakDayOff.setNote(rs.getString("note"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return requestTakDayOff;
	}
	public int getIdOfRequestNearest(){
		int kq=0;
		String sql = "select * from requestDayOff order by request_id desc limit 1;";
		conn = ConnectDBLibrary.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while(rs.next()) {
				return rs.getInt("request_id");
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
}