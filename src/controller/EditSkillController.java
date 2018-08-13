package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Skills;
import model.bo.SkillBo;


@WebServlet("/EditSkillController")
public class EditSkillController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public EditSkillController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SkillBo skillBo = new SkillBo();
		
		int skillId = Integer.parseInt(request.getParameter("id"));
		Skills skill = skillBo.getOneSkill(skillId);
		int status = Integer.parseInt(request.getParameter("status"));
		skill.setStatus(status);
		String nameSkill = request.getParameter("name");
		
		if(nameSkill.equals(skill.getName())){
			request.setAttribute("skill", skill);
			skillBo.editSkills(skill);
			response.sendRedirect(request.getContextPath() + "/Skills?msg=3");
		}
		else{
			skill.setName(nameSkill);
			if(skillBo.checkSkillNameAlreadyExistsEdit(request.getParameter("name"), skillId)){
				request.setAttribute("skill", skill);
				response.sendRedirect(request.getContextPath() + "/Skills?msg=1");
			}
			else {
				request.setAttribute("skill", skill);
				skillBo.editSkills(skill);
				response.sendRedirect(request.getContextPath() + "/Skills?msg=3");
			}
		}
		
	}

}
