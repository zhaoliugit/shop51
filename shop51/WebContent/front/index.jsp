<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.sql.ResultSet" %>
	<jsp:useBean id="conn" scope="page" class="com.tools.ConnDB"></jsp:useBean>
	
	<%
		/*最新上架商品信息*/
		ResultSet rs_new = conn.executeQuery("select  tb_goods.ID,tb_goods.goodsName,tb_goods.price,tb_goods.picture,tb_subType.TypeName "
				+"from tb_goods ,tb_subType where tb_goods.typeID=tb_subType.ID and "
				+"tb_goods.newGoods=1 order by tb_goods.INTime desc limit 0,12");
		int new_ID=0;
		String new_goodsname="";
		float new_nowprice = 0;
		String new_picture = "";
		String typeName = "";
		/* 打折商品信息*/
		ResultSet rs_sale = conn.executeQuery("select tb_goods.ID,tb_goods.goodsName,tb_goods.price,tb_goods.nowPrice,tb_goods.picture,tb_subType.TypeName "
				+"from tb_goods,tb_subType where tb_goods.typeID=tb_subType.ID and tb_goods.sale=1 "
				+"order by tb_goods.INTime desc limit 0,12");
		int sale_ID = 0;
		String s_goodsname = "";
		float s_price = 0;
		float s_nowprice = 0;
		String s_introduce = "";
		String s_picture = "";
		/*热门商品信息*/
		ResultSet rs_hot = conn.executeQuery("select ID,goodsName,nowPrice,picture"+
		"from tb_goods order by hit desc limit 0,1");
		int hot_ID = 0;
		String hot_goodsName = "";
		float hot_nowprice = 0;
		String hot_picture = "";
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>首页-51商城</title>
<link rel="stylesheet" href="css/mr-01.css" type="text/css">
<script src="js/jsArr01.js" type="text/javascript"></script>
<script src="js/module.js" type="text/javascript"></script>
<script src="js/jsArr02.js" type="text/javascript"></script>
<script src="js/tab.js" type="text/javascript"></script>

</head>

