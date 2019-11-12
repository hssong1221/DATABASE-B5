<%@page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱 씨네마</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String admin = "admin";
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	String moviepage = "1";
	
	try{
		if(id.equals(admin)){
			String sql1 = "SELECT * FROM client";
			PreparedStatement stmt = conn.prepareStatement(sql1);
			ResultSet rs = stmt.executeQuery();
			%>
			
			<h1>관리자로 로그인 하셨습니다.</h1><br/>
			<a href="admin.jsp">영화관 관리 </a>
			<a href="index.jsp">로그아웃</a>
			
			<%
			rs.close();
		}else{
			//사용자 모드 일때 오직 사용자 개인의 정보만 가져올 수 있다.
			String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
			PreparedStatement stmt = conn.prepareStatement(sql2);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){%>
				<h2><%= rs.getString("name") %> 님이 로그인 하셨습니다.</h2><br/>
				<a href="output.jsp">내 정보 보러가기</a>
				<a href="index.jsp">로그아웃</a><br/><br/>
				<a href = "ticketing.jsp">예매</a><br/>
<%
				}
			String sql3 = "select * from movie";
			stmt = conn.prepareStatement(sql3);
			rs = stmt.executeQuery();
			while(rs.next()){
%>
			<body>
				<br/>
				<a href ="m_info.jsp?moviepage=<%= rs.getString("movie_id")%>"><img width = "20%" src="image\<%=rs.getString("movie_id")%>.jpg"/></a>
				<strong><%=rs.getString("title")%></strong>
				예매율 <%=rs.getString("booking_rate")%>
<%}
			rs.close();
			}
			

	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
			
%>


		
</body>
</html>