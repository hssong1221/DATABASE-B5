<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ������ db �����Ϳ� ���ϱ�</title>
</head>
<body>
<% 		
	request.setCharacterEncoding("UTF-8");
	String id = (String) request.getParameter("my_id");
	String pwd = (String) request.getParameter("my_pwd");

	//���� �������� �� id ���� �־ session�� ���
	request.getSession().setAttribute("id", id);

	//db�� ������ ��ü �����
	Connection conn = null;
	//�α����� �����Ͱ� db�ȿ� �ִ� ���������� ��ȸ�� ������
	String sql = "SELECT * FROM client WHERE client_id='" + id + "'";
	
	
	try {
		System.out.println("-------------Ʈ����------------------");
		//context.xml �ҷ�����
		Context init = new InitialContext();
		//connection pool���� ������ ���, java ��ο� ����ִ� context.xml�� name�� jdbc/OracleDB�� ��θ� ������
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		//�� db ��θ� �����ͼ� ������
		conn = ds.getConnection();
		//�������� db�� ����
		PreparedStatement stmt = conn.prepareStatement(sql);
		//db ������Ʈ
		stmt.executeUpdate();
		//�� �޾ƿü� �ִ� ��ü �����
		ResultSet rs = stmt.executeQuery();

		//���� db�ȿ� ���� ��� ������
		if (rs.next()) {
			//�α������� �Է��� id�� ��й�ȣ�� db�ȿ� �ִ� id�� ��й�ȣ�� ��ġ�Ҷ� ���� �������� �̵�
			if (id.equals(rs.getString("client_id")) == true & pwd.equals(rs.getString("client_pwd")) == true) {
				rs.close();
				response.sendRedirect("main.jsp");
			}else if(id.equals(rs.getString("client_id")) == true & pwd.equals(rs.getString("client_pwd")) == false){
				rs.close();
%>
				<script>
					alert("���̵� ��й�ȣ�� �߸��Ǿ����ϴ�.");
					history.back();
				</script>
<%
			}
		} else {//���� db�ȿ� ���� ������
			rs.close();
%>
<script>
	alert("���̵� ��й�ȣ�� �߸��Ǿ����ϴ�.");
	history.back();
</script>
<%
	}

		System.out.println("-------------����Ϸ�------------------");
		out.println("<h3>����Ǿ����ϴ�.</h3>");
	} catch (Exception e) {
		out.println("<h3>���ῡ �����Ͽ����ϴ�.</h3>");
		e.printStackTrace();
	}finally{
		conn.close();
	}
	System.out.println("-------------�����̷�Ʈ--------------------");
%>
</body>
</html>