<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
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
		<link href="./style/footer.css" type="text/css" rel="stylesheet" />
	</head>
	<body>
	<%
		session.invalidate();
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
	%>
	<div class='logodiv'>
		<img  class='logo' src='./style/logo.png' />
	</div>
	<hr class='logohr'/>
	<% 	
		String moviepage = "1";
		try{
			String sql = "select * from movie";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery(); %>
			<div class='menu'><a class='login' href = 'login.jsp'><button >로그인</button></a> 
			<a class='login' href = 'join.jsp'><button >회원가입</button></a></div><br/>
	<% 		
			while(rs.next()){
	%>		
				<div class='movie'>
					<a href ="m_info.jsp?moviepage=<%= rs.getString("movie_id")%>"><img class='poster'  src="image\<%=rs.getString("movie_id")%>.jpg"/></a>
					<p class='rating'><strong>예매율 : <%=rs.getString("booking_rate")%></strong></p>
					<p class='title'>
	<%				String age = rs.getString("grade");
					if(age =="전체") { %>
						<img class='age' src='./style/all.png'/>
	<% 				}
					else if( age =="12세"){ %>
						<img class='age' src='./style/12.png' />
	<% 				}
					else if( age=="15세"){ %>
						<img class='age' src='./style/15.png' />
	<% 				}
					else{									%>
						<img class='age' src='./style/19.png' />
	<%				} 
		
	%>
					<%=rs.getString("title") %></p> 
					<p class='gerne'><%=rs.getString("gerne") %></p>

				</div>


 
  	<%	} 
  	%>		 	
			
				

				<hr class='footerhr'/>
					<div class='footer'> <p class='footertext'>Made by B-5</p> </div>
	<% 
			rs.close();
			
		    
		}catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
				
	%>
	</body>
</html>