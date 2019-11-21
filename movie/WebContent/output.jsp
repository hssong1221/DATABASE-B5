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
		<div class="new">
		<fieldset>
            <legend>회원 정보 조회</legend>
            <label><span>아이디<span class="required">*</span></span> <%= rs.getString("client_id") %></label>
            <label><span>비밀번호<span class="required">*</span></span> <%= rs.getString("client_pwd") %></label>
	        <label><span>메일주소<span class="required">*</span></span> <%= rs.getString("address") %></label>
	        <label><span>이름<span class="required">*</span></span> <%= rs.getString("name") %></label>
	        <label><span>주민등록번호<span class="required">*</span></span> <%= rs.getString("num1") %>- *******</label>
	        <label><span>휴대폰번호<span class="required">*</span></span> <%= rs.getString("phone_num") %></label>
	        <label><span>마일리지<span class="required">*</span></span> <%= rs.getString("mileage") %></label>
	   </fieldset>
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