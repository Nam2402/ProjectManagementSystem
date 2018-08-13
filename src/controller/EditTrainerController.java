package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.FormatDateLibrary;
import libralies.MD5Library;
import model.bean.Ability;
import model.bean.User;
import model.bo.AbilityBo;
import model.bo.UserBo;

@MultipartConfig
public class EditTrainerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UserBo userBo = new UserBo();
		AbilityBo abilityBo = new AbilityBo();

		int userId = Integer.parseInt(request.getParameter("id"));
		User trainer = userBo.getTrainerById(userId);
		Ability ability = abilityBo.getAbilityByUserId(userId);

		request.setAttribute("trainer", trainer);
		request.setAttribute("ability", ability);

		request.getRequestDispatcher("/admin/training_manager/edit_trainer_account.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UserBo userBo = new UserBo();
		AbilityBo abilityBo = new AbilityBo();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:MM:SS");
		int userID = Integer.parseInt(request.getParameter("user_id"));
		
		String userName = request.getParameter("username").trim();
		String fullName = request.getParameter("fullname").trim();
		int gender = Integer.parseInt(request.getParameter("gender"));
		String address = request.getParameter("address").trim();
		String phone = request.getParameter("phone").trim();
		Date dateOfBirth = FormatDateLibrary.ConvertStringToDateSQL(request.getParameter("dateOfBirth"));
		int skillId = Integer.parseInt(request.getParameter("skillId"));
		int experience = Integer.parseInt(request.getParameter("experience"));

		User trainer = userBo.getTrainerById(userID);
		trainer.setUsername(userName);
		trainer.setFullname(fullName);
		trainer.setGender(gender);
		trainer.setAddress(address);
		trainer.setPhone(phone);
		trainer.setDateOfBirth(dateOfBirth);
		

		Ability ability = abilityBo.getAbilityByUserId(userID);
		
		if ( !"".equals(request.getParameter("oldpass"))) { 
			
			if (trainer.getPassword().equals(MD5Library.md5(request.getParameter("oldpass")))) {
				trainer.setPassword(MD5Library.md5(request.getParameter("newpass")));
			} else {
				request.setAttribute("error", " This current password is incorrect!");
				request.setAttribute("trainer", trainer);
				request.setAttribute("ability", ability);	
				request.getRequestDispatcher("/admin/training_manager/edit_trainer_account.jsp").forward(request, response);
			}
		}
		else if (userBo.checkUsernameAlreadyExistsEdit(userName, trainer.getUserId())) {
			System.out.println("check usernmae");
			request.setAttribute("trainer", trainer);
			request.setAttribute("ability", ability);

			request.setAttribute("error", " This username is already exists in system");
			request.getRequestDispatcher("/admin/training_manager/edit_trainer_account.jsp").forward(request, response);
		}
		else if(userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 0) {	
			trainer.setAvatar(trainer.getAvatar());

		} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 1) {
			request.setAttribute("trainer", trainer);
			request.setAttribute("ability", ability);

			request.setAttribute("error", " Please add file jpg, png, gif");
			request.getRequestDispatcher("/admin/training_manager/edit_trainer_account.jsp").forward(request, response);
			
		} else{
			trainer.setAvatar(userBo.addTraineeAvatar(request.getPart("avatar"), request));			
		}
		
		if(userBo.editTrainer(trainer) > 0) {
			if (ability.getSkillId() == skillId) {
					ability.setExperience(experience);
					abilityBo.editTrainerAbility(ability);
			}
			else{
				ability.setSkillId(skillId);
				ability.setExperience(experience);
				abilityBo.editTrainerAbility(ability);		
			}
			response.sendRedirect(request.getContextPath() + "/trainer/index?msg=2");
		} else {
			request.setAttribute("trainer", trainer);
			request.setAttribute("ability", ability);

			request.setAttribute("error", " Can't edit trainer. Please try again later!");
			request.getRequestDispatcher("/admin/training_manager/edit_trainer_account.jsp").forward(request, response);
		}

		
	}
}

