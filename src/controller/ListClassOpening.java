package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.xml.internal.ws.client.SenderException;

import libralies.CurrentUser;
import model.bean.ClassWaiting;
import model.bean.Schedule;
import model.bean.User;
import model.bo.UserBo;
import model.dao.UserDao;

/**
 * Servlet implementation class ListClassOpening
 */
@WebServlet("/ListClassOpening")
public class ListClassOpening extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListClassOpening() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User trainee = (User) session.getAttribute("user");
//		int trainee_id = Integer.valueOf((String) request.getParameter("user_id"));	
		int trainee_id = trainee.getUserId();
		ArrayList<ClassWaiting>  listClassOpening = new ArrayList<>();
		listClassOpening = userBo.getClassWaitingOpen(trainee_id);
		request.setAttribute("listClassOpening", listClassOpening);
		RequestDispatcher rd=request.getRequestDispatcher("/admin/trainees/registerClass.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int trainee_id = Integer.valueOf((String) request.getParameter("user_id"));
		int class_id = Integer.valueOf((String) request.getParameter("class_id"));
		if (userBo.checkClassRegisted(trainee_id, class_id)){
			userBo.deleteRegisterClass(trainee_id, class_id);
		} else {
			userBo.registedClass(trainee_id, class_id);
		}
		response.sendRedirect("/managementSystem/ListClassOpening?user_id="+trainee_id);
		
	}

}