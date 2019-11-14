<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>콱 씨네마 - 로그인</title>
	<link href="./style/master.css" type="text/css" rel="stylesheet" />

	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	$(document).ready( function() {
		$("#head").load("./style/head.html");
		$("#footer").load("./style/footer.html");
	});
	</script>
</head>
<body>
	<% session.invalidate(); %>
	<div id="head" > </div>
	<form method="post" action="login3.jsp">
		<table border="1px">
			<tr>
				<td colspan="2" align="center">
					<h1>로그인 페이지</h1>
				</td>
			</tr>

			<tr>
				<td>아이디 :</td>
				<td>
				<input type="text" id="my_id" name="my_id" 
				value="아이디" onfocus="this.value=''" required><!-- required는 필수항목 -->
				</td>
			</tr>

			<tr>
				<td>비밀번호 :</td>
				<td>
				<input type="text" id="my_pwd" name="my_pwd" value="비밀번호"
					onfocus="this.value='', this.type='password'" required>
					</td>
			</tr>

			<tr>
				<td colspan="2">
				<input type="submit" value="로그인">
					</form>
					<form action="join.jsp">
						<input type="submit" value="회원가입">
					</form></td>
			</tr>
		</table>
	</form>
	<div id="footer" > </div>

	
</body>
</html>