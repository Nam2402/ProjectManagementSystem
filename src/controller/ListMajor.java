package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Majors;
import model.bo.MajorBo;

/**
 * Servlet implementation class MajorsController
 */
@WebServlet("/major")
public class ListMajor extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MajorBo majorBo = new MajorBo();
		ArrayList<Majors> majors = new ArrayList<>();
		majors = majorBo.getMajors();
		request.setAttribute("major", majors);
		RequestDispatcher rd = request.getRequestDispatcher("/admin/majors/index.jsp");
		rd.forward(request, response);
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}