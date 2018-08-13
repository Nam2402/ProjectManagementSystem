package model.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import libralies.ConnectDBLibrary;
import libralies.FormatDateLibrary;
import model.bean.Classes;
import model.bean.RequestTakDayOff;
import model.bean.User;
import model.dao.UserDao;

public class NotificationDao {

	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public int addNotiTakedayoffS( String dateoff, String datechange,  String timechange ,String room, Classes classes , User trainer, int admin_id, int request_id, String note){
		int result = 0;
		String title = "Request day off and compensation schedule.";
		String nameTrainer = trainer.getFullname();
		String nameclasses = classes.getName();
		String content = "";
		
		content+= "The "+nameclasses+" on " +"<b>"+ dateoff+"</b> will be canceled."+"<br/> ";
		content+="<label  id='request_id' style='display: none;' >"+request_id+"  </label>";
		content+="This class will be moved to: <br/>";
		content+="<form>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label><b> Date:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label >"+datechange+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label> <b>Time:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label  >"+timechange+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label  ><b> Room: </b> </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label >"+room+"  </label>";
		content+="</div></div>";
		if(note!=""){
			content+="<div class='row'>";
			content+="<div class='col-15'>";
			content+="<label  ><b> Note:</b>  </label>";
			content+="</div>";
			content+="<div class='col-50'>";
			content+="<label >"+note+"  </label>";
			content+="</div></div>";
		}
		content+="</form>";
		Date dateCurrent = 	FormatDateLibrary.ConvertDateUntilToDateSQL(new java.util.Date());
		
		try {
			conn = ConnectDBLibrary.getConnection();

			String sql = "insert into notification(content,user_id,title, createdDate) values(?,?,?, ?)";
			pst =  conn.prepareStatement(sql);
			pst.setString(1, content);
			pst.setInt(2, admin_id);
			pst.setString(3, title);
			pst.setDate(4, (java.sql.Date) dateCurrent);

			result = pst.executeUpdate();
			String sql1 = "select * from notification order by id desc limit 1";
			pst = conn.prepareStatement(sql1);
			ResultSet result1 = pst.executeQuery();
			int notification_id =0;
			while(result1.next()){
				notification_id = result1.getInt("id");
			}
			if(notification_id!=0){
				String sql2 = "insert into messages(user_id,noti_id, status, request_id) values(?,?, ?,?)";
				pst = conn.prepareStatement(sql2);
				pst.setInt(1, admin_id);
				pst.setInt(2, notification_id);
				pst.setInt(3, 0);
				pst.setInt(4,request_id);
				int result2 = pst.executeUpdate();
				if (result2 > 0) {
					System.out.println("Add messages of take day off successfull");
					
				}
			}
		}catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println(e.getMessage());
				} finally {
					ConnectDBLibrary.close(rs, pst, conn);
				}
				
