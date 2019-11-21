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
	    <link href="./style/m_info.css" type="text/css" rel="stylesheet" />
	</head>
	<div id="head" > </div>
	<body>
	<div class="maindiv">
	<%
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
		<div class="maindiv">
			<img class="movie" width = "30%" src="image\<%=rs.getString("movie_id")%>.jpg"/>
			<div>
				<p>영화제목 : <%=rs.getString("title")%> </p>
				<p>감독 : <%=rs.getString("director")%> </p>
				<p>배우 : <%=rs.getString("actor")%> </p>
				<p>상영등급 : <%=rs.getString("grade")%> </p>
				<p>	장르 : <%=rs.getString("genre")%> </p>
				<p>평정 : <%=rs.getString("rating")%> </p>
				<p>예매율 : <%=rs.getString("booking_rate")%> </p>
				<p>상영시간 : <%=rs.getString("run_time")%> </p>
				<p>줄거리 : <%=rs.getString("plot")%> </p>
			</div>
			
		</div>
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
	
	</div>
	</body>
	<div id="footer" > </div>
</html>