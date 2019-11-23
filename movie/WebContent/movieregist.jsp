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
		<title>영화등록</title>
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
		$(document).ready( function() {
			$("#head").load("./style/head.html");
			$("#footer").load("./style/footer.html");
		});
		</script>
	</head>
	<div id="head" > 
	<body>
	<div class="maindiv">
	<% 
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
        String title = request.getParameter("TITLE");
        String director = request.getParameter("DIRECTOR");
        String actor = request.getParameter("ACTOR");
        String grade = request.getParameter("GRADE");
        String genre = request.getParameter("GENRE");
        String rating = request.getParameter("RATING");
        String booking_rate = request.getParameter("BOOKING_RATE");
        String run_time = request.getParameter("RUN_TIME");
        String plot = request.getParameter("PLOT");
        String movie_id = request.getParameter("MOVIE_ID");
        
        try{
        	String sql = "INSERT INTO MOVIE (title,director,actor,grade,genre,rating,booking_rate,run_time,plot,movie_id)" + 
                    "values('" + title + "','" + director + "','" + actor + "','" + grade + "','" + genre + "','" + rating + "','" + booking_rate + "','" + run_time + "','" + plot + "','" + movie_id + "')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
	%>
		<p>
			영화를 등록하였습니다.<br/>
			<a href = "admin.jsp">돌아가기</a>
		</p>		
	<%
			stmt.close();
		}catch(Exception e){
		    out.print("연결이 해제되었다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
	%>
	</div>
	<div id="footer" > </div>
	</body>
</html>