				return  result;
	}
	public int addRequestTakeaDayOff(String dateoff, String datechange,  String timechange , Classes classes , User trainer, int room_id, String note){
		conn = ConnectDBLibrary.getConnection();
		int kq = 0;
		try{
			String sql= "insert into requestDayOff(class_id, trainer_id, date_off, date_change, time_change, room_id, status, note) values(?,?,?,?,?,?,?,?)";
			
			pst = conn.prepareStatement(sql);
			pst.setInt(1, classes.getClassId());
			pst.setInt(2, trainer.getUserId());
			pst.setString(3, dateoff);
			pst.setString(4, datechange );
			pst.setString(5, timechange);
			pst.setInt(6, room_id);
			pst.setInt(7, 0);
			pst.setString(8, note);
			
			kq=pst.executeUpdate();
			
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return kq;
	}
	public int addNotiRequestBeApproveSendToTrainer(RequestTakDayOff dayOff){
		int result = 0;
		String title = "Your request has been approved.";
		
		String content = "";
//		
//		content+= dayOff.getClass_name() +" will take day off on " + dayOff.getDate_off()+". \n";
//		content+="Replace learning plan is "  + " at "+ dayOff.getTime_change()+ ", on"+ dayOff.getDate_change()+".\n Room  is "+ dayOff.getRoom_name()+". \n We inform to know and do it on time "; ;
//		
		content+= "The "+dayOff.getClass_name()+" on " +"<b>"+ dayOff.getDate_off()+"</b> will be canceled."+"<br/> ";
		content+="This class will be moved to: <br/>";
		content+="<form>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label><b> Date:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label >"+dayOff.getDate_change()+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label> <b>Time:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label  >"+dayOff.getTime_change()+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label  ><b> Room: </b> </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label >"+dayOff.getRoom_name()+"  </label>";
		content+="</div></div>";
		String noteOftrainer = dayOff.getNote();
		if(!noteOftrainer.equals("")){
			content+="<div class='row'>";
			content+="<div class='col-15'>";
			content+="<label  ><b> Note:</b>  </label>";
			content+="</div>";
			content+="<div class='col-50'>";
			content+="<label >"+dayOff.getNote()+"  </label>";
			content+="</div></div>";
		}
		content+="</form>";
		
		Date dateCurrent = 	FormatDateLibrary.ConvertDateUntilToDateSQL(new Date());
				//FormatDateLibrary.ConvertDateUntilToDateSQL(new Date());
		try {
			conn = ConnectDBLibrary.getConnection();
			String sql = "insert into notification(content,title, createdDate) values(?,?, ?)";
			pst =  conn.prepareStatement(sql);
			pst.setString(1, content);
			pst.setString(2, title);
			pst.setDate(3, (java.sql.Date) dateCurrent);
			result = pst.executeUpdate();
			String sql1 = "select * from notification order by id desc limit 1";
			pst = conn.prepareStatement(sql1);
			ResultSet result1 = pst.executeQuery();
			int notification_id =0;
			while(result1.next()){
				notification_id = result1.getInt("id");
			}
			if(notification_id!=0){
				String sql2 = "insert into messages(user_id,noti_id, status, request_id) values(?,?, ?,?)";
				pst = conn.prepareStatement(sql2);
				pst.setInt(1, dayOff.getTrainer_id());
				pst.setInt(2, notification_id);
				pst.setInt(3, 0);
				pst.setInt(4, dayOff.getRequest_id());
				int result2 = pst.executeUpdate();
				if (result2 > 0) {
					System.out.println("Add messages send trainer of take day off successfull");
					
				}
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return result;
	}
	
	public int addNotiRequestTakeDateOffToTraineeOffClass(RequestTakDayOff dayOff){
		int result = 0;
		String title = "Change schedule learning : " + dayOff.getClass_name();
		String content = "";
		content+= "The "+dayOff.getClass_name()+" on " +"<b>"+ dayOff.getDate_off()+"</b> will be canceled."+"<br/> ";
		content+="This class will be moved to: <br/>";
		content+="<form>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label><b> Date:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label>"+dayOff.getDate_change()+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label> <b>Time:</b>  </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label >"+dayOff.getTime_change()+"  </label>";
		content+="</div></div>";
		content+="<div class='row'>";
		content+="<div class='col-15'>";
		content+="<label  ><b> Room: </b> </label>";
		content+="</div>";
		content+="<div class='col-50'>";
		content+="<label>"+dayOff.getRoom_name()+"  </label>";
		content+="</div></div>";
		String noteOftrainer = dayOff.getNote();
		if(!noteOftrainer.equals("")){
			content+="<div class='row'>";
			content+="<div class='col-15'>";
			content+="<label  ><b> Note:</b>  </label>";
			content+="</div>";
			content+="<div class='col-50'>";
			content+="<label>"+dayOff.getNote()+"  </label>";
			content+="</div></div>";
		}
		
		
		content+="</form>";
		Date dateCurrent = 	FormatDateLibrary.ConvertDateUntilToDateSQL(new Date());
				//FormatDateLibrary.ConvertDateUntilToDateSQL(new Date());
		try {
			conn = ConnectDBLibrary.getConnection();
			String sql = "insert into notification(content,title, createdDate) values(?,?, ?)";
			pst =  conn.prepareStatement(sql);
			pst.setString(1, content);
			pst.setString(2, title);
			pst.setDate(3, (java.sql.Date) dateCurrent);
			result = pst.executeUpdate();
			String sql1 = "select * from notification order by id desc limit 1";
			pst = conn.prepareStatement(sql1);
			ResultSet result1 = pst.executeQuery();
			int notification_id =0;
			while(result1.next()){
				notification_id = result1.getInt("id");
			}
			if(notification_id!=0){
				UserDao userDao = new UserDao();

				ArrayList<User> listTraineeOfClass =  userDao.getTraineeOfClass(dayOff.getClass_id());
				
				for(User trainee: listTraineeOfClass){
					String sql2 = "insert into messages(user_id,noti_id, status) values(?,?, ?)";
					pst = conn.prepareStatement(sql2);
					pst.setInt(1, trainee.getUserId());
					pst.setInt(2, notification_id);
					pst.setInt(3, 0);
					int kq = pst.executeUpdate();
					if (kq > 0) {
						System.out.println("Add messages send trainer of take day off successfull");
					
				}
				
			}
			
		}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		} finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		
		return result;
	}

	public int addMessage(int user_id, int notification_id){
		int kq=0;
		try {
			conn = ConnectDBLibrary.getConnection();
			String sql2 = "insert into messages(user_id,noti_id, status) values(?,?, ?)";
			pst = conn.prepareStatement(sql2);
			pst.setInt(1, user_id);
			pst.setInt(2, notification_id);
			pst.setInt(3, 0);
			 kq = pst.executeUpdate();
			if (kq > 0) {
				System.out.println("Add messages send trainer of take day off successfull");
				
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return kq;
	} 
	public int changeStatusAllMessagesOfUser(int user_id){
		int nu=0;		
		conn=ConnectDBLibrary.getConnection();
		String sql = "UPDATE messages SET status = 1 WHERE user_id = ?";
		System.out.println(sql);
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, user_id);
			nu = pst.executeUpdate();
			System.out.println(nu);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return nu;		
	}
	
	public int countNotificationNewById( int user_id){
		
		int count = 0;
		conn= ConnectDBLibrary.getConnection();
		try{
			String sql= "select count(*) as number  from messages where user_id = ? and status = 0;";
			pst= conn.prepareStatement(sql);
			pst.setInt(1, user_id);
			rs = pst.executeQuery();
			if(rs.next()){
				count = rs.getInt("number");
			}
		}
		catch(SQLException e){
			System.out.println(e);
		}
		finally {
			ConnectDBLibrary.close(rs, pst, conn);
		}
		return count;
		
	}


}