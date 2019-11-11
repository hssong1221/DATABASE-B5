<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
		request.setCharacterEncoding("UTF-8");

		String pwd = (String) request.getParameter("my_pwd");
		String mail = (String) request.getParameter("my_mail");
		String phonenum = (String) request.getParameter("my_phonenum");
		Connection conn = null;
		
		String sql = "UPDATE client SET client_pwd='" + pwd + "', address='" + mail + "',phone_num='" 
			+ phonenum + "' WHERE client_id='" + session.getAttribute("id") + "'";
		try {
			System.out.println("-------------트라이------------------");
			//context.xml 불러오기
			Context init = new InitialContext();
			//connection pool에서 설정된 경로, java 경로에 들어있는 context.xml의 name인 jdbc/OracleDB의 경로를 가져옴
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			//내 db 경로를 가져와서 접속함
			conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			ResultSet rs = pstmt.executeQuery();

			rs.close();
			response.sendRedirect("output.jsp");

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
</body>
</html>