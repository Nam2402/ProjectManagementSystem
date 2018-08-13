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
 * Servlet implementation class RoomListController
 */
@WebServlet("/room")
public class RoomListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	    RoomBo roomBo = new RoomBo();
		ArrayList<Rooms> roomlist = roomBo.getRooms();
		request.setAttribute("roomList", roomlist);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/rooms/RoomList.jsp");
		rd.forward(request, response);
		return;
		}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}