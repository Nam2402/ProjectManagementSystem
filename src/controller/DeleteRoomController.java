package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Rooms;
import model.bo.RoomBo;


@WebServlet("/DeleteRoomController")
public class DeleteRoomController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			RoomBo roomBo = new RoomBo();
			
			int result = 0;
			
			List<Rooms> rooms = roomBo.getRooms();
			
			for(Rooms room: rooms){
				String roomid = (String.valueOf(room.getRoomId()));
				if(roomid.equals(request.getParameter("room" + room.getRoomId()))){
				
					roomBo.deleteRooms(room.getRoomId());
					result ++;
				
				}
			}
			if(result>0){
				response.sendRedirect(request.getContextPath() + "/room?msg=4");
				return;
			} else{
				response.sendRedirect(request.getContextPath() + "/room?msg=0");
				return;
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
	}

}
}
