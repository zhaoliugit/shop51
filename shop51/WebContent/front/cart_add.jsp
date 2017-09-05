<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.util.Vector" %>
    <%@page import="com.model.Goodselement" %>
    <jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String username=(String)session.getAttribute("username");
		String num=(String)request.getParameter("num");
		//如果没有登录，将跳转到登录页面
		if(username == null || username==""){
			response.sendRedirect("login.jsp");
			return;
		}
		int ID = Integer.parseInt(request.getParameter("goodsID"));//获取商品ID
		String sql = "select * from tb_goods where ID="+ID;
		ResultSet rs = conn.executeQuery(sql);
		float nowprice = 0;
		if(rs.next()){
			nowprice = rs.getFloat("nowprice");
		}
		//创建保存购物车内商品信息的模型类的对象mygoodselement
		Goodselement myGoodselement = new Goodselement();
		myGoodselement.ID = ID;
		myGoodselement.nowprice = nowprice;
		myGoodselement.number = Integer.parseInt(num);
		boolean Flag = true;
		Vector cart = (Vector) session.getAttribute("cart");
		if(cart == null){
			cart = new Vector();
		}else{
			//判断购物车内是否已经存在所购买的商品
			for(int i=0;i<cart.size();i++){
				Goodselement goodselement = (Goodselement) cart.elementAt(i);
				//直接改变购物数量
				goodselement.number = goodselement.number + myGoodselement.number;
				cart.setElementAt(goodselement, i);
				Flag = false;
			}
		}
		
		if(Flag)
			cart.addElement(myGoodselement);
		session.setAttribute("cart", cart);
		conn.close();
		response.sendRedirect("cart_see.jsp");
	%>
</body>
</html>