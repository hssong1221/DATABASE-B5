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
	
	if(title == "" || title == null) out.println("title��  null�Դϴ�.");
	
	if(writer == ""||writer == null)
		out.println("writer��  null�Դϴ�.");
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer))
	    out.println("�̸��� ������ �ƴմϴ�.");
	 
	if(content == "" ||content == null) out.println("content�� null�Դϴ�.");
	
	Connection conn=null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
	try{
	    Class.forName(driver);
	    conn=DriverManager.getConnection(url,"movie","movie"); //�ڽ��� ���̵�� ��й�ȣ
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    Statement stmt = conn.createStatement();            // SQL ������ ���������� Statement ��ü ����
	    
	    String sql = "INSERT INTO BOARD "+
	    
	                   "(IDX, TITLE, WRITER, REGDATE, COUNT, CONTENT) "+
	    
	                   "VALUES (movie_seq.nextval, '"+title+"', '"+writer+"', sysdate, '1', '"+content+"')";
	    
	    stmt.executeUpdate(sql);   
	    conn.close();
	}catch(Exception e){
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    e.printStackTrace();
	}
	finally{
		out.print("<script>location.href='index.jsp';</script>");
	}
%>
	
	
<body>

</body>
</html>