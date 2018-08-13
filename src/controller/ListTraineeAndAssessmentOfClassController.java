package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Accessment;
import model.bean.Results;
import model.bo.ClassesBo;
import model.bo.LearningBo;
import model.bo.ResultBo;
import model.bo.UserBo;

@WebServlet("/trainer/list")
public class ListTraineeAndAssessmentOfClassController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBo  userBo = new UserBo();
		
		int id = Integer.parseInt((String) request.getParameter("class_id"));
		String name = (String) request.getParameter("name");
		ArrayList<Accessment> listUser = userBo.getTraineeClass(id);
		ArrayList<Accessment> listResult = userBo.getResult(id);
		
		boolean clas = userBo.compareDuration(id);
		int assessment ;
		if(clas==true){
			assessment =1;
		} else{
		    assessment =0;
		}
		int check  = 0;
		if ( request.getParameter("check") !=null) {
			
			check = Integer.parseInt(request.getParameter("check"));
			request.setAttribute("listResult", listResult);
			
		} else {
			
			request.setAttribute("listUser", listUser);
			}
		
		request.setAttribute("id", String.valueOf(id));
		request.setAttribute("name", name);	
		request.setAttribute("assessment", String.valueOf(assessment));
		request.setAttribute("check", String.valueOf(check));
		
		RequestDispatcher rd=request.getRequestDispatcher("/admin/trainer/listtraineeofClass.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ResultBo resultBo = new ResultBo();
		ClassesBo classBo = new ClassesBo();
		LearningBo learningBo = new LearningBo();
		UserBo  userBo = new UserBo();
		int resultInsert = 0;
		int check;
		int resultOfTrainee = 0;
		
		int classId = Integer.parseInt(request.getParameter("class_id"));
		ArrayList<Accessment> trainees = userBo.getTraineeClass(classId);
		request.setAttribute("class_id", classId);
		String name= classBo.getNameClass(classId);
		System.out.println(name);
		request.setAttribute("name", name);	
		
		for (Accessment trainee : trainees) {
			String nametraineeIdRadio =  "trainee" + String.valueOf(trainee.getUserid());
			if (request.getParameter( nametraineeIdRadio ) != null){
				resultOfTrainee = Integer.parseInt((String) request.getParameter(nametraineeIdRadio));
				
				System.out.println(resultOfTrainee);
				Results result = new Results(0, classId, trainee.getUserid(), resultOfTrainee);
				if ( resultBo.updateResult(result) > 0) {
					resultInsert++;
				}	
			}
		}
		if(resultInsert == trainees.size()){
			check=1;
			learningBo.deleteClass(classId);
			classBo.updateStatusClass(classId);
			response.sendRedirect(request.getContextPath() + "/trainer/list?class_id=" + classId + "&name=" + name + "&check=" + check);
			return;
		} else {
			check = 0;
			
			response.sendRedirect(request.getContextPath() + "/trainer/list?class_id=" + classId + "&name=" + name + "&check=" + check);
			return;
		}
	}

}