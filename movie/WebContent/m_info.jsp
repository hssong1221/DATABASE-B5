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
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	    <script type="text/javascript">
	    $(document).ready( function() {
	        $("#head").load("./style/head.html");
	        $("#footer").load("./style/footer.html");
	    });
	    </script>
	</head>
	<body>
	<div id="head" > </div>
	<%
		session.invalidate();
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		String moviepage = request.getParameter("moviepage");
		
		try{
			String sql = "SELECT * FROM movie WHERE movie_id = '" + moviepage + "'";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){
	%>
		<p>
			<img width = "30%" src="image\<%=rs.getString("movie_id")%>.jpg"/>
			<br/>
			영화제목 : <%=rs.getString("title")%> <br/>
			감독 : <%=rs.getString("director")%> <br/>
			배우 : <%=rs.getString("actor")%> <br/>
			상영등급 : <%=rs.getString("grade")%> <br/>
			장르 : <%=rs.getString("genre")%> <br/>
			평정 : <%=rs.getString("rating")%> <br/>
			예매율 : <%=rs.getString("booking_rate")%> <br/>
			상영시간 : <%=rs.getString("run_time")%> <br/>
			줄거리 : <%=rs.getString("plot")%> <br/>
			
		</p>
	<%	}
			rs.close();
			
		    
		}catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
				
	%>
	<div id="footer" > </div>
	</body>
</html>