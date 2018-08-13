package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.MyMessages;
import model.bean.User;
import model.bo.UserBo;

/**
 * Servlet implementation class ShowDetailNotiAjax
 */
@WebServlet("/ShowDetailNotiAjax")
public class ShowDetailNotiAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowDetailNotiAjax() {
        super();	
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			int post_id = Integer.valueOf((String) request.getParameter("post_id"));
			MyMessages messages = userBo.getMessageDetail(post_id);
			if(messages.getStatus()== 0){
				if(userBo.changeStatusOfMessages(post_id)>=1){
					System.out.println("Change status sucessfull!");
				}
			}
			PrintWriter printWriter = response.getWriter();
			
			String result = "<div class='modal-header alert alert-primary'>" + 
					" <h5 class='modal-title ' align='center'>" + 
					" <strong>" + messages.getTitle() +"</strong>" + 
					" </h5>" + 
					" <button type='button' class='close' style='color: red; margin-left: 10px;' data-dismiss='modal'>&times;</button>" + 
					" </div>";
			printWriter.println(result);
			printWriter.print("</div> <div class ='modal-body' >");
			printWriter.println("<label style='font-size:15px; color: #343a40;; padding: 10px 5px 10px;' >"+messages.getNotiContent()+"</label>");
		
			if (user.getRoleId() == 3) { 
				printWriter.println("</div> <div class='modal-footer'><button type='button' style=' background:#2e9ade; color: white; ' class ='btn btn-infor aprove' onclick='approveRequest();' >Approve</button> <button type='button' class='btn btn-default;' data-dismiss='modal' style='font-size: 16px;width:80px; margin-right: 30px'>Close</button> </div>");
				
			} else {
				printWriter.println("</div> <div class='modal-footer'><button type='button' class='btn btn-default;' data-dismiss='modal' style='font-size: 16px;width:80px; margin-right: 30px'>Close</button> </div>");
				return;
			} 
			}
		
		
			
		
	}

} 