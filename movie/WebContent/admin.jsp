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
		<div class="new">
	<br/>
	<div class="nav">
	<nav>
		<ul>
			<li><a href = #nowmovie>현재 상영중인 영화</a></li>
			<li><a href = #ctable>고객 정보</a></li>
			<li><a href = #money>날짜별 수익</a></li>
			<li><a href = #mmoney>월별 수익</a></li>
			<li><a href = #dtlist>결제일 기준 예매 리스트</a></li>
		</ul>
	</nav>
	</div>
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

			<div>
	<% 
			while(rs.next()){
	%>		
			<%= rs.getString("movie_id") %>
			<a href = "m_info.jsp?moviepage=<%= rs.getString("movie_id")%>">
				<img class="movieimg"  src="image\<%=rs.getString("movie_id")%>.jpg" />
			</a>
			
	<%	}
	%>		</div>


		<div class="addmovie">
			<fieldset><legend>새로운 영화 추가</legend>
			<form action = "movieregist.jsp" method="post" onSubmit = 'return mval();'>

				<label><span>제목<span class="required">*</span></span><input placeholder="TITLE" type="text" name="TITLE" /></label>
				<label><span>감독<span class="required">*</span></span><input placeholder="DIRECTOR" type="text" name="DIRECTOR" /></label>
				<label><span>배우<span class="required">*</span></span><input placeholder="ACTOR" type="text" name="ACTOR" /></label>
				<label><span>상영등급<span class="required">*</span></span><input placeholder="GRADE" type="text" name="GRADE" /></label>
				<label><span>장르<span class="required">*</span></span><input placeholder="GENRE" type="text" name="GENRE" /></label>
				<label><span>시간<span class="required">*</span></span><input placeholder="RUN_TIME" type="text" name="RUN_TIME" /></label>
				<label><span>줄거리<span class="required">*</span></span><textarea placeholder="PLOT" name="PLOT" cols="40" rows="8" ></textarea></label>
				<label><span>영화ID<span class="required">*</span></span><input placeholder="MOVIE_ID 항상 최신 영화 다음 번호를 넣어야 합니다." type="text" name="MOVIE_ID" style="width:350px;" /></label>
				<button type="submit" value="등록">등록</button>
			</form>	
		</fieldset>
		</div>
		</div>
		<br/>
		<%	rs.close(); %>
		
			<div id="money">
				<fieldset><legend>일별 수익 확인</legend>
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
				            <option value="01">1</option>
				            <option value="02">2</option>
				            <option value="03" >3</option>
				            <option value="04">4</option>
				            <option value="05">5</option>
				            <option value="06">6</option>
				            <option value="07">7</option>
				            <option value="08">8</option>
				            <option value="09">9</option>
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
				        <button type = "submit" value = "선택">선택</button>
						</form>

			<%
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String date = "19/" + month + "/" + day;
			String sql3 = "select sum(total_price) from payment where paydate = '" + date + "'";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			ResultSet rs3 = stmt3.executeQuery();
			if(month!=null&&day!=null){
				while(rs3.next()){ %>
					<p><%= month %>월<%= day %>일 매출: <%= rs3.getString("sum(total_price)")%></p>
				<% }
			}
			rs3.close();
			%>
				</fieldset>
			</div>

			<div id="mmoney">
				<fieldset><legend>월별 수익 확인</legend>
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
				        <button type = "submit" value = "선택">선택</button>
				   	</form>
		   	<%
		   	String month2 = request.getParameter("month2");
			String sql4 = "select sum(total_price) from payment where paydate like '%/"+ month2 +"/%'";
			PreparedStatement stmt4 = conn.prepareStatement(sql4);
			ResultSet rs4 = stmt4.executeQuery();
			if(month2!=null){
				while(rs4.next()){ %>
					<p><%= month2 %>월 매출: <%= rs4.getString("sum(total_price)")%></p>
			<%	}
			}
			rs4.close(); 
		%>
				</fieldset>
			</div>
		
			<div id = "dtlist">
				<fieldset><legend>결제일로 알아보는 손님들의 예매 현황</legend>
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
				            <option value="01">1</option>
				            <option value="02">2</option>
				            <option value="03" >3</option>
				            <option value="04">4</option>
				            <option value="05">5</option>
				            <option value="06">6</option>
				            <option value="07">7</option>
				            <option value="08">8</option>
				            <option value="09">9</option>
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
				        <button type = "submit" value = "선택">선택</button>	        
					</form>
					<%
			   	String month3 = request.getParameter("month3");
				String day3 = request.getParameter("day3");
				String date3 = "19/" + month3 + "/" + day3;
				String sql5 = "select * from payment natural join ticketing natural join schedule natural join movie where paydate = '" + date3 + "' order by ticketing_id";
				PreparedStatement stmt5 = conn.prepareStatement(sql5);
				ResultSet rs5 = stmt5.executeQuery();


				String sql6 = "select ticketing_id, LISTAGG(seat_name,', ') within group (order by seat_name) name from ticketing natural join ticketing_seat natural join seat natural join payment where paydate = '" + date3 + "' group by ticketing_id order by ticketing_id";
				PreparedStatement stmt6 = conn.prepareStatement(sql6);
				ResultSet rs6 = stmt6.executeQuery();


				if(month3!=null&&day3!=null){	
			%>
					<table border = "1">
						<caption><%= month3 %>월 <%= day3 %>일 예매 리스트</caption>
					<thead>
						<tr>	
							<th>예매번호</th>
							<th>고객 아이디</th>
							<th>영화제목</th>
							<th>영화상영날짜</th>
							<th>시작시간</th>
							<th>상영관번호</th>
							<th>좌석번호</th>
						</tr>
					</thead>
					<tbody>	
				<%
						while(rs5.next()&&rs6.next()){ %>
						<tr>
							<td><%= rs5.getString("ticketing_id")%></td>
							<td><%= rs5.getString("client_id")%></td>
							<td><%= rs5.getString("title")%></td>
							<td><%= rs5.getString("screening_date")%></td>
							<td><%= rs5.getString("start_time")%></td>
							<td><%= rs5.getString("theater_num")%></td>
							<td><%= rs6.getString("name") %></td>
						</tr>
			<%	
						}
				}
				rs5.close(); 
				rs6.close();
	%>
						</tbody>
					</table>
				</fieldset>
			</div>
			<div class="client_information">
			<fieldset><legend>고객 정보</legend>

			<table id = "ctable" border = "1">
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
				<% if (!rs2.getString("client_id").equals("admin")){
				%> 
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
				}
				%>		
					</tbody>
				</table>
			</fieldset>
		</div>	

			<% 
			rs2.close();
			%>
			
		<% 
			String sql7 = "select * from staff";
			PreparedStatement stmt7 = conn.prepareStatement(sql7);
			ResultSet rs7 = stmt7.executeQuery();
			
			while(rs7.next()){%>
				<%= rs7.getString("staff_id") %>
				<%= rs7.getString("s_name") %>
				<%= rs7.getString("s_num1") %>
				<%= rs7.getString("s_num2") %>
				<%= rs7.getString("s_phone_num") %>
				<%= rs7.getString("s_address") %>
				<%= rs7.getString("s_position") %>
				<%= rs7.getString("area") %>
		<% 	}
			rs7.close();
			
		}catch(Exception e){
		    out.print("연결에 실패하였습니다.");
		    e.printStackTrace();
		}
		finally{
			conn.close();
		}
				
	%>
		</div>
	</div> 
</body>
<div id="footer" > </div>
</html>