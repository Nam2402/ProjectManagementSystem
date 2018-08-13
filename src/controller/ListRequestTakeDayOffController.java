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
import model.bean.RequestTakDayOff;
import model.bean.Roles;
import model.bo.NotificationBo;
import model.bo.RequestTakeDateOffBo;
import model.bo.RoleBo;
import model.bo.UserBo;

/**
 * Servlet implementation class ListRequestTakeDayOffController
 */
@WebServlet("/admin/requestTakeDateOff")
public class ListRequestTakeDayOffController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ListRequestTakeDayOffController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				RequestTakeDateOffBo requestTakeDateOffBo = new RequestTakeDateOffBo();
				ArrayList<RequestTakDayOff> listRequests = new ArrayList<>();
				listRequests = requestTakeDateOffBo.getRequestTakeaDayOffs();				
				request.setAttribute("listRequests", listRequests);
				RequestDispatcher rd = request.getRequestDispatcher("/admin/requests/index2.jsp");
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
		int request_id = Integer.parseInt(request.getParameter("request_id"));
		PrintWriter out = response.getWriter();

		try {
			request_id = Integer.parseInt(request.getParameter("request_id"));
			int status = Integer.parseInt(request.getParameter("status"));
			if (status==1){
				out.println("<a ><img alt='' src='" + request.getContextPath() + "/templates/images/active.gif'></a>");
			} else{
				RequestTakeDateOffBo requestTakeDateOffBo = new RequestTakeDateOffBo();
				int kq = requestTakeDateOffBo.changeStatusRequestTakeDayOff(request_id, status);
				if(kq>0){
					NotificationBo notificationBo = new NotificationBo();
					RequestTakDayOff dayOff = new RequestTakDayOff();
 					dayOff = requestTakeDateOffBo.getRequestByID(request_id);
					int countMessageSendTrainee = notificationBo.addNotiRequestTakeDateOffToTraineeOffClass(dayOff);
					int countMessageSendTrainer = notificationBo.addNotiRequestBeApproveSendToTrainer(dayOff);
					out.println("<a  ><i class='fa fa-check' style='font-size:20px; color: #106aef'></i></a>");
				} else {
					out.println("<a href='javascript:void(0)' onclick='changeStatus(" + request_id + ", 0);'><img alt='' src='" + request.getContextPath() + "/templates/images/deactive.gif'></a>");
				}
			}

		} catch( Exception e) {
			System.out.println(e.getMessage());
			out.println("<a href='javascript:void(0)' onclick='changeStatus(" + request_id + ", 0);'><img alt='' src='" + request.getContextPath() + "/templates/images/deactive.gif'></a>");
			return;
		}
	}

}