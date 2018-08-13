package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Courses;
import model.bean.Roles;
import model.bean.User;
import model.bo.CourseBo;
import model.bo.RoleBo;
import model.bo.UserBo;

public class DeleteCourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteCourseController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				try {

					CourseBo courseBo = new CourseBo();
					
					int courseId = 0;
					if(request.getParameter("id") != null) {
						courseId = Integer.parseInt(request.getParameter("id"));
					}
					
					Courses course =  courseBo.getCourseById(courseId);
					if ( courseBo.deleteCourse(course.getCourseId()) == -1 ) {
						
						response.sendRedirect( request.getContextPath() + "/course/index?msg=5&name=" + course.getName());
						return;
						
					} else if ( courseBo.deleteCourse(courseId) > 0) {
						response.sendRedirect( request.getContextPath() + "/course/index?msg=3");
						return;
					} else {
						response.sendRedirect( request.getContextPath() + "/course/index?msg=0");
						return;
					}
				} catch (Exception e) {
					System.out.println(e.getMessage());
					response.sendRedirect(request.getContextPath() + "/badrequest");
					return;
				}
				
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			CourseBo courseBo = new CourseBo();
			
			int result = 0;
			boolean check = false;
			String name = "";
			
			ArrayList<Courses> courses = courseBo.getCourses();
			for (Courses course : courses) {
				if ( request.getParameter("course" + course.getCourseId()) != null) {    
					if ( courseBo.deleteCourse(course.getCourseId()) > 0) {
						result++;
					} else if ( courseBo.deleteCourse(course.getCourseId()) == -1) {
						name += course.getName() + " ";
						check = true;
					}
				}
			}
			
			if( check == true) {

				response.sendRedirect( request.getContextPath() + "/course/index?msg=5&name=" + name);
				return;
				
			} else {
				
				if (result > 0) {
					response.sendRedirect( request.getContextPath() + "/course/index?msg=4");
					return;
				} else {
					response.sendRedirect( request.getContextPath() + "/course/index?msg=0");
					return;
				}
				
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}
