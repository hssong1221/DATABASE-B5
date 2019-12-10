<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입후 db에 저장</title>
</head>
<body>
<%!
	
	public boolean isduplicate(String id) throws Exception{
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		try{
			String sql = "select client_id from client";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
		    
			while(rs.next()) {
				if(rs.getString("client_id").equals(id)){
					return true;
			}
				}
			
			
		    
		}catch(Exception e){
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
}

%>
	<% request.setCharacterEncoding("UTF-8");
	
	String id = (String) request.getParameter("my_id");
	String pwd = (String) request.getParameter("my_pwd");
	String mail = (String) request.getParameter("my_mail");
	String name = (String) request.getParameter("my_name");
	String num1 = (String) request.getParameter("my_num1");
	String num2 = (String) request.getParameter("my_num2");
	String phonenum = (String) request.getParameter("my_phonenum");
	
	Connection conn = null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	if(isduplicate(id)){%>
		<script>
			alert("이미 존재하는 ID입니다");
			history.back(-1);
		</script>
	<%}
	else{
		request.getSession().setAttribute("id", id);
	
		try {
			System.out.println("-------------트라이------------------");
			
			String sql = "INSERT INTO client values ('" + id + "'," + "'" + pwd + "'," 
				+ "'" + num1 + "'," + "'" + num2 + "'," + "'" + phonenum + "'," + 0 + "," 
				+ "'" + name + "'," + "'" + mail + "')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
	
			System.out.println("-------------연결완료------------------");
			out.println("<h3>연결되었습니다.</h3>");
		} catch (Exception e) {
			out.println("<h3>연결에 실패하였습니다.</h3>");
			e.printStackTrace();
		}finally{
			conn.close();
		}
		System.out.println("-------------리다이렉트------------------");
		//db에 데이터를 전부 넣으면 main 화면으로 이동
		response.sendRedirect("main.jsp");
	}
%>
</body>
</html>