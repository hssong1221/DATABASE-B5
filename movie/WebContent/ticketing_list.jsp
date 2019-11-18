<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱 씨네마 - 예매 내역</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	String id = (String)session.getAttribute("id");
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
try{
	String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	while(rs.next()){
	%>
		<h2><%= rs.getString("name") %> 님이 로그인 하셨습니다.</h2><br/>
		<a href="output.jsp">내 정보 보러가기</a>
		<a href="index.jsp">로그아웃</a><br/><br/>
		
<%
	}
	
	
	String sql1 = "select ticketing_id, total_price, screening_date, title,theater_num,start_time from payment natural join ticketing natural join schedule natural join movie WHERE client_id='"+id+"' order by ticketing_id";
	stmt = conn.prepareStatement(sql1);
	rs = stmt.executeQuery();
%>
	
	
	<h3>예매 내역</h3>
<%	if(rs.next()){%>
			예매번호   상영일  상영관  시작시간 영화제목  결제가격<br/>
			<%do{%>
				<%=rs.getString("ticketing_id")%>  <%=rs.getString("screening_date")%> <%=rs.getString("theater_num")%> <%=rs.getString("start_time")%> <%=rs.getString("title")%>  <%=rs.getString("total_price")+'원'%><br/>
			<% }while(rs.next());
			}
		else{
			out.println("예매 내역이 없습니다.<br/>");
		}
	
	String sql2 = "select ticketing_id, LISTAGG(seat_name,', ') within group (order by seat_name) name from ticketing natural join ticketing_seat natural join seat natural join payment where client_id = '"+ id +"' group by ticketing_id order by ticketing_id";
	stmt = conn.prepareStatement(sql2);
	rs = stmt.executeQuery();
	
	while(rs.next()){%>
		<%=rs.getString("name")%> <br/>
	<%}%>

	<a href = "main.jsp">메인으로</a>
	
<%	rs.close();
	
}catch(Exception e){
	out.println("연결이 끊겼습니다.");
	e.printStackTrace();
	
}finally{
	conn.close();
}

%>
</body>
</html>