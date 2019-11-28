<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱씨네마 - 예매완료</title>
<link href="./style/complete.css" type="text/css" rel="stylesheet" />
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
	int total_price = Integer.parseInt(request.getParameter("total_price"));

	
	try{
		String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		%>
			<span class="loging"><%= rs.getString("name") %> 님</span>
		<%
		}

		
		String sql1 = "update seat_schedule set status = 1 where schedule_id = '" + schedule_id + "' and seat_id = some(select seat_id from seat natural join seat_schedule natural join seat_before where schedule_id = '" + schedule_id + "')";
		stmt = conn.prepareStatement(sql1);
		stmt.executeUpdate();
		
		String sql2 = "insert into ticketing values(ticketing_seq.nextval,'" + schedule_id + "')";
		stmt = conn.prepareStatement(sql2);
		stmt.executeUpdate();
		
		String sql4 = "insert into ticketing_seat(ticketing_id,seat_id) select ticketing_seq.currval, seat_id from seat natural join seat_schedule natural join seat_before where schedule_id = '" + schedule_id + "'";
		stmt = conn.prepareStatement(sql4);
		stmt.executeUpdate();
		
		String sql5 = "insert into payment(pay_num,pay_method,total_price,ticketing_id,client_id, paydate) values(payment_seq.nextval, '" + pay_method + "'," + total_price + ",ticketing_seq.currval,'"+ id +"' ,sysdate)";
		stmt = conn.prepareStatement(sql5);
		stmt.executeUpdate();
		
		
		String sql6 = "update client set mileage = mileage +"+ total_price*0.1 +" where client_id = '" + id + "'";
		stmt = conn.prepareStatement(sql6);
		stmt.executeUpdate();
		
	    
	    
			rs.close();%>
		<div class="new">
		<fieldset><legend>예매완료</legend>
			<span class="inf">예매가 완료되었습니다.</span><br/><br/>
			<span ><%=(int)(total_price*0.1)%><span> <span class="inf">마일리지가  적립됐습니다.<span> <br/><br/><br/>
			<a href = "ticketing_list.jsp"><button>예매내역</button></a>
			<a href = "main.jsp"><button>메인으로</button></a>
		</fieldset>
	<% }catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
	
%>
</div>
</div>
</body>
<div id=footer></div>
</html>