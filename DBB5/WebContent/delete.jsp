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
	    conn=DriverManager.getConnection(url,"movie","movie"); //�ڽ��� ���̵�� ��й�ȣ
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    
	    Statement stmt = conn.createStatement();        
	    
        String sql = "delete from board where idx = "+ num;
 
        stmt.executeUpdate(sql);
       
		conn.close();
	    
	}catch(Exception e){
	    out.println("���ῡ �����Ͽ����ϴ�.");
	    e.printStackTrace();
	}
	
%>
<script>
	alert("�Խñ��� �����Ǿ����ϴ�.");
	location.href = "redirect.jsp";
</script>
<body>
</body>
</html>