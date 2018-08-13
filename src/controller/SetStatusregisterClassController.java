package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bo.UserBo;

/**
 * Servlet implementation class SetStatusregisterClassController
 */
@WebServlet("/SetStatusregisterClassController")
public class SetStatusregisterClassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetStatusregisterClassController() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int trainee_id = Integer.valueOf((String) request.getParameter("user_id"));
		int class_id = Integer.valueOf((String) request.getParameter("class_id"));
		if (userBo.checkClassRegisted(trainee_id, class_id)){
			userBo.deleteRegisterClass(trainee_id, class_id);
		} else {
			userBo.registedClass(trainee_id, class_id);
		}
		response.sendRedirect("/managementSystem/ListClassOpening?user_id="+trainee_id);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}