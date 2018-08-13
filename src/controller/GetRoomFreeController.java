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
import model.bean.Rooms;
import model.bean.TimeLearning;
import model.bo.LearningBo;

/**
 * Servlet implementation class GetRoomFreeController
 */
@WebServlet("/trainer/GetRoomFreeController")
public class GetRoomFreeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRoomFreeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String dayinstead = request.getParameter("dayinstead");
		String time = request.getParameter("time");

		String Date="";
		switch(dayinstead){
		 
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
		LearningBo learningBo = new LearningBo();
		ArrayList<Rooms> listRoomFree = learningBo.getRoomFreeInTime(time, Date);
		if (listRoomFree.size()>0) {
			for(Rooms room: listRoomFree){
				out.println("<option value='"+room.getName()+"-"+room.getRoomId()+"'>"+room.getName()+"</option>");
			}
						
		}
		else {
			out.println("No Select");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
