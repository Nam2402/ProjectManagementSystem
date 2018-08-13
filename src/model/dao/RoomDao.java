package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;

import libralies.ConnectDBLibrary;
import model.bean.Rooms;

public class RoomDao {

RoomDao roomDao;
	
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;

	public int addRoom(Rooms rooms) {
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql = "insert into rooms value (0,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, rooms.getName());
			pst.setInt(2, rooms.getCapacity());
			pst.setInt(3, rooms.getStatus());
			
			kq = pst.executeUpdate();
		}
		catch(SQLException e){
			System.out.println(e);
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
		
	}
	
	public Rooms getOneRoom(int roomId) {
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		Rooms oneroom = new Rooms();
		try{
			String sql = "select * from rooms where room_id = ?";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, roomId);
			rs = pst.executeQuery();
			while (rs.next()) {
				oneroom.setRoomId(roomId);
				oneroom.setName(rs.getString(2));
				oneroom.setCapacity(rs.getInt(3));
				oneroom.setStatus(rs.getInt(4));
			}
			
		} catch (SQLException e) {
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return oneroom;
	}
	
	public int editRoom(Rooms rooms) {
		int kq = 0;
		conn = ConnectDBLibrary.getConnection();
		try{
			String sql = "UPDATE rooms SET name = ?, capacity = ?, status = ? WHERE room_id=?";
			
			pst = conn.prepareStatement(sql);
			pst.setString(1, rooms.getName());
			pst.setInt(2, rooms.getCapacity());
			pst.setInt(3, rooms.getStatus());
			pst.setInt(4, rooms.getRoomId());
			
			kq = pst.executeUpdate();
		}
		catch(SQLException e){
			System.out.println(e);
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
		
	}
			
	
	public ArrayList<Rooms> getRooms() {
		ArrayList<Rooms> listRooms = new ArrayList<Rooms>();
		String sql = "SELECT * from rooms";
		
		conn = ConnectDBLibrary.getConnection();
		try{
			pst = conn.prepareStatement(sql);
			
			rs = pst.executeQuery();
			while(rs.next()){
				Rooms room = new Rooms(rs.getInt("room_id"), rs.getString("name"), rs.getInt("capacity"), rs.getInt("status"));
				listRooms.add(room);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return listRooms;
		
	}

	public int deleteRoom(int roomId) {
		int kq = 0;
		
		String sql = "delete from rooms where room_id = ?";
		
		conn = ConnectDBLibrary.getConnection();
		try{
			pst = conn.prepareStatement(sql);
			pst.setInt(1, roomId);
			kq = pst.executeUpdate();
		}
		catch (SQLException e){
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
	
	public ArrayList<Rooms> getRoomsEnable() {
		ArrayList<Rooms> listRooms = new ArrayList<Rooms>();
		String sql = "SELECT * from rooms where status = 1";
		
		conn = ConnectDBLibrary.getConnection();
		try{
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			while(rs.next()){
				Rooms room = new Rooms(rs.getInt("room_id"), rs.getString("name"), rs.getInt("capacity"), rs.getInt("status"));
				listRooms.add(room);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return listRooms;
	}
		
}