<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("euc-kr");
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	if(title == "" || title == null) out.println("title이  null입니다.");
	
	if(writer == ""||writer == null)
		out.println("writer가  null입니다.");
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer))
	    out.println("이메일 형식이 아닙니다.");
	 
	if(content == "" ||content == null) out.println("content가 null입니다.");
	
	Connection conn=null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
	try{
	    Class.forName(driver);
	    conn=DriverManager.getConnection(url,"movie","movie"); //자신의 아이디와 비밀번호
	    out.print("연결에 성공하였습니다.");
	    Statement stmt = conn.createStatement();            // SQL 쿼리를 날리기위한 Statement 객체 생성
	    
	    String sql = "INSERT INTO BOARD "+
	    
	                   "(IDX, TITLE, WRITER, REGDATE, COUNT, CONTENT) "+
	    
	                   "VALUES (movie_seq.nextval, '"+title+"', '"+writer+"', sysdate, '1', '"+content+"')";
	    
	    stmt.executeUpdate(sql);   
	    conn.close();
	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		out.print("<script>location.href='index.jsp';</script>");
	}
%>
	
	
<body>

</body>
</html>