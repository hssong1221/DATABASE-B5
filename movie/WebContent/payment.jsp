<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱씨네마 - 결제</title>
<link href="./style/payment.css" type="text/css" rel="stylesheet" />
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
<div class="maindiv">
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	String id = (String)session.getAttribute("id");
	String schedule_id = request.getParameter("schedule_id");
	String[] ch=request.getParameterValues("ch");
	int total_price = 9000 * ch.length;
	
	try{
		String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		%>
			<span class="loging"><%= rs.getString("name") %> 님</span>
		<%}
		
		
		String sql1 = "delete from seat_before";
		stmt = conn.prepareStatement(sql1);
		stmt.executeUpdate();
		
		for(int i = 0 ; i < ch.length ; i++){
			String sql2 = "insert into seat_before values('"+ ch[i] +"')";
			stmt = conn.prepareStatement(sql2);
			stmt.executeUpdate();
		}
		
		String sql2 = "SELECT * FROM schedule natural join movie WHERE schedule_id='"+schedule_id+"'";
		stmt = conn.prepareStatement(sql2);
		rs = stmt.executeQuery();
%>
		<div class="new">
		<fieldset><legend>결제</legend>
<%
		while(rs.next()){
		%>
			<label><span class="inf">상영일  </span><%=rs.getString("screening_date")%></label> 
			<label><span class="inf">시작시간  </span><%=rs.getString("start_time")%></label>
			<label><span class="inf">상영관  </span><%=rs.getString("theater_num")%></label>
			<label><span class="inf">영화제목  </span><%=rs.getString("title")%></label>
			
		<%
		
		}
		
		rs.close();
			
			

	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>
<br/>
결제수단을 선택하세요 
<form action = "payment1.jsp?schedule_id=<%=schedule_id%>&total_price=<%=total_price%>" method = "POST">
<select name = "pay_method">
	<option value = "신용카드" selected = "selected">신용카드</option>
	<option value = "휴대폰결제">휴대폰결제</option>
</select>
<div><span class="inf">결제 가격 </span><%=total_price%></div>
<div class="btn">
<button type = "submit" value = "다음">다음</button>
</div>
</form>
	</fieldset>
</div>
</div>
</body>
<div id=footer></div>
</html>