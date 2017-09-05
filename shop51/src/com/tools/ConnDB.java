package com.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnDB {
		public Connection conn = null;		//�������ݿ�
		public Statement stmt = null;		//statement����ִ��sql
		public ResultSet rSet = null;		//���������
		
		//�����������
		private static String dbClassName = "com.mysql.jdbc.Driver";
		private static String dbUrl = "jdbc:mysql://localhost:3306/db_shop?characterEncoding=utf8&&useSSL=false";
		private static String dbUser = "root";	//��¼SQL Server���û�
		private static String dbPwd = "123456";	//��¼SQL Server������

		
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
				System.out.println("���ݿ����ӳɹ�");
				
			}
			
		}
		/*
		 * ���ܣ��������ݺ��ȡ�Զ����ɵ��Զ����*/
		public int  executeUpdate_id(String sql) {
			int result = 0;
			
			try {
				conn = getConnection();
				//��������ִ��SQL����Statement����
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				result = stmt.executeUpdate(sql);
				String ID = "select @@IDENTITY as id";//�������ڻ�ȡ�ո����ɵ��Զ���ŵ�SQL���
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
