<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src = "js/join.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	Connection conn = null;

try{
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	String sql = "SELECT * FROM client WHERE client_id='"+id+"'";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()){
		%>
	<FORM name="f" method="post" action="change.jsp" onsubmit="return validate()">
	<table width="50%" height="80" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#9999FF">
    <tr align="center">
        <td colspan="2" align="center" bgcolor="skyblue">
            <div style="font-weight: bold; font-size: 18px">회원 정보 수정
            </div></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center">
            <div style="font-weight: bold;">아이디:
            </div></td>
        <td>&nbsp<input type="text" name="my_id" id="my_id" value="<%= rs.getString("client_id") %>" size="12" maxlength="12" disabled>
            &nbsp4~12자의 영문 대소문자와 숫자로만 입력</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">비밀번호:</div></td>
        <td>&nbsp<input type="password" id="my_pwd" name="my_pwd" size="12" maxlength="12" >
            &nbsp4~12자의 영문 대소문자와 숫자로만 입력</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">메일주소:</div></td>
        <td>&nbsp<input type="text" name="my_mail" id="my_mail" value="<%= rs.getString("address") %>" size="30" maxlength="30">
            &nbsp예)id@domain.com</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">이름:</div></td>
        <td>&nbsp<input type="text" name="my_name" id="my_name" value="<%= rs.getString("name") %>" size="10" maxlength="10" disabled></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">주민등록번호:</div></td>
        <td>&nbsp<input type="text" id="my_num1" name="my_num1" size="6" maxlength="6" value="<%= rs.getString("num1") %>" disabled>
            &nbsp-&nbsp 
            <input type="password" id="my_num2" name="my_num2" size="7" maxlength="7"  value="<%= rs.getString("num2") %>" disabled>
            &nbsp예)123456-1234567</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">휴대폰 번호:</div></td>
        <td>&nbsp<input type="text" name="my_phonenum" id="my_phonenum" value="<%= rs.getString("phone_num") %>" size="10" maxlength="10">&nbsp숫자만 입력</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">마일리지:</div></td>
        <td>&nbsp<%= rs.getString("mileage") %></td>
    </tr>
    <tr>
    	<td colspan="2">
    		<input type="submit" name="submit" id="submit" value="수정완료" >
    		<input type="reset" value="다시 입력">
    	</td>
    </tr>
	</table>
	
    </FORM>
	<%
	}
	rs.close();
			
	

}catch(Exception e){
	out.println("연결x");
	e.printStackTrace();
	
}finally{
	conn.close();
}

%>
</body>
</html>