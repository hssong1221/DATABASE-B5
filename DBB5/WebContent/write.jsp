<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>DB와 WEB 연동</title>
		<link rel="stylesheet" type="text/css" href="board.css">
		<script src="formcheck.js"></script>
	</head>
	<body>
		<h1>게시판</h1>
		<form action="index.jsp" method="post" onsubmit="return formCheck();">
			제목 :
			<input type="text" name="title"/><br />
			작성자 :
			<input type="text" name="writer"/><br />
			글 내용 : 
			<textarea rows="10" cols="20" name="content"></textarea><br / >
			날짜 : 
			<input type="text" name="date"/><br />
			<input type="submit" />
		</form>
		
	</body>
</html>