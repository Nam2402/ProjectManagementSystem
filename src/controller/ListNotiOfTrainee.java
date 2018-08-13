package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.MyMessages;
import model.bean.Results;
import model.bo.UserBo;

/**
 * Servlet implementation class ListNotiOfTrainee
 */
@WebServlet("/trainee/listnoti")
public class ListNotiOfTrainee extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListNotiOfTrainee() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int trainee_id = Integer.valueOf((String)request.getParameter("user_id"));//lay user_id tu url 
		ArrayList<MyMessages> listMsg =  userBo.getMessagesOfTrainee(trainee_id);
		request.setAttribute("listMsg", listMsg);
		RequestDispatcher rd=request.getRequestDispatcher("/admin/trainees/listnoti.jsp");
		rd.forward(request, response);
				
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
