package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;
import java.util.ArrayList;

import libralies.ConnectDBLibrary;
import model.bean.Roles;


public class RoleDao {

	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;
	private Statement st;
	
	public ArrayList<Roles> getRoles() {
		ArrayList<Roles> roles = new ArrayList<>();
		
		conn = ConnectDBLibrary.getConnection();
		String sql = "select * from roles";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				Roles role = new Roles(rs.getInt("role_id"), rs.getString("name"));
				roles.add(role);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectDBLibrary.close(rs, st, conn);
		}
	
		return roles;
	}

}