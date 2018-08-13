package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.TimeClass;
import model.bean.User;
import model.bo.ClassesBo;
import model.bo.UserBo;


public class GetFreeTimeInDateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public GetFreeTimeInDateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get free time get controller");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		try {
			int courseId = 0;
			if ( request.getParameter("courseId") != null) {
				courseId = Integer.parseInt(request.getParameter("courseId"));
			}
			
			UserBo userBo = new UserBo();
			ArrayList<User> traniers = userBo.getTrainerByIdCourse(courseId);
			
			String result = " <div> <br/> " 
							+" <label class='required' ><strong>Trainer:</strong>&nbsp;:</label>";
			
			if (traniers.size() > 0) {
				result +=  " <select name='trainer' id='trainerSelect' style='width: 100%'> <option onclick='showRoom();' value='0'>Select trainer</option> ";
				for (User user : traniers) {
					System.out.println("tranier: " + user.getUsername());
					result += " <option onclick='showRoom();' value='" + user.getUserId() +"'>" + user.getUsername() + " (" + user.getAbility().getExperience() + " years experience)</option>";
					
				}
				result += " </select> ";
			} else {
				result += " <br/> <span style='color: red;'> Can not find the trainer meet this requirement</span>";
			}
			result += "</div> <span id='spnTrainerStatus'></span>  ";
			
			out.println(result);
				
		} catch ( Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		System.out.println("free time post controller");
		try {
			int duration = 1;
			int roomId = 1;
			int trainerId = 0;
			ArrayList<String> dayOfWeek = new ArrayList<>();
			
			if ( request.getParameter("duration") != null) {
				String durationStr = request.getParameter("duration");
				duration = Integer.parseInt(durationStr.substring(8));
			}
			
			if ( request.getParameter("trainer") != null) {
				trainerId = Integer.parseInt(request.getParameter("trainer"));
			}
			
			if ( request.getParameter("roomId") != null) {
				roomId = Integer.parseInt(request.getParameter("roomId"));
				System.out.println("room id = " + roomId);
			}
			
			if ( request.getParameter("daySend") != null) {
				String days = request.getParameter("daySend");
				String[] dayArr = days.split(",");
				
				if(dayArr.length <= 1) {
					dayOfWeek.add("0");
				} else {

					for (String string : dayArr) {
						dayOfWeek.add(string);
					}
				}
			}
			
			
			ClassesBo classBo = new ClassesBo();
			ArrayList<TimeClass> times = classBo.getFreeTimeInDay(duration, dayOfWeek, roomId, trainerId);
			
			String timeclass = "<label class='required' ><strong>Time:</strong>&nbsp;</label> <br/>" ;
			
			if (times.size() > 0) {

				for (TimeClass timeClass : times) {
					System.out.println("time : " + timeClass.getTimeOfDate());
					timeclass += "<input type='radio' onclick='hideErrorTime();' name='time' value='" + timeClass.getTimeOfDate() + "' /> " + timeClass.getTimeOfDate() + "<br/>" ;
				}
				
			} else {
				timeclass += "<span style='color: red;'> All hours are busy</span> <br/>";
			}

			timeclass += "<span id='spnTimeStatus'></span>";
			timeclass += " </div>";
			
			out.println(timeclass);
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
