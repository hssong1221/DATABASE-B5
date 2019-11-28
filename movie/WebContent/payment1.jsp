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
<link href="./style/payment1.css" type="text/css" rel="stylesheet" />
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
	String pay_method = request.getParameter("pay_method");
	String total_price = request.getParameter("total_price");
	try{
		String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		%>
			<p class="loging"><%= rs.getString("name") %> 님</p>
		<%}
		String sql2 = "SELECT * FROM schedule natural join movie WHERE schedule_id='"+schedule_id+"'";
		stmt = conn.prepareStatement(sql2);
		rs = stmt.executeQuery();
%>
		<div class="new">
		<fieldset><legend>결제</legend>
<%	
		while(rs.next()){
		%>
			<label><span>상영일 </span><%=rs.getString("screening_date")%></label>
			<label><span>시작시간 </span> <%=rs.getString("start_time")%></label>
			<label><span>상영관 </span> <%=rs.getString("theater_num")%></label>
			<label><span>영화제목</span> <%=rs.getString("title")%></label>
			
		<%
		
		}
		
		rs.close();%>
		<br/>
		결제정보를 입력하세요
		<form action = "complete.jsp?schedule_id=<%=schedule_id%>&pay_method=<%=pay_method%>&total_price=<%=total_price%>" method = "POST">
		<select disabled>
			<option><%=pay_method%></option>
		</select><br/>
		<% if(pay_method.equals("신용카드")){%>
			<label><span>카드선택 </span> <select name = "card_type">
						<option value = "현대카드">현대카드</option>
						<option value = "현대카드">하나카드</option>
						<option value = "현대카드">우리카드</option>
						<option value = "현대카드">신한카드</option>
						<option value = "현대카드">국민카드</option>
						<option value = "현대카드">ibk기업카드</option>
					</select></label>
			<label><span>카드번호</span>  <input name = "card_num" type="text" placeholder = "카드번호"/></label>
			<label><span>카드 유효기간</span> <input name = "card_limit" type="text" placeholder = "MM/YY"/></label>
			<label><span>카드 비밀번호</span>  <input name = "card_pwd" type="password" placeholder = "카드 비밀번호"/></label>
			<label><span>cvc 번호</span>  <input name = "card_cvc" type="password" placeholder = "카드 뒷면 cvc 3자리"/></label>
		<% }else{%>
			<label><span>통신사 </span> <select name = "telecom">
					<option value = "SKT" selected= "selected">SKT</option>
					<option value = "KT">KT</option>
					<option value = "LG유플러스">LG유플러스</option>
				  </select></label>
			<label><span>휴대폰번호</span> <input name = "phone_num" type="text" placeholder = "휴대폰번호"/></label>
			<label><span>결제비밀번호</span> <input name = "pay_pwd" type="password" placeholder = "결제 비밀번호"/></label>
		<%}%>
		<label><span>결제 가격 </span> <%=total_price%> </label>
		<div class="btn">
			<button type = "submit" value = "결제">결제</button>
		</div>
		</form>			
	<% }catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>
<br/><br/>
</fieldset>
</div>
</div>
</body>
<div id=footer></div>
</html>