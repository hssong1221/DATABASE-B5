<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	Connection conn=null;
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	String date = request.getParameter("date");
	String movie_id = request.getParameter("movie_id");
    String start_time = request.getParameter("start_time");
    String theater_num = request.getParameter("theater_num");
    String schedule_id = null;
    
    try{
    	String sql2 = "SELECT schedule_id FROM schedule WHERE screening_date ='"+date+"' and start_time = '"+ start_time + "' and movie_id = '" + movie_id + "' and theater_num = '" + theater_num + "'";
    	PreparedStatement stmt = conn.prepareStatement(sql2);
    	ResultSet rs = stmt.executeQuery();
    	while(rs.next()){
    		schedule_id = rs.getString("schedule_id");
    	}
    	 rs.close();
    	 

    }catch(Exception e){
        out.print("연결에 실패하였습니다.");
        e.printStackTrace();
    }
    finally{
    }
	
	int row = 10;
    int col = 10;
    int w=30+col*30+col/5*20;
    if(col%5==0)
    	w-=20;
    
    
%>    
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./style/seat.css" type="text/css" rel="stylesheet" />
<title>콱씨네마 - 좌석선택</title>


<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready( function() {
	$("#head").load("./style/head.html");
	$("#footer").load("./style/footer.html");
});

function send() {
	var f=document.forms[0];
	 // 자바스트립트에서 표현식 사용 가능
	var row="<%=row%>";
	var col="<%=col%>";
	var n=0;
	for(var i=0; i<row*col; i++) {
		if(f.ch[i].checked==true)
			n++;
	}
	if(n<1 || n>5) {
		alert("좌석은 1~5개 까지 가능 합니다.");
		return;
	}
    
	f.submit();
}


$(document).ready(function(){

	// .check 클래스 중 어떤 원소가 체크되었을 때 발생하는 이벤트

	$(".check").click(function(){  // 여기서 .click은 체크박스의 체크를 뜻한다.

		var str = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.

		$(".check").each(function(){  // .each()는 forEach를 뜻한다.

			if($(this).is(":checked"))  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.

				str += $(this).val() + " ";  // 체크된 객체를 str에 저장한다.

		});

		$("#multiPrint").text(str);  // #multiPrint에 체크된 원소를 출력한다.

	});


	$("#allCheck").click(function(){
		$(".check").removeAttr("checked")  // 체크가 안 되어있으면 "checked"를 제거한다.

		 // 이 때 체크가 되어있는 원소는 안 바뀐다. 어디까지나 체크가 안 된 것들에 대해서만 효과가 있다.

	var str = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.

	$(".check").each(function(){  // .each()는 forEach를 뜻한다.

		if($(this).is(":checked"))  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.

			str += $(this).val() + " ";  // 체크된 객체를 str에 저장한다.

	});

	$("#multiPrint").text(str);  // #multiPrint에 체크된 원소를 출력한다.

	});

});

function seat(seatnum) {
   	var f=document.forms[0];
   	var row="<%=row%>";
   	var col="<%=col%>";
   	for(var i=0; i<row*col; i++) {
   		if(f.ch[i].value == seatnum){
   			f.ch[i].disabled = true;
   		}	
   	}
   	return;
   }
</script>


</head>
<div id=head></div>
<body>
<div class="maindiv">

<% 
try{
	String sql2 = "SELECT * FROM client WHERE client_id='"+id+"'";
	PreparedStatement stmt = conn.prepareStatement(sql2);
	ResultSet rs = stmt.executeQuery();
	while(rs.next()){
	%>
		<p class="loging"><%= rs.getString("name") %> 님</p>
	<%
	}
	
	rs.close();
		
		

}catch(Exception e){
    out.print("연결에 실패하였습니다.");
    e.printStackTrace();
}
finally{
}
%>
<br/><br/>

	<div class="new">


<form action="payment.jsp?schedule_id=<%=schedule_id%>" method="post">
<h3><%= theater_num %></h3><br/>
<div>선택한 자리 : <span id="multiPrint"></span></div><br/>
<div class="screen">Screen</div>
<table width="<%=w%>">

<tr height="30">

<%
	out.println("<td width='30'>&nbsp;</td>");
    for(int i=1; i<=col; i++) {
    	if(i!=1 && i%5==1)
    		out.println("<td width='20'>&nbsp;</td>");
    	out.println("<td width='30' align='center'>"+i+"</td>");
    }
%>

</tr>



<%
    String s;
	for(int i=1; i<=row; i++) {
		out.println("<tr height='25'>");
		out.println("<td align='center'>"+(char)(i+64)+"</td>");
		for(int j=1; j<=col; j++) {
			if(j!=1 && j%5==1)
				out.println("<td width='20' bgcolor='black'>&nbsp;</td>");
			out.print("<td width='30' align='center'>");
			s=(char)(i+64)+":"+j;
			out.print("<input type='checkbox' id = '" + s + "' class='check' name='ch' value='"+
			    s+"'>");
			out.print("<label for='" + s + "'></label>");
			out.println("</td>");
		}
		out.println("</tr>");
	}
%>

</table>

<%
try{
	String sql = "SELECT * FROM seat_schedule natural join seat WHERE schedule_id = '" + schedule_id + "' and status = 1";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();

	while(rs.next()){%>
		<script>
		var i = "<%=rs.getString("seat_name")%>";
		seat(i);
		</script>
			
		<% }
		
		rs.close();
			
	}catch(Exception e){
	    out.print("연결에 실패하였습니다.");
	    e.printStackTrace();
	}
	finally{
		conn.close();
	}%>	
	

<table width="<%=w%>">

<tr height="50">

      <td align="left">
      	<div class="btndiv">
           <input class="btn" type="button" value="좌석예약"

                 onclick="send();">
             </div>
      </td>

</tr>

</table>

</form>
	</div>
</div>
</body>
<div id=footer></div>
</html>