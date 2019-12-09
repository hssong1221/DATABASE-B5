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
<link href="./style/ticketing_list.css" type="text/css" rel="stylesheet" />
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	$(document).ready( function() {
		$("#head").load("./style/head.html");
		$("#footer").load("./style/footer.html");
	});
	
	
	function delchk(){
	       return confirm("예매취소하시겠습니까?");
	}
</script>


</head>
<div id=head></div>
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
		<span class="loging"><%= rs.getString("name") %> 님</span>
	<%
	}
	ResultSet rs1 = stmt.executeQuery();
	
	
	String sql1 = "select schedule_id, ticketing_id, total_price, screening_date, title,theater_num,start_time,paydate from payment natural join ticketing natural join schedule natural join movie WHERE client_id='"+id+"' order by ticketing_id";
	stmt = conn.prepareStatement(sql1);
	rs = stmt.executeQuery();
	String sql2 = "select ticketing_id, LISTAGG(seat_name,', ') within group (order by seat_name) name from ticketing natural join ticketing_seat natural join seat natural join payment where client_id = '"+ id +"' group by ticketing_id order by ticketing_id";
	stmt = conn.prepareStatement(sql2);
	rs1 = stmt.executeQuery();
%>
	
<div class="maindiv">
	
	<div class="new">
		<fieldset><legend>예매 내역</legend>
<%	if(rs.next()&&rs1.next()){%>
			                 <br/>
			<%do{%>
			<div class="movie">
				<%
				String date = rs.getString("paydate");
				String month = date.substring(3,5);
				String day = date.substring(6);
				%>
				<label><span class="inf">상영관</span>   <%=rs.getString("theater_num")%> </label>
				<label><span class="inf">좌석번호</span> 
								<%=rs1.getString("name")%> 
							
				</label>
				<label><span class="inf">결제날짜 </span> <%=month%>/<%=day%> </label>

				<label><span class="inf">상영일</span>	<%=rs.getString("screening_date")%>  </label>
				<label><span class="inf">시작시간 </span> <%=rs.getString("start_time")%>  </label>
				<label><span class="inf">영화제목 </span> <%=rs.getString("title")%>   </label>
				<label><span class="inf">결제가격 </span> <%=rs.getString("total_price")+'원'%>   </label>
				<label><span class="inf">예매번호 </span> <%=rs.getString("ticketing_id")%>   </label>
				<div class="btn">
				<a onclick="return delchk();" href="cancel.jsp?ticketing_id=<%=rs.getString("ticketing_id")%>&schedule_id=<%=rs.getString("schedule_id")%>"><button>예매 취소</button></a></div>
			</div>
			<% }while(rs.next()&&rs1.next());
			}
		else{
			out.println("예매 내역이 없습니다.<br/>");
		}
%>	
	

	<div class="btn"><a href = "main.jsp"><button>메인으로</button></a></div>
	</fieldset>
	</div>
<%	rs.close();
	rs1.close();
}catch(Exception e){
	out.println("연결이 끊겼습니다.");
	e.printStackTrace();
	
}finally{
	conn.close();
}
%>
</div>
</body>
<div id=footer></div>
</html>