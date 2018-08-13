package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Courses;
import model.bean.User;
import model.bo.CourseBo;
import model.bo.MajorBo;
import model.bo.UserBo;

public class EditCourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCourseController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (user.getRoleId() == 3) {
				response.sendRedirect(request.getContextPath() + "/course/index");
				return;
				
			}  else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			CourseBo courseBo = new CourseBo();
			String message = "";
			int courseId = Integer.parseInt(request.getParameter("id"));
			
			Courses course = courseBo.getCourseById(courseId);
			course.setMajorId(Integer.parseInt(request.getParameter("major").trim()));
			course.setName(request.getParameter("name").trim());
			course.setDuration(Integer.parseInt(request.getParameter("duration")));
			course.setKind_of_course(Integer.parseInt(request.getParameter("kindOfCourse")));
			
			if ( courseBo.checkValidateCourse(request.getParameter("name"), request.getParameter("major"), request.getParameter("duration"), request.getParameter("kindOfCourse")) == false) {

				response.sendRedirect(request.getContextPath() + "/course/index?msg=7");
				return;
				
			} else if (courseBo.checkCourseAlreadyExistsEdit(request.getParameter("name"), courseId) == true) {

				response.sendRedirect(request.getContextPath() + "/course/index?msg=6");
				return;
				
			} else {
				
				if ( courseBo.editCourse(course) > 0) {
					
					response.sendRedirect(request.getContextPath() + "/course/index?msg=2");
					return;
					
				} else {

					response.sendRedirect(request.getContextPath() + "/course/index?msg=0");
					return;
				}
			}
		
		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}
	
}
