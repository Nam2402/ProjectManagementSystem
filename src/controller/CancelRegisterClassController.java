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
import model.bean.User;
import model.bo.UserBo;


@WebServlet("/trainee/cancelClass")
public class CancelRegisterClassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelRegisterClassController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		if (CurrentUser.checkLogin(request, response)) {
//			User user = CurrentUser.getUserCurrent(request, response);
//			if (user.getRoleId() == 2) {
//				response.setContentType("text/plain");
//				PrintWriter out = response.getWriter();
//				int classWantCancel_id = Integer.valueOf((String) request.getParameter("classOpening_id"));					
//				UserBo userBo = new UserBo();
//				userBo.deleteRegisterClass(user.getUserId(), classWantCancel_id);
//				ArrayList<ClassWaiting> listClassWaiting  = userBo.getClassWaitingStartOfTrainee(user.getUserId());
//				int count=0;
//				for (ClassWaiting classWaiting: listClassWaiting){
//					count++;				
//					out.println("<tr class='contentPage'>"
//				    +"<td class='no'>"+ count +"</td>"
//				    +"<td class='name'>"+ classWaiting.getClassName() +"</td>"
//				    +"<td class='time'><%= classOpening.getTimeOfDate() %></td>"
//				    +"<td class='date'><%= classOpening.getDateOfWeek() %></td>"
//				    +"<td class='duration'><%= classOpening.getDuration()%></td>"
//				    +"<td class='trainer'><%= classOpening.getTrainerName() %></td>"			
//				    +"<td class='btnRegister'>"
//				    +"<a name ='cancel' id = "<%= classOpening.getClassId() %>"   class="btn btn1" onclick="return confirm('Are you sure you want to cancel this class?')" >Cancel</a>	
//				    +"</td>"
//				    +"</tr>");
//				}
//				
//				
//			}  else {
//				response.sendRedirect(request.getContextPath() + "/badrequest");
//				return;
//			}
//		} else {
//			return;
//		}
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (user.getRoleId() == 2) {
				response.setContentType("text/plain");
				PrintWriter out = response.getWriter();
				int classWantCancel_id = Integer.valueOf((String) request.getParameter("classOpening_id"));					
				UserBo userBo = new UserBo();
				userBo.deleteRegisterClass(user.getUserId(), classWantCancel_id);
				ArrayList<ClassWaiting> listClassWaiting  = userBo.getClassWaitingStartOfTrainee(user.getUserId());
				int count=0;
				
				for (ClassWaiting classWaiting: listClassWaiting){
					
					count++;				
					out.println("<tr class='contentPage'>"
				    +"<td class='no'>"+ count +"</td>"
				    +"<td class='name'>"+ classWaiting.getClassName() +"</td>"
				    +"<td class='time'>"+ classWaiting.getTimeOfDate() +"</td>"
				    +"<td class='date'>"+ classWaiting.getDateOfWeek() +"</td>"
				    +"<td class='duration'>"+ classWaiting.getDuration()+ "</td>"
				    +"<td class='trainer'>"+ classWaiting.getTrainerName() +"</td>"			
				    +"<td class='btnRegister'>"
				    +"<button  type='button' name='cancel' class ='btncancel btn-danger cancel' id='"+ classWaiting.getClassId()+ "'>Cancel</button>"
						    +"</td>"
						    +"</tr>");
				    
				   
				}
				
				
			}  else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
	}

}