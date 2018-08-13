package model.bo;

import java.util.ArrayList;
import model.bean.Roles;
import model.dao.RoleDao;

public class RoleBo {

	public ArrayList<Roles> getRoles() {
		RoleDao roleDao = new RoleDao();
		return roleDao.getRoles();
	}

}