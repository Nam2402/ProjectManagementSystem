package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Majors;
import model.bean.Roles;
import model.bean.User;
import model.bo.MajorBo;
import model.bo.RoleBo;
import model.bo.MajorBo;

@WebServlet("/major/del")
public class DeleteMajorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteMajorController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				try {
					MajorBo majorBo = new MajorBo();
					
					int majorId = 0;
					if(request.getParameter("id") != null) {
						majorId = Integer.parseInt(request.getParameter("id"));
					}
					
					Majors major = majorBo.getMajorById(majorId);
					if ( majorBo.deleteMajor(majorId) != 0) {
							response.sendRedirect( request.getContextPath() + "/major?msg=3");
							return;
						} else {
							response.sendRedirect( request.getContextPath() + "/major?msg=0");
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
			MajorBo majorBo = new MajorBo();

			ArrayList<Majors> majors = majorBo.getMajors();
			int majorId = 0;
			for (Majors major2 : majors) {
				if("major".equalsIgnoreCase(major2.getName())) {
					majorId = major2.getMajorId();
				}
			}
			
			int result = 0;
			ArrayList<Majors> majors1 = majorBo.getMajors();
			for (Majors major : majors1) {
				if ( request.getParameter("major" + major.getMajorId()) != null) {   
						if ( majorBo.deleteMajor(major.getMajorId()) > 0) {
							result++;
						}
					}
				}
			
			if (result > 0) {
				response.sendRedirect( request.getContextPath() + "/major?msg=4");
				return;
			} else {
				response.sendRedirect( request.getContextPath() + "/major?msg=0");
				return;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}