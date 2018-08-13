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
import model.bean.MyMessages;
import model.bean.User;
import model.bo.NotificationBo;
import model.bo.UserBo;
import model.dao.NotificationDao;

/**
 * Servlet implementation class ListDetailNotification
 */
@WebServlet("/trainee/listDetailNoti")
public class ListDetailNotification extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
	private NotificationBo notificationBo; 
    public ListDetailNotification() {
        super();
        userBo =new UserBo();
        notificationBo = new NotificationBo();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response)!=null) {
				User user = CurrentUser.getUserCurrent(request, response);
				
				int user_id = user.getUserId();
				ArrayList<MyMessages> list = userBo.getMessagesOfTrainee(user.getUserId());	
				int countchangeStatus = notificationBo.changeStatusAllMessagesOfUser(user_id);
				request.setAttribute("list", list);
				RequestDispatcher rd=request.getRequestDispatcher("/admin/trainees/viewAllNoti.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}