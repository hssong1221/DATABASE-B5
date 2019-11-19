<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 정보 삭제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	Connection conn = null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();

	String ticketing_id = request.getParameter("ticketing_id");
	String schedule_id = request.getParameter("schedule_id");
	try {
		String sql = "update seat_schedule set status = 0 where schedule_id = '"+ schedule_id + "' and seat_id = some(select seat_id from ticketing_seat natural join ticketing where ticketing_id = '"+ ticketing_id +"')";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.executeUpdate();

		String sql1 = "delete from ticketing_seat where ticketing_id = '" + ticketing_id + "'";
		stmt = conn.prepareStatement(sql1);
		stmt.executeUpdate();
		
		String sql2 = "delete from ticketing where ticketing_id = '" + ticketing_id +"'";
		stmt = conn.prepareStatement(sql2);
		stmt.executeUpdate();
		
		String sql3 = "delete from payment where ticketing_id = '" + ticketing_id +"'";
		stmt = conn.prepareStatement(sql3);
		stmt.executeUpdate();
		
		

	} catch (Exception e) {
		out.println("<h3>연결에 실패하였습니다.</h3>");
		e.printStackTrace();
	}finally{
		conn.close();
	}
%>
<script>
	alert("예매가 취소되었습니다.");
	location.href = "redirect.jsp";
</script>
</body>
</html>