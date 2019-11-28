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
<title>예매 - 영화 선택</title>
<link href="./style/ticketing1.css" type="text/css" rel="stylesheet" />
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
	String date = request.getParameter("month") + "/" + request.getParameter("day");
	
	try{
	
		String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql2);
		ResultSet rs = stmt.executeQuery();

		while(rs.next()){
		%>
			<span class="loging"><%= rs.getString("name") %> 님</span>
		<%}%>
<div class="maindiv">
		
		<div class="new">
			<fieldset><legend>예매</legend>
		<label><span class="inf">선택한 날짜 :</span> <%=date%></label>
		
<%		String sql3 = "SELECT distinct title, movie_id, title FROM movie natural join schedule WHERE screening_date ='"+ date +"'";
		stmt = conn.prepareStatement(sql3);
		rs = stmt.executeQuery();
%>
		<label><span class="inf">영화를 선택해주세요</span></label>
<%
		if(rs.next()){
			do{%>
				<a class="movietitle" href = 'ticketing2.jsp?movie_id=<%=rs.getString("movie_id")%>&date=<%=date%>&title=<%=rs.getString("title")%>'><%= rs.getString("title")%></a><br/><br/>
			<% }while(rs.next());
			}
		else{
			out.println("상영하는 영화가 없습니다.");
		}
		

		rs.close();
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