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
		
		if (self.name != 'reload') {
	         self.name = 'reload';
	         self.location.reload(true);
	     }
	    else self.name = ''; 
	</script>
</head>
<div id=head></div>
<body>
<div class="maindiv">
<%!
	
	public void rate(String movie_id) throws Exception{
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		int ticketing_count = 0;
		int ticketing_count1 = 0;
		
		try{
			String sql = "select count(ticketing_id) from ticketing";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
		    
			while(rs.next()) {
		       ticketing_count = rs.getInt("count(ticketing_id)");
				}
			
			
		    sql = "select count(ticketing_id) from schedule natural join ticketing where movie_id = '"+movie_id+"'";
		    stmt = conn.prepareStatement(sql);
		    rs = stmt.executeQuery();
		    while(rs.next()) {
		       ticketing_count1 = rs.getInt("count(ticketing_id)");
		    }
		    
		    float booking_rate = Float.parseFloat(String.format("%.2f", (float)ticketing_count1 / (float)ticketing_count * 100));
		    
		    sql = "update movie set booking_rate ="+booking_rate+" where movie_id='"+movie_id +"'";
		    stmt = conn.prepareStatement(sql);
		    stmt.executeUpdate();
		}catch(Exception e){
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
}

%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String admin = "admin";
	
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	String moviepage = "1";
%>	

<%
	try{
		if(id.equals(admin)){
%>

			<script>location.href="admin.jsp"; </script>
<%
		}else{
			//사용자 모드 일때 오직 사용자 개인의 정보만 가져올 수 있다.
			String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
			PreparedStatement stmt = conn.prepareStatement(sql2);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){%>
				<div class="hed">
				<a href="output.jsp"><button>내 정보 보러가기</button></a>
				<a href ="ticketing_list.jsp"><button>예매 내역</button></a>
				<a href="index.jsp"><button>로그아웃</button></a>
				<a href = "ticketing.jsp"><button>예매</button></a>
				<span class="loging"><%= rs.getString("name") %> 님</span>
				</div>
<% 			}%>
			<div style="text-align:center;">
			<h1>현재상영작</h1>
			
<%			String sql3 = "select * from movie where opendate <= TO_CHAR(SYSDATE,'YYYYMMDD')";
			stmt = conn.prepareStatement(sql3);
			rs = stmt.executeQuery();
			while(rs.next()){
				rate(rs.getString("movie_id"));
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
  	<%	} %>
  		</div>
  		<div style = "clear:both;text-align:center;">
  			<h1>상영예정작</h1>
 <%			String sql4 = "select * from movie where opendate > TO_CHAR(SYSDATE,'YYYYMMDD')";
			stmt = conn.prepareStatement(sql4);
			rs = stmt.executeQuery();
			while(rs.next()){
				rate(rs.getString("movie_id"));
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
  	<%	} %>
 		</div> 
  		 	
			


<% 			rs.close();
			
			
		}%>

	</div>	
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