package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bo.CourseBo;
import model.bo.MajorBo;
import model.bo.UserBo;


public class IndexCourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexCourseController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {


				CourseBo courseBo = new CourseBo();
				MajorBo majorBo = new MajorBo();
				
				request.setAttribute("majors", majorBo.getMajors());
				request.setAttribute("courses", courseBo.getCourses());
				
				RequestDispatcher rd = request.getRequestDispatcher("/admin/course/index.jsp");
				rd.forward(request, response);
				
			} else {
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
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			int status = 1 - Integer.parseInt(request.getParameter("status"));
			
			CourseBo courseBo = new CourseBo();

			PrintWriter out = response.getWriter();
			if (courseBo.changeStatusCourse(courseId, status) > 0 && status == 1) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + courseId + ", 1);'><img alt='' src='" + request.getContextPath() + "/templates/images/active.gif'></a>");
			} else if  (courseBo.changeStatusCourse(courseId, status) > 0 && status == 0) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + courseId + ", 0);'><img alt='' src='" + request.getContextPath() + "/templates/images/deactive.gif'></a>");
			}
		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/course/index?msg=0");
			return;
		}
	}

}
