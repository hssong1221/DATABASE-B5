<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱 씨네마 - 내 정보</title>
<link href="./style/output.css" type="text/css" rel="stylesheet" />
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
	
	Connection conn = null;
	String id = (String)session.getAttribute("id");
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
try{
	String sql = "SELECT * FROM Client WHERE client_id='"+id+"'";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()){
		%>
		<div class="table">
		<table width="100%" height="80" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#9999FF">
	    <tr align="center">
	        <td colspan="2" align="center" bgcolor="skyblue">
	            <div style="font-weight: bold; font-size: 18px">회원 정보 조회
	            </div></td>
	    </tr>
	    <tr>
	        <td class="title">
	            <div style="font-weight: bold;">아이디:
	            </div></td>
	        <td>&nbsp <%= rs.getString("client_id") %> </td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">비밀번호:</div></td>
	        <td>&nbsp <%= rs.getString("client_pwd") %> </td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">메일주소:</div></td>
	        <td>&nbsp <%= rs.getString("address") %></td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">이름:</div></td>
	        <td>&nbsp <%= rs.getString("name") %></td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">주민등록번호:</div></td>
	        <td>&nbsp<%= rs.getString("num1") %>- *******</td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">휴대폰 번호:</div></td>
	        <td>&nbsp<%= rs.getString("phone_num") %></td>
	    </tr>
	    <tr>
	        <td class="title" ><div style="font-weight: bold;">마일리지:</div></td>
	        <td>&nbsp<%= rs.getString("mileage") %></td>
	    </tr>

	        	

		</table>
		<div class="btn">
	         <a href="update.jsp"><button class="btn1">수정</button></a>
	         <a href="delete.jsp"><button class="btn1">회원탈퇴</button></a>
			<a href="login.jsp"><button class="btn2">로그아웃</button></a>
			<a href="main.jsp"><button class="btn2">메인페이지</button></a>
		</div>
	</div>
	<%
	}
	rs.close();
			
	

}catch(Exception e){
	e.printStackTrace();
	
}finally{
	conn.close();
}

%>
</div>
</body>
<div id=footer></div>
</html>