package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Courses;
import model.bean.Majors;
import model.bean.Skills;
import model.bo.CourseBo;
import model.bo.MajorBo;
import model.bo.SkillBo;


@WebServlet("/Skills")
public class ShowSkillsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ShowSkillsController() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SkillBo skillBo = new SkillBo();
		MajorBo majorBo = new MajorBo();
		List<Skills> skill = skillBo.getSkills();
		request.setAttribute("skill", skill);
		List<Majors> listMajors = majorBo.getMajors();
		request.setAttribute("listMajors", listMajors);
		/*CourseBo courseBo = new CourseBo();
		for (Majors major :listMajors){
			List<Courses> list = courseBo.getCourseByMajor(major.getMajorId());
			request.setAttribute("listCourse"+ major.getName() , list);
		}*/
		RequestDispatcher rd = request.getRequestDispatcher("/admin/skills/skills.jsp");
		rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