<body>
	<jsp:include page="index-loginCon.jsp" />
	<!-- 网站头部 -->
	<%@ include file="common-header.jsp"%>
	<!-- //网站头部 -->
	<!-- 轮播广告及热门商品 -->
	<div class="container mr-sl mr-sl-1">
		<div class="mr-spotlight mr-spotlight-1  row">
			<!-- 显示轮播广告 -->
			<div
				class=" col-lg-9 col-md-12  col-sm-3 hidden-sm   col-xs-6 hidden-xs ">
				<div class="mr-module module " id="Mod159">
					<div class="module-inner">
						<div class="module-ct">
							<div class="mijoshop">
								<div class="container_oc">
									<div class="slideshow">
										<div id="slidershow" class="nivoSlider">
											<a href="#" class="nivo-imageLink" style="display: block;"><img
												src="images/img1.png" class="img-responsive"
												style="display: none;"> </a> <a href="#"
												class="nivo-imageLink" style="display: none;"> <img
												src="images/img2.png" class="img-responsive"
												style="display: none;">
											</a> <a href="#" class="nivo-imageLink" style="display: none;">
												<img src="images/img3.png" class="img-responsive"
												style="display: none;">
											</a> <a href="#" class="nivo-imageLink" style="display: none;">
												<img src="images/img4.png" class="img-responsive"
												style="display: none;">
											</a>
										</div>
									</div>
									<script type="text/javascript">
										//实现调用幻灯片插件轮播广告
										<!--
										jQuery(document).ready(function() {
											jQuery('#slidershow').nivoSlider();
										});
									//-->
									</script>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 显示热门商品 -->
			<div
				class="col-lg-3  col-md-6 hidden-md   col-sm-3 hidden-sm   col-xs-6 hidden-xs ">
				<div class="mr-module module highlight " id="Mod160">
					<div class="module-inner">
						<h3 class="module-title ">
							<span>热门商品</span>
						</h3>
						<div class="module-ct">
							<div class="mijoshop">
								<div class="container_oc">
									<div class="box_oc">
										<!-- 循环显示热门商品 ：添加两条商品信息-->
										<%
											while(rs_hot.next()){
												hot_ID = rs_hot.getInt(1);
												hot_goodsName = rs_hot.getString(2);
												hot_nowprice = rs_hot.getFloat(3);
												hot_picture = rs_hot.getString(4);
											
										%>

										<div class="box-product product-grid">
											<div>
												<div class="image">
													<a href="goodsDetail.jsp?ID=<%=hot_ID %>"><img src="../images/goods/<%=hot_picture %>" width="250px"></a>
													</a>
												</div>
												<div class="name"><a href="goodsDetail.jsp?ID=61"><%=hot_goodsName %></a></div>
												<!-- 星级评分条 -->
												<div class="rating">
													<span class="fa fa-stack"><i
														class="fa fa-star fa-stack-2x"></i><i
														class="fa fa-star-o fa-stack-2x"></i> </span> <span
														class="fa fa-stack"><i
														class="fa fa-star fa-stack-2x"></i><i
														class="fa fa-star-o fa-stack-2x"></i> </span> <span
														class="fa fa-stack"><i
														class="fa fa-star fa-stack-2x"></i><i
														class="fa fa-star-o fa-stack-2x"></i> </span> <span
														class="fa fa-stack"><i
														class="fa fa-star fa-stack-2x"></i><i
														class="fa fa-star-o fa-stack-2x"></i> </span> <span
														class="fa fa-stack"><i
														class="fa fa-star fa-stack-2x"></i><i
														class="fa fa-star-o fa-stack-2x"></i> </span>
												</div>
												<!-- // 星级评分条 -->
												<!-- 商品价格 -->
												<div class="price">
													<span class="price-new"><%=hot_nowprice %>
													</span>
												</div>
												<!-- // 商品价格 -->
											</div>
										</div>
										<% } %>

										<!-- // 循环显示热门商品 ：添加两条商品信息-->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- // 显示热门商品 -->
		</div>
	</div>
	<!-- //轮播广告及热门商品  -->
	<!-- 最新上架及打折商品展示 -->
	<nav class="container mr-masstop  hidden-sm hidden-xs">
	<div class="custom">
		<div>
			<div class="ja-tabswrap default" style="width: 100%;">
				<div id="myTab" class="container">

					<h3 class="index_h3">
						<span class="index_title">最新上架</span>
					</h3>
					<!-- //最新上架选项卡 -->
					<div class="ja-tab-content ja-tab-content col-6 active"
						style="opacity: 1; width: 100%; visibility: visible;">
						<div class="ja-tab-subcontent">
							<div class="mijoshop">
								<div class="container_oc">
									<div class="row">
										<!-- 循环显示最新上架商品 ：添加12条商品信息-->
										<%
											while(rs_new.next()){
												new_ID = rs_new.getInt(1);
												new_goodsname = rs_new.getString(2);
												new_nowprice = rs_new.getFloat(3);
												new_picture = rs_new.getString(4);
												typeName = rs_new.getString(5);
											
										%>
												<div
													class="product-grid col-lg-2 col-md-3 col-sm-6 col-xs-12">
													<div class="product-thumb transition">
														<div class="actions">
															<div class="image">
																<a href="goodsDetail.jsp?ID=<%=new_ID %>>">
																<img src="../images/goods/<%=new_picture %>>" alt="<%=new_goodsname %>>" class="img-responsive"></a>
															</div>
															<div class="button-group">
																<div class="cart">
																	<button class="btn btn-primary btn-primary" type="button" data-toggle="tooltip"
																		onclick='javascript:window.location.href="cart_add.jsp?goodsID=56&num=1"; '
																		style="display: none; width: 33.3333%;" data-original-title="加入到购物车">
																		<i class="fa fa-shopping-cart"></i>
																	</button>
																</div>
															</div>
														</div>
														<div class="caption">
															<div class="name" style="height: 40px">
																<a href="goodsDetail.jsp?ID=<%=new_ID %>>"> <span style="color: #0885B1">商品名：<%=new_goodsname %>>  asus/华硕 G11</a>
															</div>
															<div class="name" style="margin-top: 10px"><p class="price">价格：<%=new_nowprice %></p></div>
														</div>
													</div>
												</div>
												<% } %>>
										<!-- //循环显示最新上架商品：添加12条商品信息 -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- //最新上架选项卡 -->
					<!-- 打折商品选项卡 -->
					<h3 class="index_h3"><span class="index_title">打折商品</span></h3>
					<div class="ja-tab-subcontent">
						<div class="mijoshop">
							<div class="container_oc">
								<div class="row">
									<!-- 循环显示打折商品 ：添加12条商品信息-->
									<%
										while (rs_sale.next()){
											sale_ID = rs_sale.getInt(1);
											s_goodsname = rs_sale.getString(2);
											s_price = rs_sale.getFloat(3);
											s_nowprice = rs_sale.getFloat(4);
											s_picture = rs_sale.getString(5);
											typeName = rs_sale.getString(6);
										
									%>
										<div
													class="product-grid col-lg-2 col-md-3 col-sm-6 col-xs-12">
													<div class="product-thumb transition">
														<div class="actions">
															<div class="image">
																<a href="goodsDetail.jsp?ID=49 "><img src="../images/goods/48.jpg"
																	alt="Asus/华硕 顽石4代" class="img-responsive"> </a>
															</div>
															<div class="button-group">
																<div class="cart">
																	<button class="btn btn-primary btn-primary" type="button" data-toggle="tooltip"
																		onclick='javascript:window.location.href="cart_add.jsp?goodsID=49&num=1"; '
																		style="display: none; width: 33.3333%;" data-original-title="加入到购物车">
																		<i class="fa fa-shopping-cart"></i>
																	</button>
																</div>
															</div>
														</div>
														<div class="caption">
															<div class="name" style="height: 40px">
																<a href="goodsDetail.jsp?ID=49"
																	style="width: 95%"> <span style="color: #0885B1">商品名：</span>Asus/华硕 顽石4代</a>
															</div>
															<div class="name" style="margin-top: 10px">
																<span class="price"> 现价：5000.0 元</span><br> <span class="oldprice">原价：5499.0 元</span>
															</div>
														</div>
													</div>
												</div>
												<% } %>
									<!-- 循环显示打折商品 ：添加12条商品信息-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //打折商品 选项卡-->
			</div>
		</div>
	</div>
	</nav>
	<!-- //最新上架及打折商品展示 -->
	<!-- 版权栏 -->
	<%@ include file="common-footer.jsp"%>
	<!-- //版权栏 -->
</body>
</html>