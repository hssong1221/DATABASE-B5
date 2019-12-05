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
<link href="./style/ticketing2.css" type="text/css" rel="stylesheet" />
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	$(document).ready( function() {
		$("#head").load("./style/head.html");
		$("#footer").load("./style/footer.html");
	});
</script>
</head>
<div id=head></div>
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

		String sql3 = "SELECT theater_num, start_time FROM movie natural join schedule WHERE screening_date ='"+ date +"' and movie_id ='" + movie_id + "' order by start_time";
		PreparedStatement stmt1 = conn.prepareStatement(sql3);
		ResultSet rs1 = stmt1.executeQuery();

		String sql4 = "select sum(status) from seat_schedule natural join schedule where movie_id = '" + movie_id + "' and screening_date = '" + date + "' group by start_time order by start_time";
		PreparedStatement stmt2 = conn.prepareStatement(sql4);
		ResultSet rs2 = stmt2.executeQuery();
%>
		<div class="maindiv">

<%
		while(rs.next()){
		%>
			<span class="loging"><%= rs.getString("name") %> 님</span>
		<%}%>
			<div class="new">
			<fieldset><legend>예매</legend>
		<label><span class="inf">선택한 날짜 :</span> <%=date%></label>
		<label><span class="inf">선택한 영화 :</span> <%=title%></label>
		
<%		
	 	while(rs1.next()&&rs2.next()){%>
	 	<div class="movie">
		<a  href = "seat.jsp?date=<%=date%>&movie_id=<%=movie_id%>&start_time=<%= rs1.getString("start_time")%>&theater_num=<%= rs1.getString("theater_num")%>">
			<label><%= rs1.getString("theater_num")%>  </label>	<hr class="hr" />
			<label><span class="time" ><%= rs1.getString("start_time")%></span></label> <hr class="hr" />

			<label> <%=100-Integer.parseInt(rs2.getString("sum(status)")) %> 석 / 100 석 </label>
		</a>
		</div>
	<%}%>
<%
		rs.close();
		rs1.close();
		rs2.close();
%>			
		</fieldset>
		</div>
<%
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
<div id=footer></div>
</html>