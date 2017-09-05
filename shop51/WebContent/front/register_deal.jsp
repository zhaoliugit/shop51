<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
    <jsp:useBean id="ins_member" scope="page" class="com.dao.MemberDaoImpl"/>
    <jsp:useBean id="member" scope="request" class = "com.model.Member">
    	<jsp:setProperty name = "member" property = "*"/>
    </jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String username = member.getUsername();
		ResultSet rs = conn.executeQuery("select * from tb_Member where username='"
				+username+"'");
		if(rs.next()){
			out.println("<script language='javascript'>alert('该账号已经存才，请重新注册！');"
			+"window.location.href='register.jsp';</script>");
		}else{
			int ret = 0;
			ret = ins_member.insert(member);
			if(ret != 0){
				session.setAttribute("username", username);
				out.println("<script language='javascript'>alert('会员注册成功');"
						+"windows.location.href='index.jsp';</script>");
			}else{
				out.println("<script language='javascript'>alert('会员注册失败');"
				+"windows.location.href='register.jsp';</script>");
			}
		}
	%>
</body>
</html>