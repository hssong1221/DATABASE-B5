<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입후 db에 저장</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8");
	
	String id = (String) request.getParameter("my_id");
	String pwd = (String) request.getParameter("my_pwd");
	String mail = (String) request.getParameter("my_mail");
	String name = (String) request.getParameter("my_name");
	String num1 = (String) request.getParameter("my_num1");
	String num2 = (String) request.getParameter("my_num2");
	String phonenum = (String) request.getParameter("my_phonenum");
	
	request.getSession().setAttribute("id", id);
	Connection conn = null;

	String sql = "INSERT INTO client values ('" + id + "'," + "'" + pwd + "'," 
			+ "'" + num1 + "'," + "'" + num2 + "'," + "'" + phonenum + "'," + 0 + "," 
			+ "'" + name + "'," + "'" + mail + "')";
	try {
		System.out.println("-------------트라이------------------");
		//context.xml 불러오기
		Context init = new InitialContext();
		//connection pool에서 설정된 경로, java 경로에 들어있는 context.xml의 name인 jdbc/OracleDB의 경로를 가져옴
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		//내 db 경로를 가져와서 접속함
		conn = ds.getConnection();
		//db에 sql문 보내기
		PreparedStatement stmt = conn.prepareStatement(sql);
		//db 업데이트
		stmt.executeUpdate();

		System.out.println("-------------연결완료------------------");
		out.println("<h3>연결되었습니다.</h3>");
	} catch (Exception e) {
		out.println("<h3>연결에 실패하였습니다.</h3>");
		e.printStackTrace();
	}finally{
		conn.close();
	}
	System.out.println("-------------리다이렉트------------------");
	//db에 데이터를 전부 넣으면 main 화면으로 이동
	response.sendRedirect("main.jsp");
%>
</body>
</html>