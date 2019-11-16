<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱씨네마 - 결제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	String id = (String)session.getAttribute("id");
	String schedule_id = request.getParameter("schedule_id");
	String pay_method = request.getParameter("pay_method");
	String total_price = request.getParameter("total_price");
	try{
		String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		%>
			<h2><%= rs.getString("name") %> 님이 로그인 하셨습니다.</h2><br/>
			<a href="output.jsp">내 정보 보러가기</a>
			<a href="index.jsp">로그아웃</a><br/><br/>
			
		<%
		}
		
		rs.close();%>
		<form action = "complete.jsp?schedule_id=<%=schedule_id%>&pay_method=<%=pay_method%>&total_price=<%=total_price%>" method = "POST">
		<% if(pay_method.equals("신용카드")){%>
			카드번호 : <input name = "card_num" type="text" placeholder = "카드번호"/>
			카드 비밀번호 : <input name = "card_pwd" type="password" placeholder = "카드 비밀번호"/>
		<% }else{%>
			휴대폰번호 : <input name = "phone_num" type="text" placeholder = "휴대폰번호"/>
			결제비밀번호 : <input name = "pay_pwd" type="password" placeholder = "결제 비밀번호"/>
		<%}%>
			<input type = "submit" value = "결제"/>
		</form>			

	<% }catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>
<br/><br/>


</body>
</html>