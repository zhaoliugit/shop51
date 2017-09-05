package com.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnDB {
		public Connection conn = null;		//连接数据库
		public Statement stmt = null;		//statement对象，执行sql
		public ResultSet rSet = null;		//结果集对象
		
		//驱动类的类名
		private static String dbClassName = "com.mysql.jdbc.Driver";
		private static String dbUrl = "jdbc:mysql://localhost:3306/db_shop?characterEncoding=utf8&&useSSL=false";
		private static String dbUser = "root";	//登录SQL Server的用户
		private static String dbPwd = "123456";	//登录SQL Server的密码

		
		public static Connection getConnection() {
			Connection conn = null;
			try {
			Class.forName(dbClassName).newInstance();
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);}catch (Exception e) {
				
				e.printStackTrace();
			}
			
			if(conn==null) {
				System.err.println("DbConnectionMannager.getConnection():"+
						dbClassName +"\r\n:"+dbUrl + "\r\n"+dbUser+"/"+dbPwd);
			}
			return conn;
		}
		
		public int executeUpdate(String sql) {
			int result = 0;
			
			try {
				conn = getConnection();
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				result = stmt.executeUpdate(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				result = 0;
				e.printStackTrace();
			}
			
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
			
		}
		
		public ResultSet executeQuery(String sql) {
			try {
				conn = getConnection();
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				rSet = stmt.executeQuery(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return rSet;
			
		}
		
		public void close() {
			try {
				if (rSet != null) {
					rSet.close();
				}
				if(stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace(System.err);
			}
			
		}
		
		public static void main(String[] args) {
			if (getConnection() != null) {
				System.out.println("数据库连接成功");
				
			}
			
		}
		/*
		 * 功能：更新数据后获取自动生成的自动编号*/
		public int  executeUpdate_id(String sql) {
			int result = 0;
			
			try {
				conn = getConnection();
				//创建用于执行SQL语句的Statement对象
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				result = stmt.executeUpdate(sql);
				String ID = "select @@IDENTITY as id";//定义用于获取刚刚生成的自动编号的SQL语句
				rSet = stmt.executeQuery(ID);
				if(rSet.next()) {
					int autoID = rSet.getInt("id");
					result = autoID;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return result;
		}
}
