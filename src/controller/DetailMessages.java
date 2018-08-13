package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import model.bean.MyMessages;
import model.bo.UserBo;

/**
 * Servlet implementation class DetailMessages
 */
@WebServlet("/trainee/detailnoti")
public class DetailMessages extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserBo userBo;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailMessages() {
        super();
        userBo = new UserBo();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int msg_id  = Integer.valueOf((String)request.getParameter("msg_id"));
		
		MyMessages messages =  userBo.getMessageDetail(msg_id);
		System.out.println(messages.getStatus());
		if(messages.getStatus()== 0){
			if(userBo.changeStatusOfMessages(msg_id)>=1){
				System.out.println("Change status sucessfull!");
			}
		}
		PrintWriter out = response.getWriter();
//		out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'>");
//		out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'>");
		out.println("<script>"); 
		out.println("$(document).ready(function(){");
		out.println("swal('welcome', 'succesfull','abc');");
		out.println("});");
		out.println("</script>");
		
		
		request.setAttribute("messages", messages);
		RequestDispatcher rd=request.getRequestDispatcher("/admin/trainees/viewOneNoti.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}