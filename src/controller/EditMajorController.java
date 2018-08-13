package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Majors;
import model.bo.MajorBo;

@WebServlet("/major/edit")
public class EditMajorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public EditMajorController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MajorBo majorBo = new MajorBo();
		
		int majorId = Integer.parseInt(request.getParameter("id"));
		Majors major = majorBo.getOneMajor(majorId);
		major.setName(request.getParameter("name"));
		
		if(majorBo.checkMajorNameAlreadyExistsEdit(request.getParameter("name"), majorId)){
			request.setAttribute("major", major);
			response.sendRedirect(request.getContextPath() + "/major?msg=6");
		}
		else {
			request.setAttribute("major", major);
			majorBo.editMajors(major);
			response.sendRedirect(request.getContextPath() + "/major?msg=2");
		}
		
		
	}

}