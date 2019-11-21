<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보 삭제</title>
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

	String id = (String)session.getAttribute("id");

	Connection conn = null;
	//만약 내가 삭제할 id가 db안에 있는 id와 같을때 삭제할 쿼리문
	String sql = "DELETE FROM client WHERE client_id='" + id + "'";

	try {
		System.out.println("-------------트라이------------------");
		//context.xml 불러오기
		Context init = new InitialContext();
		//connection pool에서 설정된 경로, java 경로에 들어있는 context.xml의 name인 jdbc/OracleDB의 경로를 가져옴
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		//내 db 경로를 가져와서 접속함
		conn = ds.getConnection();
		//삭제
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();

		//삭제후 다시 출력화면으로 돌아감
		response.sendRedirect("index.jsp");

		System.out.println("-------------연결완료------------------");
		out.println("<h3>연결되었습니다.</h3>");
	} catch (Exception e) {
		out.println("<h3>연결에 실패하였습니다.</h3>");
		e.printStackTrace();
	}finally{
		conn.close();
	}
	System.out.println("-------------리다이렉트--------------------");
%>
	</div>
</body>
<div id="footer" > </div>
</html>