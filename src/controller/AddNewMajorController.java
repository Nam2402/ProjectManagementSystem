package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Majors;
import model.bo.MajorBo;

@WebServlet("/major/add")
public class AddNewMajorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddNewMajorController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Majors major = new Majors(0, request.getParameter("name"));
		
		
		MajorBo majorBo = new MajorBo();
		if(majorBo.checkMajorNameAlreadyExists(request.getParameter("name"))){
			
			response.sendRedirect(request.getContextPath() + "/major?msg=5");
		}
		else{
			majorBo.addMajor(major);
			
			response.sendRedirect(request.getContextPath() + "/major?msg=1");
			
		}
	}
}