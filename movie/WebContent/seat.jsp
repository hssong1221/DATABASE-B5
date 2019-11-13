<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

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
	
	int row = 15;
    int col = 15;
    int w=30+col*30+col/5*20;
    if(col%5==0)
    	w-=20;
    
    
%>    

    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>콱씨네마 - 좌석선택</title>



<style type="text/css">
*{
	padding: 0px; margin: 0px; font-size: 9pt;
}
td {
	font-size: 9pt;font-family: 돋움;
}
</style>

<script type="text/javascript">
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
</script>



</head>

<body>

<br/><br/>



<form action="ticketing3.jsp?date=<%=date%>&movie_id=<%=movie_id%>&start_time=<%=start_time%>&theater_num=<%=theater_num%>" method="post">

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
				out.println("<td width='20' bgcolor='green'>&nbsp;</td>");
			out.print("<td width='30' align='center'>");
			s=(char)(i+64)+":"+j;
			out.print("<input type='checkbox' name='ch' value='"+
			    s+"'>");
			out.println("</td>");
		}
		out.println("</tr>");
	}
%>

</table>
<script language="JavaScript">
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
<%
try{
	String sql = "SELECT * FROM seat WHERE theater_num ='"+ theater_num +"' and status = 0";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	while(rs.next()){%>
		<script>
		var i = "<%=rs.getString("seat_num")%>";
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

           <input type="button" value="좌석예약"

                 onclick="send();">

      </td>

</tr>

</table>

</form>

</body>

</html>