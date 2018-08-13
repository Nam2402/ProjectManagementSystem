package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.RequestTakDayOff;
import model.bo.NotificationBo;
import model.bo.RequestTakeDateOffBo;

/**
 * Servlet implementation class ApproveRequestOffTrainerAjax
 */
@WebServlet("/ApproveRequestOffTrainerAjax")
public class ApproveRequestOffTrainerAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApproveRequestOffTrainerAjax() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			RequestTakeDateOffBo requestTakeDateOffBo = new RequestTakeDateOffBo();
			int request_id = Integer.parseInt(request.getParameter("request_id"));
			RequestTakDayOff dayOff = requestTakeDateOffBo.getRequestByID(request_id);
			if (dayOff.getStatus()==1){
				out.print("Nothing do!");
			} else{
				int kq = requestTakeDateOffBo.changeStatusRequestTakeDayOff(request_id, 1);
				if(kq>0){
					NotificationBo notificationBo = new NotificationBo();
					int countMessageSendTrainee = notificationBo.addNotiRequestTakeDateOffToTraineeOffClass(dayOff);
					int countMessageSendTrainer = notificationBo.addNotiRequestBeApproveSendToTrainer(dayOff);
					out.println("1");
				} else {
					out.println("0");
				}
			}

		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/admin/requestTakeDateOff?msg=0");
			return;
		}
	}

}