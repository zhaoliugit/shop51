<%@page import="sun.font.Script"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.util.Vector" %>
    <%@page import="com.model.Goodselement" %>
    <jsp:useBean id="conn" scope = "page" class="com.tools.ConnDB"></jsp:useBean>
    <<jsp:useBean id="chStr" scope = "page" class="com.tools.ChStr"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(session.getAttribute("cart")==""){//判断购物车对象是否为空
			out.println("<script language='javascript'>alert('您还没有购物')"
			+"window.location.href='index.jsp");
		
		}
		String Username = (String)session.getAttribute("username");
		if(Username !=""){
			try{
			ResultSet rs_user = conn.executeQuery("select * from tb_Member where username="+Username);
			if (!rs_user.next()){//如果获取的账户名称在会员信息表中不存在（表示非法会员）
				session.invalidate();//session销毁
				out.println("<script language='javascript'>alert('请先登录，再进行购物！')"
				+"window.location.href='index.jsp';</Script>");
				return;
				
			}else{
				//获取输入的收货人姓名
				String receiveName = chStr.chStr(request.getParameter("receiveName"));
				//获取输入的收货人的地址
				String address = chStr.chStr(request.getParameter("address"));
				String tel = request.getParameter("tel");
				String bz = chStr.chStr(request.getParameter("bz"));
				int orderID = 0;
				Vector cart = (Vector)session.getAttribute("cart");
				int number = 0;
				float nowprice = (float) 0.0;
				float sum = (float) 0;
				float Totalsum = (float) 0;
				boolean Flag = true;//标记订单是否有效，为true表示有效
				int temp = 0;
				int ID= -1;
				//插入订单主表信息
				float bnumber = cart.size();
				String sql = "insert into tb_Order(bnumber,username,receiveName,address,"
						+"tel,bz) values ( "+bnumber+",'"+Username+"','"+receiveName+"','"
						+address+"','"+tel+"','"+bz+"')";
				temp = conn.executeUpdate_id(sql);//保存订单信息
				if(temp == 0){
					Flag = false;
				}else{
					orderID = temp;
				}
				String str = "";
				//插入订单明细表数据
				for(int i =0;i< cart.size();i++){
					//获取购物车中的一个商品
					Goodselement myGoodselement = (Goodselement) cart.elementAt(i);
					ID = myGoodselement.ID;
					nowprice = myGoodselement.nowprice;
					number = myGoodselement.number;
					sum = nowprice * number;
					str = "insert into tb_order_Detail(orderID,goodsID,price,Number)"
							+"values("+orderID+","+ID+","+nowprice+","+number+")";
					temp = conn.executeUpdate(str);
					Totalsum = Totalsum + sum;
					if(temp == 0){
						Flag = false;
					}
				}
				if(!Flag){
					out.println("<script language='javascript'>alert('订单无效');"
					+"history.back();</script>");
				}else{
					session.removeAttribute("cart");//清空购物车
					out.println("<script language='javascript'>alert('订单生成，请您记住订单号"
							+"的订单号["+orderID+"]');window.location.href='index.jsp';</script>");
				}
				conn.close();
			}
		}catch(Exception e){
			out.println(e.toString());
		}
		}else{
			session.invalidate();
			out.println("<script language='javascript'>alert('请先登录，再进行购物！');"
			+"window.location.href='index.jsp';</script>");
		}
	%>
</body>
</html>