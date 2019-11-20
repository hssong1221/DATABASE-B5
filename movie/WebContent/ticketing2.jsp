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
<title>예매 - 상영시간 선택</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	String date = request.getParameter("date");
	String movie_id = request.getParameter("movie_id");
	String title = request.getParameter("title"); 
	try{
	
		String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql2);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){%>
			<h2><%= rs.getString("name") %> 님이 로그인 하셨습니다.</h2><br/>
			<a href="output.jsp">내 정보 보러가기</a>
			<a href="index.jsp">로그아웃</a><br/><br/>
		<%}%>

		선택한 날짜 : <%=date%><br/>
		선택한 영화 : <%=title%><br/><br/>
		
<%		String sql3 = "SELECT theater_num, start_time FROM movie natural join schedule WHERE screening_date ='"+ date +"' and movie_id ='" + movie_id + "' order by start_time";
		stmt = conn.prepareStatement(sql3);
		rs = stmt.executeQuery();
		
	 	while(rs.next()){%>
			<%= rs.getString("theater_num")%> : <a href = "seat.jsp?date=<%=date%>&movie_id=<%=movie_id%>&start_time=<%= rs.getString("start_time")%>&theater_num=<%= rs.getString("theater_num")%>"><%= rs.getString("start_time")%></a><br/>
	<%}
		
		String sql4 = "select sum(status) from seat_schedule natural join schedule where movie_id = '" + movie_id + "' and screening_date = '" + date + "' group by start_time order by start_time";
		stmt = conn.prepareStatement(sql4);
		rs = stmt.executeQuery();
		while(rs.next()){%>
			남은좌석 : <%=100-Integer.parseInt(rs.getString("sum(status)")) %> / 100 <br/>
		<%}
		rs.close();
			
			

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