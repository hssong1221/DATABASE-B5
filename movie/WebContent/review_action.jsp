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
		<title>리뷰 작성</title>
	</head>
	<body>
		<div class ="maindiv">
		<%
		request.setCharacterEncoding("UTF-8");
		//입력한 값들 받아오기 
		String moviep = (String) request.getParameter("moviepage");
		String rating = (String) request.getParameter("rating");
		String review = (String) request.getParameter("review");
		//db 연결
		Connection conn= null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		// 변수 선언
		String id = "";
		String[] movie = null;
		
		//로그인 확인
		try {
			id = (String)session.getAttribute("id");
			
			if(id==null || id.equals("")) {
				// 로그인 안했을 시 로그인페이지로 리다이렉트
				response.sendRedirect("login.jsp");
			}
			else {
				//로그인 됬을 때
				try {
					String sql = "select distinct movie_id from client natural join payment natural join ticketing natural join schedule where client_id = '"+ id + "'";
					Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()){
						rs.last();
						int row = rs.getRow();
						movie = new String[row];
						rs.first();
						
						for(int i=0; i < row; i++){
					        movie[i] = rs.getString("movie_id");
					        rs.next();
						}
					}
					else{
						movie = new String[1];
					}
					

					   
					System.out.println(movie[0]);
					// 현재 보고 있는 페이지의 영화와 내가 본영화가 일치하는지 확인
					if (Arrays.asList(movie).contains(moviep)) {
						//일치하면 sql로 리뷰 db에 업로드
						try {
							String sql2 = "INSERT INTO review VALUES (review_id_seq.nextval,?,?,?,?)";
							PreparedStatement stmt2 = conn.prepareStatement(sql2);
							stmt2.setString(1, id);
							stmt2.setString(2, moviep);
							stmt2.setString(3, review);
							stmt2.setString(4, rating);
							stmt2.executeUpdate();
							rs.close();
							%>
							
							<script>
							alert("리뷰가 등록되었습니다!");
							location.href="m_info.jsp?moviepage=<%=moviep%>"; 
							</script>
							
							<%
						}
						catch(Exception e){
						    out.print("연결에 실패하였습니다.");
						    e.printStackTrace();
						}
						finally{
							conn.close();
						}
						
						
					}
					else {
						//일치 하지 않으면 영화를 봐주세요 출력
						%>
						<script>
						alert("영화를 보고 리뷰를 작성해주세요!");
						history.go(-1);
						</script>
						<% 
					}
					
				}
				catch(Exception e){
				    out.print("연결에 실패하였습니다.");
				    e.printStackTrace();
				}
				finally{
					conn.close();
					}
				}
			}
		catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
		%>
		
		</div>
	
	</body>
</html>