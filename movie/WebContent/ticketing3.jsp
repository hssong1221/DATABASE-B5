<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콱씨네마 - 결제</title>
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