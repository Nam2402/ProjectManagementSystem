package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.User;
import model.bo.NotificationBo;

@WebServlet("/CountNotificationController")
public class CountNotificationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CountNotificationController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			NotificationBo notificationBo = new NotificationBo();
			PrintWriter printWriter = response.getWriter();
			int numberNotification = notificationBo.countNotificationNewById(user.getUserId());
			printWriter.println( "<b>" + numberNotification + "</b>");		
			
		} else {
			response.sendRedirect(request.getContextPath() + "/badrequest");

			return;
		}
	}


}
