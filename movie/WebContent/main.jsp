<%@page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ���׸�</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String admin = "admin";
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	try{
		if(id.equals(admin)){
			String sql1 = "SELECT * FROM client";
			PreparedStatement stmt = conn.prepareStatement(sql1);
			ResultSet rs = stmt.executeQuery();
			%>
			
			<h1>�����ڷ� �α��� �ϼ̽��ϴ�.</h1><br/>
			<a href="admin.jsp">��ȭ�� ���� </a>
			<a href="login.jsp">�α׾ƿ�</a>
			
			<%
			rs.close();
		}else{
			//����� ��� �϶� ���� ����� ������ ������ ������ �� �ִ�.
			String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
			PreparedStatement stmt = conn.prepareStatement(sql2);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){%>
				<h2><%= rs.getString("name") %> ���� �α��� �ϼ̽��ϴ�.</h2><br/>
				<a href="output.jsp">�� ���� ��������</a>
				<a href="login.jsp">�α׾ƿ�</a><br/>
<%
				}
			String sql3 = "select * from movie";
			stmt = conn.prepareStatement(sql3);
			rs = stmt.executeQuery();
			while(rs.next()){
%>
			<body>
				<br/>
				<a href ="m_info.jsp"><img width = "20%" src="image\<%=rs.getString("movie_id")%>.jpg"/></a>
				<strong>������ <%=rs.getString("booking_rate")%></strong>
				<a href = "ticketing.jsp?id=<%=rs.getString("movie_id")%>">�ٷο���</a>
<%}
			rs.close();
			}
	    
	}catch(Exception e){
	    out.print("���ῡ �����Ͽ����ϴ�.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
			
%>


		
</body>
</html>