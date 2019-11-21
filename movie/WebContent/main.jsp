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
	<link href="./style/index.css" type="text/css" rel="stylesheet" />
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready( function() {
			$("#head").load("./style/head.html");
			$("#footer").load("./style/footer.html");
		});
	</script>
</head>
<div id=head></div>
<body>
<div class="maindiv">

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String admin = "admin";
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	
	String moviepage = "1";
	
	try{
		if(id.equals(admin)){
			String sql1 = "SELECT * FROM client";
			PreparedStatement stmt = conn.prepareStatement(sql1);
			ResultSet rs = stmt.executeQuery();
			
			String sql2 = "SELECT * FROM client";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = stmt2.executeQuery();
			%>
			<h1>관리자로 로그인 하셨습니다.</h1><br/>
			<p>!금일 수익!</p>
			<% 
			while(rs2.next()){ %>
			
				<%= rs2.getString("client_id") %>
			<% }
			
			%>
			
			<a href="admin.jsp">영화관 관리 </a><br/>
			<a href="index.jsp">로그아웃</a>
			
			<%
			rs.close();
		}else{
			//사용자 모드 일때 오직 사용자 개인의 정보만 가져올 수 있다.
			String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
			PreparedStatement stmt = conn.prepareStatement(sql2);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){%>
				<h2><%= rs.getString("name") %> 님이 로그인 하셨습니다.</h2><br/>
				<div>
				<a href="output.jsp"><button>내 정보 보러가기</button></a>
				<a href ="ticketing_list.jsp"><button>예매 내역</button></a>
				<a href="index.jsp"><button>로그아웃</button></a>
				<a href = "ticketing.jsp"><button>예매</button></a><br/>
				</div>
<% 			}
			String sql3 = "select * from movie";
			stmt = conn.prepareStatement(sql3);
			rs = stmt.executeQuery();
			while(rs.next()){
%>
			<div class='movie'>
					<a href ="m_info.jsp?moviepage=<%= rs.getString("movie_id")%>"><img class='poster'  src="image\<%=rs.getString("movie_id")%>.jpg"/></a>
					<p class='rating'><strong>예매율 : <%=rs.getString("booking_rate")%></strong></p>
					<p class='title'>
	<%				String age = rs.getString("grade");				
					if(age.equals("전체")) { %>
						<img class='age' src='./style/all.png'/>
	<% 				}
					else if( age.equals("12세")) { %>
						<img class='age' src='./style/12.png' />
	<% 				}
					else if( age.equals("15세")) { %>
						<img class='age' src='./style/15.png' />
	<% 				}
					else{									%>
						<img class='age' src='./style/19.png' />
	<%				} 
		
	%>
					<%=rs.getString("title") %></p> 
					<p class='genre'><%=rs.getString("genre") %></p>

		</div>


 
  	<%	} 
  		 	
			


			rs.close();
			
			
		}%>
		
<%	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}
			
%>

</div>
		
</body>
<div id=footer></div>
</html>