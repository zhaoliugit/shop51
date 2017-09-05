<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.ResultSet" %>
    <jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String username = request.getParameter("username");
	String checkCode = request.getParameter("checkCode");
	if(checkCode.equals(session.getAttribute("randCheckCode").toString())){
		try{
		ResultSet rs = conn.executeQuery("select * from tb_member where username='"+username+"'");
		
		if(rs.next()){
			String PWD = request.getParameter("PWD");
			if(PWD.equals(rs.getString("password"))){
				session.setAttribute("username", username);
				response.sendRedirect("index.jsp");
			}else{
				out.println("<script language='javascript'>alert('您输入的用户名或密码错误，请与管理员联系！')"
						+"window.location.href='login.jsp';</script>");
			}
		}else{
			out.println(
					"<script langugae='javascript'>alert('您输入的用户名或密码错误，或您的账户已经被冻结，请与管理员联系！');"
					+"windows.location.href='login.jsp';</script>");
		}
		}catch(Exception e){
			out.println("<script language='javascript'>alert('您的操作有误！');"
			+"window.location.href='login.jsp';</script>");
		}
		conn.close();
	}else{
		out.println("<script language='javascript'>alert('您输入的验证码有误！');history.back();</script>");
	}
%>
</body>
</html>