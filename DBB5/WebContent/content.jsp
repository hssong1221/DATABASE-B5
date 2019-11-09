<%@page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<%
	String num = request.getParameter("idx");
	ResultSet rs = null;
	Connection conn=null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	try{
	    Class.forName(driver);
	    conn=DriverManager.getConnection(url,"movie","movie"); //자신의 아이디와 비밀번호
	    out.print("연결에 성공하였습니다.");
	    
	    Statement stmt = conn.createStatement();        
	    
        String sql = "select * from board where idx = " + num;
 
        rs = stmt.executeQuery(sql);
        while(rs.next()){
%>
<body>
	<h1>게시글 조회</h1>
	<p>번호 : <%=rs.getString("idx")%></p>
	<p>작성자 : <%=rs.getString("writer")%></p>
	<p>날짜 : <%=rs.getString("regdate")%></p>
	<p>조회수 : <%=rs.getString("count")%></p>
	<h2>제목  : <%=rs.getString("title")%></h2>
	<p><%=rs.getString("content")%></p><br/>
	<a href="index.jsp">목록으로</a>
	<a href="delete.jsp?idx=<%=rs.getString("idx")%>">게시글삭제</a>
	

<%
        }
		conn.close();
	    
	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
			
%>


		
</body>
</html>