<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>콱 씨네마 - 로그인</title>
	<link href="./style/login.css" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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
	<% session.invalidate(); %>
	
<div class="entire maindiv">
	<form  method="post" action="login3.jsp">
			<div class="login">
					<img class='login-logo' src='./style/login.png' />			
				<div class="row">
					<i class="material-icons">person</i>
				<input class="text" type="text" id="my_id" name="my_id" 
				value="Username" onfocus="this.value=''" required>
				</div>
				<div class="row">
					<i class="material-icons">vpn_key</i>
				<input class="text" type="text" id="my_pwd" name="my_pwd" value="Password"
					onfocus="this.value='', this.type='password'" required>
				</div>
				<button type="submit" value="로그인">
					로그인
				</button>
			</div>
	</form>
	
		<form action="join.jsp">
			<div class="new">
				<button type="submit" value="회원가입">회원가입</button>
			</div>
		</form>			
</div>
	
	
	


	
</body>
	<div id="footer" > </div>

</html>