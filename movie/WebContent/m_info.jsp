<%@page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>콱 씨네마</title>
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	    <script type="text/javascript">
	    $(document).ready( function() {
	        $("#head").load("./style/head.html");
	        $("#footer").load("./style/footer.html");
	    });

	    </script>
	    <link href="./style/m_info.css" type="text/css" rel="stylesheet" />
	</head>
	<div id="head" > </div>
	<body>
	<div class="maindiv">
	<%
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		

		String id = (String)session.getAttribute("id");
		String moviepage = request.getParameter("moviepage");
		String rating = "0";
		int count = 0;
		try{
			String sql = "SELECT * FROM movie WHERE movie_id = '" + moviepage + "'";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			String sql1 = "SELECT * FROM client WHERE client_id='"+id+"'";
			PreparedStatement stmt1 = conn.prepareStatement(sql1);
			ResultSet rs1 = stmt1.executeQuery();
			while(rs1.next()){
			%>
				<span class="loging"><%= rs1.getString("name") %> 님</span>
			<%
			}

			String sql2 = "SELECT * FROM review WHERE movie_id = '"+ moviepage +"'";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = stmt2.executeQuery();
			
			String sql4 = "select count(rating) from review where movie_id = '" + moviepage + "'";
			PreparedStatement stmt4 = conn.prepareStatement(sql4);
			ResultSet rs4 = stmt4.executeQuery();
			while(rs4.next()){
				count = rs4.getInt("count(rating)");
			}
			
			String sql3 = "select avg(rating) from review where movie_id = '" + moviepage+ "'";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			ResultSet rs3 = stmt3.executeQuery();
			
			
			if(count != 0){
				while(rs3.next()){
					rating = String.format("%.2f", Float.parseFloat(rs3.getString("avg(rating)")));
				}
			}
			
			rs1.close();
			rs3.close();
			rs4.close();
			while(rs.next()){
	%>
		<div class="new">
			<img class="movie" width = "30%" src="image\<%=rs.getString("movie_id")%>.jpg"/>
			<div class="information">
				<label><span>영화제목 :</span> <%=rs.getString("title")%> </label>
				<label><span>감독 : </span><%=rs.getString("director")%> </label>
				<label><span>배우 : </span><%=rs.getString("actor")%> </label>
				<label><span>상영등급 :</span> <%=rs.getString("grade")%> </label>
				<label><span>장르 : </span><%=rs.getString("genre")%> </label>
				<label><span>평점 : </span><%=rating%></label>
				<label><span>예매율 : </span><%=rs.getString("booking_rate")%> </label>
				<label><span>상영시간 : </span><%=rs.getString("run_time")%> </label>
				<label><span>줄거리 : </span><%=rs.getString("plot")%> </label>
			</div>
			
		</div>
	<%	}
			rs.close();
			%>
			<div class="mainreview">
			<fieldset><legend>리뷰 작성</legend>
			<form method = "post" action="review_action.jsp?moviepage=<%= moviepage%>">
			평점<br/>
			<select name="rating">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5" selected="selected">5</option>
			</select>
			<br/>
			리뷰<br/><textarea class ="text" id="review" name="review" 
			placeholder="리뷰를 입력하세요" required></textarea>
			<br/>
			<button type = "submit" value ="등록">등록</button>
			</form>
			</fieldset>
			</div>

			<div class="bottomreview">
			<hr />
		<% 
			while(rs2.next()) {
			%>
			
			
			<div class="review"> 
				<%=rs2.getString("CLIENT_ID") %> |  
				<%if(rs2.getString("RATING").equals("1")){%>
					<img class="star" src='./style/1.png'/>
				<%}
				else if(rs2.getString("RATING").equals("2")){%>
					<img class="star" src='./style/2.png'/>
				<%}
				else if(rs2.getString("RATING").equals("3")){%>
					<img class="star" src='./style/3.png'/>
				<%}
				else if(rs2.getString("RATING").equals("4")){%>
					<img class="star" src='./style/4.png'/>
				<%}
				else{%>
					<img class="star" src='./style/5.png'/>
				<%}
				%>
					 | <%=rs2.getString("RATING") %>  점
			</div>
			<div class="review"> <%=rs2.getString("CONTENT") %></div>
			<button type="button" onclick ="location.href='review_delete.jsp?id=<%= rs2.getString("REVIEW_ID")%>'">삭제</button>
			<button type="button" onclick ="location.href='review_modify.jsp?id=<%= rs2.getString("REVIEW_ID")%>'">수정</button>
			<hr />
			
  <% }%>
			</div>
<%
		rs2.close();
		}catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
				
	%>
	
	</div>
	</body>
	<div id="footer" > </div>
</html>