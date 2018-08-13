package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import libralies.FormatDateLibrary;
import model.bean.Classes;
import model.bean.Rooms;
import model.bo.ClassesBo;
import model.bo.CourseBo;
import model.bo.MajorBo;
import model.bo.RoomBo;
import model.bo.UserBo;


public class AddClassesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddClassesController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(CurrentUser.checkLogin(request, response) == true) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {
				
				ClassesBo classBo = new ClassesBo();
				MajorBo majorBo =  new MajorBo();
				CourseBo courseBo = new CourseBo();
				UserBo userBo = new UserBo();
				RoomBo roomBo = new RoomBo();
				
				ArrayList<String> days = new ArrayList<>();
				days.add("2");
				ArrayList<Rooms> rooms = roomBo.getRoomsEnable();
				
				request.setAttribute("majors", majorBo.getMajors());
				request.setAttribute("courses", courseBo.getCoursesAnable());
				request.setAttribute("rooms", rooms);

				RequestDispatcher rd = request.getRequestDispatcher("/admin/classes/add.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		}else {
			return;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String className = request.getParameter("name").trim();
			int courseId = Integer.parseInt(request.getParameter("course").trim());
			int trainerId = Integer.parseInt(request.getParameter("trainer").trim());
			int roomId = Integer.parseInt(request.getParameter("room").trim());
			String dateOfWeek = "";
			String[] days = {"monday", "tuesday", "wednesday", "thursday", "friday"};
			for (String string : days) {
				if ( request.getParameter(string) != null) {
					dateOfWeek += request.getParameter(string) + ",";
				}
			}
			String timeOfDate = request.getParameter("time").trim();
			
			Classes newClass = new Classes(0, courseId, trainerId, FormatDateLibrary.ConvertDateUntilToDateSQL(new Date()), timeOfDate, dateOfWeek, 0, roomId, 0, className);
			ClassesBo classBo = new ClassesBo();
			
			if(classBo.checkClassAlreadyExists(className) == true) {

				request.setAttribute("class", newClass);
				RequestDispatcher rd = request.getRequestDispatcher("/admin/classes/add.jsp");
				rd.forward(request, response);
			} else {

				if (classBo.addClass(newClass) > 0) {

					response.sendRedirect(request.getContextPath() + "/classes/index?msg=1");
					return;
					
				} else {
					
					request.setAttribute("class", newClass);
					RequestDispatcher rd = request.getRequestDispatcher("/admin/classes/add.jsp");
					rd.forward(request, response);
				}
			}
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
		}
	}

}
