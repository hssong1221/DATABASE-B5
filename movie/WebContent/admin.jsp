<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
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
		<title>영화관 관리</title>
		<link href="./style/admin.css" type="text/css" rel="stylesheet" />
		<script src = "js/join.js"></script>
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
		$(document).ready( function() {
			$("#head").load("./style/head.html");
			$("#footer").load("./style/footer.html");
		});
		</script>
	</head>
<div id="head" > </div>
<body>
	<div class="maindiv">
	<br/>
	<nav>
		<ul>
			<li><a href = #nowmovie>현재 상영중인 영화</a></li>
			<li><a href = #ctable>고객 정보</a></li>
			<li><a href = #money>날짜별 수익</a></li>
			<li><a href = #mmoney>월별 수익</a></li>
			<li><a href = #dtlist>결제일 기준 예매 리스트</a></li>
		</ul>
	</nav>
	<%
		request.setCharacterEncoding("UTF-8");
		Connection conn=null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		try{
			String sql = "select * from movie";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			String sql2 = "select * from client";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = stmt2.executeQuery();
			
			
	 %>
		<br/>
		<div>
			<h1>관리자로 로그인 하셨습니다.</h1><br/>

			<br/>
			<a href="index.jsp"><button>로그아웃</button></a>



			<p id = "nowmovie">현재 상영중인 영화</p>
	<% 
			while(rs.next()){
	%>		
			<%= rs.getString("movie_id") %>
			<img class="movieimg"  src="image\<%=rs.getString("movie_id")%>.jpg" />
				
	<%	}
	%>
			<form action = "movieregist.jsp" method="post" onSubmit = 'return mval();'>
				새로운 영화 추가 : <br/>
				<input placeholder="TITLE" type="text" name="TITLE" /><br/>
				<input placeholder="DIRECTOR" type="text" name="DIRECTOR" /><br/>
				<input placeholder="ACTOR" type="text" name="ACTOR" /><br/>
				<input placeholder="GRADE" type="text" name="GRADE" /><br/>
				<input placeholder="GENRE" type="text" name="GENRE" /><br/>
				<input placeholder="RATING" type="text" name="RATING" /><br/>
				<input placeholder="BOOKING_RATE" type="text" name="BOOKING_RATE" /><br/>
				<input placeholder="RUN_TIME" type="text" name="RUN_TIME" /><br/>
				<textarea placeholder="PLOT" name="PLOT" cols="40" rows="8" ></textarea><br/>
				<input placeholder="MOVIE_ID" type="text" name="MOVIE_ID" /><br/>
				<input type="submit" value="등록" />
			</form>	
		</div>
		<br/>
		<%	rs.close(); %>
		<table id = "ctable" border = "1">
		<caption>고객 정보</caption>
			<thead>
				<tr>	
					<th>고객 아이디</th>
					<th>생년월일</th>
					<th>전화번호</th>
					<th>마일리지</th>
					<th>이름</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>		
		<% 
			while(rs2.next()){ %> 
			<tr>
				<td><%= rs2.getString("client_id") %></td>
				<td><%= rs2.getString("num1") %></td>
				<td><%= rs2.getString("phone_num") %></td>
				<td><%= rs2.getString("mileage") %></td>
				<td><%= rs2.getString("name") %></td>
				<td><%= rs2.getString("address") %></td>
			</tr>
			<%	
				}
			%>		
				</tbody>
			</table>
			
			<% 
			rs2.close();
			%>
			<h2 id = "money">!일별 수익 확인!</h2>
			<p>날짜를 선택하세요</p>
			<form action="#money">
				<select name="month">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3">3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		            <option value="10">10</option>
		            <option value="11">11</option>
		            <option value="12">12</option>
		        </select>
		        월
		 		<select name="day">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3" >3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		            <option value="10">10</option>
		            <option value="11">11</option>
		            <option value="12">12</option>
		            <option value="13">13</option>
		            <option value="14">14</option>
		            <option value="15">15</option>
		            <option value="16">16</option>
		            <option value="17">17</option>
		            <option value="18">18</option>
		            <option value="19">19</option>
		            <option value="20">20</option>
		            <option value="21">21</option>
		            <option value="22">22</option>
		            <option value="23">23</option>
		            <option value="24">24</option>
		            <option value="25">25</option>
		            <option value="26">26</option>
		            <option value="27">27</option>
		            <option value="28">28</option>
		            <option value="29">29</option>
		            <option value="30">30</option>
		            <option value="31">31</option>
		        </select>일
		        <input type = "submit" value = "선택"/>
		        
			</form>
			<%
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String date = "19/" + month + "/" + day;
			String sql3 = "select sum(total_price) from payment where paydate = '" + date + "'";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			ResultSet rs3 = stmt3.executeQuery();
			while(rs3.next()){ %>
				<%= rs3.getString("sum(total_price)")%>
			<% }
			rs3.close();
			%>
			<h2 id = "mmoney">!월별 수익 확인!</h2>
			<p>달을 선택하세요</p>
			<form action="#mmoney">
				<select name="month2">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3">3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		            <option value="10">10</option>
		            <option value="11">11</option>
		            <option value="12">12</option>
		        </select> 
		        월
		        <input type = "submit" value = "선택"/>
		   	</form>
		   	<%
		   	String month2 = request.getParameter("month2");
			String sql4 = "select sum(total_price) from payment where paydate like '%/"+ month2 +"/%'";
			PreparedStatement stmt4 = conn.prepareStatement(sql4);
			ResultSet rs4 = stmt4.executeQuery();
			while(rs4.next()){ %>
				<%= rs4.getString("sum(total_price)")%>
		<%	
			}
			rs4.close(); 
		%>
		
			<h2 id = "dtlist">결제일로 알아보는 손놈들의 예매 실황 생중계</h2>
			<p>날짜를 선택하세요</p>
			<form action="#dtlist">
				<select name="month3">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3">3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		            <option value="10">10</option>
		            <option value="11">11</option>
		            <option value="12">12</option>
		        </select>
		        월
		 		<select name="day3">
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3" >3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		            <option value="10">10</option>
		            <option value="11">11</option>
		            <option value="12">12</option>
		            <option value="13">13</option>
		            <option value="14">14</option>
		            <option value="15">15</option>
		            <option value="16">16</option>
		            <option value="17">17</option>
		            <option value="18">18</option>
		            <option value="19">19</option>
		            <option value="20">20</option>
		            <option value="21">21</option>
		            <option value="22">22</option>
		            <option value="23">23</option>
		            <option value="24">24</option>
		            <option value="25">25</option>
		            <option value="26">26</option>
		            <option value="27">27</option>
		            <option value="28">28</option>
		            <option value="29">29</option>
		            <option value="30">30</option>
		            <option value="31">31</option>
		        </select>일
		        <input type = "submit" value = "선택"/>	        
			</form>
				<%
			   	String month3 = request.getParameter("month3");
				String day3 = request.getParameter("day3");
				String date3 = "19/" + month3 + "/" + day3;
				String sql5 = "select client_id, title ,paydate from payment natural join ticketing natural join schedule natural join movie where paydate = '" + date3 + "'";
				PreparedStatement stmt5 = conn.prepareStatement(sql5);
				ResultSet rs5 = stmt5.executeQuery();
				while(rs5.next()){ %>
					<%= rs5.getString("client_id")%>
					<%= rs5.getString("title")%>
					<%= rs5.getString("paydate")%>
					<br />
	<%	
				}
				rs5.close(); 
		}catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
				
	%>
	</div>
	<br/> 
		<a href = "main.jsp">메인화면</a>
</body>
<div id="footer" > </div>
</html>