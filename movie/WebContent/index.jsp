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
<body>
<%
	session.invalidate();
	request.setCharacterEncoding("UTF-8");
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	try{
		String sql = "select * from movie";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
%>
		<body>
			<br/>
			<a href = "login.jsp">로그인</a><br/>
			<a href ="m_info.jsp"><img width = "20%" src="image\<%=rs.getString("movie_id")%>.jpg"/></a>
			<strong>예매율 <%=rs.getString("booking_rate")%></strong>
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
</body>
</html>