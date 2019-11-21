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
<link href="./style/update.css" type="text/css" rel="stylesheet" />
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
        <div class="new">
	<FORM name="f" method="post" action="change.jsp" onsubmit="return validate()">

        <fieldset><legend>회원 정보 수정</legend>
            <label><span>아이디<span class="required">*</span></span>
                <input type="text" name="my_id" id="my_id" value="<%= rs.getString("client_id") %>" size="12" maxlength="12" disabled>
                <div class="explain">4~12자의 영문 대소문자와 숫자로만 입력</div>
            </label>
            <label><span>비밀번호<span class="required">*</span></span>        
                <input type="password" id="my_pwd" name="my_pwd" size="12" maxlength="12" >
                <div class="explain">4~12자의 영문 대소문자와 숫자로만 입력</div>
            </label>
            <label><span>메일주소<span class="required">*</span></span>
                <input type="text" name="my_mail" id="my_mail" value="<%= rs.getString("address") %>" size="30" maxlength="30">
                    <div class="explain">예)id@domain.com</div>
            </label>
            <label><span>이름<span class="required">*</span></span>
                <input type="text" name="my_name" id="my_name" value="<%= rs.getString("name") %>" size="10" maxlength="10" disabled>
            </label>

        <label><span>주민등록번호<span class="required">*</span></span>
            <input type="text" id="my_num1" name="my_num1" size="6" maxlength="6" value="<%= rs.getString("num1") %>" disabled>
             
            <input type="password" id="my_num2" name="my_num2" size="7" maxlength="7"  value="<%= rs.getString("num2") %>" disabled>
            
        </label>
            <label><span>휴대폰 번호 <span class="required">*</span></span>
            <input type="text" name="my_phonenum" id="my_phonenum" value="<%= rs.getString("phone_num") %>" size="12" maxlength="10">
            <div class="explain">숫자만 입력</div>

        </label>
         <label><span>마일리지 <span class="required">*</span></span>
            <%= rs.getString("mileage") %> 
            </label>
            <div class="btn">
                <button type="submit" name="submit" id="submit"  >수정완료</button>
                <button type="reset" >다시 입력</button>
             </div>
        </fieldset>
	
    </FORM>
</div>
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
</div>
</body>
  <div id="footer" > </div>
</html>