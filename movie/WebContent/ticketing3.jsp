<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>¿¹¾à Á¤º¸ db¿¡ ÀúÀå</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	String date = request.getParameter("date");
	String movie_id = request.getParameter("movie_id");
    String start_time = request.getParameter("start_time");
    String theater_num = request.getParameter("theater_num");
	String[] ch=request.getParameterValues("ch");
%>
</body>
</html>