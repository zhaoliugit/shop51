package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Member;
import com.tools.ChStr;
import com.tools.ConnDB;

import sun.net.www.content.text.plain;

public class MemberDaoImpl implements MemberDao {
	private ConnDB conn = new ConnDB();//创建数据库连接类的对象
	private ChStr chStr = new ChStr(); //创建字符串操作类的对象
	@Override
	public int insert(Member m) {
		
		int ret = -1;
		try {
			if (m.getUsername()!=null) {
				String sql = "Insert into tb_Member(UserName,TrueName,PassWord,City,address,"
						+"postcode,CardNO,CardType,Tel,Email) values ('"
						+ chStr.chStr(m.getUsername())+"','"+chStr.chStr(m.getTruename())+"','"
						+chStr.chStr(m.getPwd()) + "','" +chStr.chStr(m.getCity()) + "','"
						+chStr.chStr(m.getAddress())
						+"','"+chStr.chStr(m.getPostcode())+"','"+chStr.chStr(m.getCardno())
						+"','"+chStr.chStr(m.getCardtype())+"','"+chStr.chStr(m.getTel())+"','"
						+chStr.chStr(m.getEmail())
						+"')";
				ret = conn.executeUpdate(sql);
			}else {
				ret = 0;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			ret = 0;
		}
		conn.close();
		return ret;
	}

	@Override
	public List seclet() {
		Member form = null;
		List list = new ArrayList();
		String sql = "select * from tb_member";
		ResultSet rSet = conn.executeQuery(sql);
		
		try {
			while(rSet.next()) {
				form = new Member();
				form.setID(Integer.valueOf(rSet.getString(1)));
				list.add(form);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		conn.close();
		return list;
	}

}
