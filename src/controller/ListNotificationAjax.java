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
import model.bean.MyMessages;
import model.bean.Roles;
import model.bean.User;
import model.bo.RoleBo;
import model.bo.UserBo;

/**
 * Servlet implementation class ListNotificationAjax
 */
@WebServlet("/ListNotificationAjax")
public class ListNotificationAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListNotificationAjax() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		ArrayList<MyMessages> listMessage = new ArrayList<>();
//		listMessage = userBo.getMessagesOfTrainee(4);
//		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (CurrentUser.getUserCurrent(request, response).getRoleId() !=0 ) {
				
				response.setContentType("text/plain");
				ArrayList<MyMessages> listMsg = new ArrayList<>();
				if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {
					listMsg =  userBo.getMessagesOfAdmin(user.getUserId());

				} else {
					listMsg =  userBo.getMessagesOfTrainee(user.getUserId());

				}
				PrintWriter out = response.getWriter();
				int countrows =0 ;		
				if (listMsg.size()!=0) {
					out.print("<li><strong  style='color: #2e9ade;padding:5px 10px 5px;'>Notification"+"   ("+listMsg.size()+")</strong></li> ");
					
				
					for (MyMessages myMessages: listMsg){
						countrows++;
						if (countrows==5) {
							break;
						}
						String content = myMessages.getNotiContent().substring(0,15);
						content+="...";
						
						
						if(myMessages.getStatus()==0){
							out.print("<li style='background-color: rgb(212, 237, 218)'>"
									+ "<a style='text-decoration:none'>"
											+ "<span style='font-size:15px; font-weight:bold; color:#343a40;' class='message'>"
											+ myMessages.getTitle()
											+ " </span>"
											+ "<span style='line-height:20px;' class='message'>"
													+ content
													+ " </span>"
													+"<button style='margin-top:5px; float:right;' type='button' name='view' class = 'btn btn-primary view' id='"+myMessages.getMsgId()+"'>Detail</button>" 

													+ "</a>"
													+ "</li>");
							}
						else {
							out.print("<li><a style='text-decoration:none' >"
											+ "<span style='font-size:15px; font-weight:bold; color:#343a40;' class='message'>"
											+ myMessages.getTitle()
											+ " </span>"
											+ "<span style='line-height:20px;' class='message'>"
													+ content
													+ " </span>"
													+"<button style='margin-top:5px;float:right;'type='button' name='view' class = 'btn btn-primary view' id='"+myMessages.getMsgId()+"'>Detail</button>" 

													+ "</a></li>");
						}
						
					}
					out.println(" <li>"
							+ "<div class='text-center'>"
									+ "<a href='/managementSystem/trainee/listDetailNoti'>"
									+ "<strong style='font-size: 15px; color:#2e9ade; '>See All Notification</strong>"
									+ " <i style='color:#2e9ade' class='fa fa-angle-right'></i>"
											+ "</a>"
											+ "</div></li>");
				
				}
				else {
					out.println("<li>No New Notification</li>");
				}
				
				
				
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
		
	}
}