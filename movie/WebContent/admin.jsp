<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
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
		<title>영화관 관리</title>
		<script src = "js/join.js"></script>
	</head>
	<body>
	<nav>
		<ul>
			<li><a href = #nowmovie> 현재 상영중인 영화</a></li>
			<li><a href = #ctable> 고객 정보</a></li>
		</ul>
		
	</nav>
	<%
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		try{
			String sql = "select * from movie";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			String sql2 = "select * from client";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = stmt2.executeQuery();
	 %>
		<br/>
		<div>
			<p id = "nowmovie">현재 상영중인 영화</p>
	<% 
			while(rs.next()){
	%>		
			<%= rs.getString("movie_id") %>
			<img width = "20%" src="image\<%=rs.getString("movie_id")%>.jpg" />
				
	<%	}
	%>
			<form action = "movieregist.jsp" method="post" onSubmit = 'return mval();'>
				새로운 영화 추가 : <br/>
				<input placeholder="TITLE" type="text" name="TITLE" /><br/>
				<input placeholder="DIRECTOR" type="text" name="DIRECTOR" /><br/>
				<input placeholder="ACTOR" type="text" name="ACTOR" /><br/>
				<input placeholder="GRADE" type="text" name="GRADE" /><br/>
				<input placeholder="GENRE" type="text" name="GENRE" /><br/>
				<input placeholder="RATING" type="text" name="RATING" /><br/>
				<input placeholder="BOOKING_RATE" type="text" name="BOOKING_RATE" /><br/>
				<input placeholder="RUN_TIME" type="text" name="RUN_TIME" /><br/>
				<textarea placeholder="PLOT" name="PLOT" cols="40" rows="8" ></textarea><br/>
				<input placeholder="MOVIE_ID" type="text" name="MOVIE_ID" /><br/>
				<input type="submit" value="등록" />
			</form>	
		</div>
		<br/>
		<%	rs.close(); %>
		<table id = "ctable" border = "1">
		<caption>고객 정보</caption>
			<thead>
				<tr>	
					<th>고객 아이디</th>
					<th>생년월일</th>
					<th>전화번호</th>
					<th>마일리지</th>
					<th>이름</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>		
		<% 
			while(rs2.next()){ %> 
			<tr>
				<td><%= rs2.getString("client_id") %></td>
				<td><%= rs2.getString("num1") %></td>
				<td><%= rs2.getString("phone_num") %></td>
				<td><%= rs2.getString("mileage") %></td>
				<td><%= rs2.getString("name") %></td>
				<td><%= rs2.getString("address") %></td>
			</tr>
		<%	
			}
		%>		
			</tbody>
		</table>
		<br/> 
		<a href = "main.jsp">메인화면</a>
		
		<% 
			rs2.close();
		
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