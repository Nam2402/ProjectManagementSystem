 package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Rooms;
import model.bo.RoomBo;

/**
 * Servlet implementation class EditRoomController
 */
@WebServlet("/EditRoomController")
public class EditRoomController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		RoomBo roomBo = new RoomBo();
		
		int roomId = Integer.parseInt(request.getParameter("id"));
		Rooms room = roomBo.getOneRoom(roomId);
		room.setName(request.getParameter("name"));
		
		room.setCapacity( Integer.parseInt(request.getParameter("capacity")));
		room.setStatus(Integer.parseInt(request.getParameter("status")));
		

		if (roomBo.checkRoomNameAlreadyExistsEdit(request.getParameter("name"), roomId)) {
			request.setAttribute("room", room);
			response.sendRedirect(request.getContextPath() + "/room?msg=1");
			}
		else {
			request.setAttribute("room", room);
			roomBo.editRooms(room);
			response.sendRedirect(request.getContextPath() + "/room?msg=3");
		}

	}
}