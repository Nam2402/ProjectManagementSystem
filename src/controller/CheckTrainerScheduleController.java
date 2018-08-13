package controller;

import java.io.IOException;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Rooms;
import model.bean.Schedule;
import model.bean.User;
import model.bo.RoomBo;
import model.bo.UserBo;


@WebServlet("/trainer/schedule")
public class CheckTrainerScheduleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckTrainerScheduleController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (CurrentUser.checkLogin(request, response)) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 1) {
				UserBo userBo = new UserBo();
				RoomBo roomBo = new RoomBo();
				String user_id = (String) request.getParameter("user_id");
				request.setAttribute("user_id", user_id);
				int id = Integer.parseInt(user_id);
				System.out.println(user_id);
				
				ArrayList<Schedule> schedule = userBo.getTrainerSchedule(id);
				request.setAttribute("schedule", schedule);
				User ur = userBo.getTrainerById(id);
				request.setAttribute("ur", ur);
				ArrayList<Rooms> rooms = roomBo.getRooms();
				request.setAttribute("rooms", rooms);
				
				RequestDispatcher rd=request.getRequestDispatcher("/admin/trainer/ScheduleOfTrainer.jsp");
				rd.forward(request, response);
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/auth/login1.jsp");
				rd.forward(request, response);
			}
		} else {
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
}