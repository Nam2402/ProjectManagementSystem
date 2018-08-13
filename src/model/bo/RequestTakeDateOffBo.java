package model.bo;

import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.RequestTakDayOff;
import model.dao.RequestTakeDateOffDao;

public class RequestTakeDateOffBo {
	RequestTakeDateOffDao requestTakeDateOffDao;
	public ArrayList<RequestTakDayOff> getRequestTakeaDayOffs(){
		requestTakeDateOffDao = new RequestTakeDateOffDao();
		return requestTakeDateOffDao.getRequestTakeaDayOffs();
	}
	public int changeStatusRequestTakeDayOff(int request_id, int status){
		requestTakeDateOffDao = new RequestTakeDateOffDao();
		return requestTakeDateOffDao.changeStatusRequestTakeDayOff(request_id, status);
	}
	
	public RequestTakDayOff  getRequestByID(int request_id){
		requestTakeDateOffDao = new RequestTakeDateOffDao();
		return requestTakeDateOffDao.getRequestByID(request_id);
	}
	public int getIdOfRequestNearest(){
		requestTakeDateOffDao = new RequestTakeDateOffDao();
		return requestTakeDateOffDao.getIdOfRequestNearest();
	}
	
}