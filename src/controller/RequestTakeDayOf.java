package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Classes;
import model.bean.TimeLearning;
import model.bean.User;
import model.bo.LearningBo;
import model.dao.LearningDao;

/**
 * Servlet implementation class RequestTakeDayOf
 */
@WebServlet("/trainer/RequestTakeDayOf")
public class RequestTakeDayOf extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestTakeDayOf() {
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
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
//		int classId = Integer.parseInt(request.getParameter("class_id"));
		String anotherday = request.getParameter("dayinstead");
		String date[] = anotherday.split("-");
		String dayinstead[] = date[0].split(",");
		String id = date[1];
		int classId = Integer.parseInt((String)(id));
		String Date="";
		switch(dayinstead[0]){
		 
		 case "Mon":
		 {
			 Date+="2";
			 break;
		 }
		 case "Tue":
		 {
			 Date+="3";
			break;
		 }
		 case "Wed":
		 {
			 Date+="4";
			break;
		 }
		case "Thu":
		 {
			 Date+="5";
			break;
		 }
		case "Fri":
		 {
			 Date+="6";
			break;
		 }
		case "Sat":
		 {
			 Date+="7";
			break;
		 }
		case "Sun":
		 {
			 Date+="8";
			break;
		 }
	    default:
	    {
	        
	    }
		 }
		Classes classes = new Classes();
		classes.setClassId(classId);
		LearningBo learningBo = new LearningBo();
//		ArrayList<Classes> class_other = learningBo.getClassByDate(Date);
//		if(class_other.size() >0){
//			int countClassConflict =  learningBo.checkConflictTraineeClassSameTime(classes, class_other);
//			if (countClassConflict>0) {
//				out.println("You can't choose this day because have conflict !");
//				
//			}
//		}
		ArrayList<TimeLearning> listTimeFree = learningBo.getTimeFreeOfClassInDay(classes, Date);
		if (listTimeFree.size()>0) {
			for(TimeLearning learning: listTimeFree){
				out.println("<option value='"+learning.getTimeString()+"'>"+learning.getTimeString()+"</option>");
			}
						
		}
		else {
			out.println("No select");
		}
		
		
		
	}

}
