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
	    conn=DriverManager.getConnection(url,"movie","movie"); //�ڽ��� ���̵�� ��й�ȣ
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    
	    Statement stmt = conn.createStatement();        
	    
        String sql = "select * from board where idx = " + num;
 
        rs = stmt.executeQuery(sql);
        while(rs.next()){
%>
<body>
	<h1>�Խñ� ��ȸ</h1>
	<p>��ȣ : <%=rs.getString("idx")%></p>
	<p>�ۼ��� : <%=rs.getString("writer")%></p>
	<p>��¥ : <%=rs.getString("regdate")%></p>
	<p>��ȸ�� : <%=rs.getString("count")%></p>
	<h2>����  : <%=rs.getString("title")%></h2>
	<p><%=rs.getString("content")%></p><br/>
	<a href="index.jsp">�������</a>
	<a href="delete.jsp?idx=<%=rs.getString("idx")%>">�Խñۻ���</a>
	

<%
        }
		conn.close();
	    
	}catch(Exception e){
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    e.printStackTrace();
	}
			
%>


		
</body>
</html>