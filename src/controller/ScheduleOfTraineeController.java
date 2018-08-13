package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.ClassWaiting;
import model.bean.Classes;
import model.bean.ScheduleOfTrainee;
import model.bean.User;
import model.bo.ClassWatingBo;
import model.bo.UserBo;

/**
 * Servlet implementation class ScheduleOfTraineeController
 */
@WebServlet("/trainee/schedule")
public class ScheduleOfTraineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo; 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScheduleOfTraineeController() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (user.getRoleId() == 2) {
				int id = user.getUserId();
				ArrayList<ScheduleOfTrainee> listClass = userBo.getClassOfTrainee(id);
				request.setAttribute("listClass", listClass);
				RequestDispatcher rd=request.getRequestDispatcher("/admin/trainees/scheduleoftrainee.jsp");
				rd.forward(request, response);		
				
			}  else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
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
		doGet(request, response);
	}

}