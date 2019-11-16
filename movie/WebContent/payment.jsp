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
	String[] ch=request.getParameterValues("ch");
	int total_price = 9000 * ch.length;
	
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
		
		String sql1 = "delete from seat_before";
		stmt = conn.prepareStatement(sql1);
		stmt.executeUpdate();
		
		for(int i = 0 ; i < ch.length ; i++){
			String sql2 = "insert into seat_before values('"+ ch[i] +"')";
			stmt = conn.prepareStatement(sql2);
			stmt.executeUpdate();
		}
		
		
		rs.close();
			
			

	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>
<br/><br/>
결제 가격 : <%=total_price%> <br/>
결제수단을 선택하세요 
<form action = "payment1.jsp?schedule_id=<%=schedule_id%>&total_price=<%=total_price%>" method = "POST">
<select name = "pay_method">
	<option value = "신용카드" selected = selected>신용카드</option>
	<option value = "휴대폰결제">휴대폰결제</option>
</select>
<input type = "submit" value = "다음"/>
</form>
</body>
</html>