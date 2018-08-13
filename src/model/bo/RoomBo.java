package model.bo;

import java.io.File;
import java.util.ArrayList;

import model.bean.Rooms;
import model.bean.User;
import model.dao.RoomDao;
import model.dao.UserDao;

public class RoomBo {
	
RoomDao roomDao;

	
	public void addRooms(Rooms rooms){
		RoomDao roomDao = new RoomDao();
		
		roomDao.addRoom(rooms);
	}
	
	public void editRooms(Rooms rooms){
		RoomDao roomDao = new RoomDao();
		
		roomDao.editRoom(rooms);
	}
	
	public Rooms getOneRoom(int roomId){
		roomDao = new RoomDao();
		return roomDao.getOneRoom(roomId);
	}
	
	public boolean checkRoomNameAlreadyExists(String name) {
		roomDao = new RoomDao();
		ArrayList<Rooms> rooms = roomDao.getRooms();
		
		for(Rooms room: rooms){
			if(room.getName().equals(name)){
				return true;
			}
		}
		return false;
	}
	public ArrayList<Rooms> getRooms(){
		roomDao = new RoomDao();
		return roomDao.getRooms();
	}
	
	public ArrayList<Rooms> getRoomsEnable(){
		roomDao = new RoomDao();
		return roomDao.getRoomsEnable();
	}
	
	public boolean checkRoomNameAlreadyExistsEdit(String roomName, int roomId) {
		roomDao = new RoomDao();
		ArrayList<Rooms> rooms = roomDao.getRooms();
		
		for (Rooms room: rooms) {
			if(room.getRoomId() != roomId && room.getName().equals(roomName)) {
				return true;
			}
		}
		return false;
	}

	public int deleteRooms(int roomId) {
		roomDao = new RoomDao();
		return roomDao.deleteRoom(roomId);
	}
}