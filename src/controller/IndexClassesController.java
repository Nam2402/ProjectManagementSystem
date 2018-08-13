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
import model.bean.Classes;
import model.bo.ClassesBo;


public class IndexClassesController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IndexClassesController() {
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(CurrentUser.checkLogin(request, response) == true) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {
				
				ClassesBo classBo = new ClassesBo();
				request.setAttribute("classesWait", classBo.getClasseseWaiting());
				request.setAttribute("classesOpen", classBo.getClasseseOpenning());
				request.setAttribute("classesFinish", classBo.getClasseseFinished());

				RequestDispatcher rd = request.getRequestDispatcher("/admin/classes/index.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		}else {
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			ClassesBo classBo = new ClassesBo();
			int classId =  Integer.parseInt(request.getParameter("classId"));
			int status = Integer.parseInt(request.getParameter("status"));
			
			if(status == 0) {
				ArrayList<Integer> traineesWaiting = classBo.getTraineeWaitingByClass(classId);
				if ( classBo.delTraieeWaitting(classId) > 0) {
					int check = 0 ;
					for (Integer integer : traineesWaiting) {
						if (classBo.addTraineeLearning(integer, classId)> 0); {
							check++;
						}
					}
					if (check < traineesWaiting.size()) {

						response.sendRedirect(request.getContextPath() + "/classes/index?msg=0");
						return;
					} else {

						status = 1;
					}
				} else {

					response.sendRedirect(request.getContextPath() + "/classes/index?msg=0");
					return;
				}
			} else {
				status = 0;
			}
			
			PrintWriter out = response.getWriter();
			if ( classBo.changeStatus(classId, status) > 0) {
				out.println("");
			}
			
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}
