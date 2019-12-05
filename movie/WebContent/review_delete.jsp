<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.lang.reflect.Array"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>리뷰 삭제</title>
	</head>
	<body>
		<div class ="maindiv">
		<%
		request.setCharacterEncoding("UTF-8");
		//값 받아오기
		//변수들 선언
		String id = "";
		String review_id = request.getParameter("id");
		String select_id = "";
		String moviep = request.getParameter("moviepage");
		//db 연결
		Connection conn= null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		//try catch
		try {
			id = (String)session.getAttribute("id");
			if (id == null || id.equals("")) {
				%>
				<script>
				alert("로그인 해주세요!");
				location.href="m_info.jsp?moviepage=<%=moviep%>";
				</script>
				<% 
			}
			else if (id == "admin" || id.equals("admin")){
				String sql3 = "delete from review where review_id = ?";
				PreparedStatement stmt3 = conn.prepareStatement(sql3);
				stmt3.setString(1, review_id);
				stmt3.executeUpdate();
				
				%>
				<script>
				alert("관리자 권한으로 삭제하였습니다.")
				location.href="m_info.jsp?moviepage=<%=moviep%>";
				</script>
				
				<% 
			}
			else {
				try {
					String sql = "select client_id from review where review_id = ?";
					PreparedStatement stmt = conn.prepareStatement(sql);
					stmt.setString(1, review_id);
					ResultSet rs = stmt.executeQuery();
					while (rs.next()) {
						select_id = rs.getString("client_id");
						if (id.equals(select_id)) {
							 
							String sql2 = "delete from review where review_id = ?";
							PreparedStatement stmt2 = conn.prepareStatement(sql2);
							stmt2.setString(1, review_id);
							stmt2.executeUpdate();
							
							%>
							<script>
							alert("리뷰가 삭제되었습니다.");
							location.href="m_info.jsp?moviepage=<%=moviep%>";
							</script>
							<% 
							}
						else {
							%>
							<script>
							alert("작성자가 일치하지 않습니다.");
							location.href="m_info.jsp?moviepage=<%=moviep%>";
							</script>
							<% 
						}
						rs.close();

					}
				}
				catch(Exception e){
				    out.print("1연결에 실패하였습니다.");
				    e.printStackTrace();
				}
				finally{
					conn.close();
					}
				}
			
				
			}
		catch(Exception e){
		    out.print("2연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
			}
		
		%>
		</div>
	
	</body>
</html>