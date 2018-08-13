package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import libralies.CurrentUser;
import model.bean.Classes;
import model.bean.User;
import model.bo.NotificationBo;
import model.bo.RequestTakeDateOffBo;

/**
 * Servlet implementation class SendNotiTakedayoffToAdminController
 */
@WebServlet("/trainer/SendNotiTakedayoffToAdminController")
public class SendNotiTakedayoffToAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendNotiTakedayoffToAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	/*	int check=0;
		check = Integer.parseInt(request.getParameter("check"));
		request.setAttribute("check", String.valueOf(check));
		RequestDispatcher rd=request.getRequestDispatcher("/admin/trainer/ScheduleOfTrainer.jsp");
		rd.forward(request, response);*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response)) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 1) {
		int classId = Integer.parseInt(request.getParameter("classId"));
		String dateoff = request.getParameter("dayoff");
		String dayinstead = request.getParameter("dayinstead");
		String date [] = dayinstead.split("-");
		String datechange = date[0];
		String timechange =  request.getParameter("time");
		String name = request.getParameter("room");
		String rooms[] = name.split("-");
		String room = rooms[0];
		int roomId = Integer.parseInt((String)(rooms[1]));
		String note = request.getParameter("content");
		int userId = Integer.parseInt(request.getParameter("userId"));
		String fullname = request.getParameter("fullname");
		String classname = request.getParameter("classname");
		int admin_id=53;
		Classes classes = new Classes();
		classes.setClassId(classId);
		classes.setName(classname);
		User trainer = new User();
		trainer.setUserId(userId);
		trainer.setFullname(fullname);
		NotificationBo notificationBo = new NotificationBo();
		RequestTakeDateOffBo requestTakeDateOffBo = new RequestTakeDateOffBo();
		int numberadd = notificationBo.addRequestTakeaDayOff(dateoff, datechange, timechange, classes, trainer, roomId, note );
		int idRequest = requestTakeDateOffBo.getIdOfRequestNearest();
		if(idRequest!=0){
			int notification = notificationBo.addNotiTakedayoffS(dateoff, datechange, timechange,room, classes, trainer, admin_id , idRequest, note);
			String success = "1";
			 HttpSession session = request.getSession();
		     session.setAttribute("success", success);
			response.sendRedirect(request.getContextPath() + "/trainer/schedule?user_id=" + userId);
			
		}
			} else {
				
			}
		} else {
			
		}
	
		
	}

}