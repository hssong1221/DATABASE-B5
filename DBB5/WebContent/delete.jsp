<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<%
	String num = request.getParameter("idx");
	Connection conn=null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	try{
	    Class.forName(driver);
	    conn=DriverManager.getConnection(url,"movie","movie"); //자신의 아이디와 비밀번호
	    out.print("연결에 성공하였습니다.");
	    
	    Statement stmt = conn.createStatement();        
	    
        String sql = "delete from board where idx = "+ num;
 
        stmt.executeUpdate(sql);
       
		conn.close();
	    
	}catch(Exception e){
	    out.println("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	
%>
<script>
	alert("게시글이 삭제되었습니다.");
	location.href = "redirect.jsp";
</script>
<body>
</body>
</html>