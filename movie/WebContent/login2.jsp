<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�������� db�� ����</title>
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
		System.out.println("-------------Ʈ����------------------");
		//context.xml �ҷ�����
		Context init = new InitialContext();
		//connection pool���� ������ ���, java ��ο� ����ִ� context.xml�� name�� jdbc/OracleDB�� ��θ� ������
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		//�� db ��θ� �����ͼ� ������
		conn = ds.getConnection();
		//db�� sql�� ������
		PreparedStatement stmt = conn.prepareStatement(sql);
		//db ������Ʈ
		stmt.executeUpdate();

		System.out.println("-------------����Ϸ�------------------");
		out.println("<h3>����Ǿ����ϴ�.</h3>");
	} catch (Exception e) {
		out.println("<h3>���ῡ �����Ͽ����ϴ�.</h3>");
		e.printStackTrace();
	}finally{
		conn.close();
	}
	System.out.println("-------------�����̷�Ʈ------------------");
	//db�� �����͸� ���� ������ main ȭ������ �̵�
	response.sendRedirect("main.jsp");
%>
</body>
</html>