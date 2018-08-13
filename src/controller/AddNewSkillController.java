package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.Skills;
import model.bo.SkillBo;


@WebServlet("/AddNewSkillController")
public class AddNewSkillController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddNewSkillController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SkillBo skillBo = new SkillBo();
		int majorId = Integer.parseInt(request.getParameter("majorId"));
		Skills skill = new Skills(0, request.getParameter("name"), majorId, Integer.parseInt(request.getParameter("status")));
		
		
		
		if(skillBo.checkSkillNameAlreadyExists(request.getParameter("name"))){
			
			response.sendRedirect(request.getContextPath() + "/Skills?msg=1");
		}
		else{
			skillBo.addSkill(skill);
			
			response.sendRedirect(request.getContextPath() + "/Skills?msg=2");
			
		}
	}

}
