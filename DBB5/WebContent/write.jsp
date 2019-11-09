<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action = "insert.jsp" method = "post" onsubmit = "return formCheck();">
		title : <input type = "text" name = "title"/><br/>
		writer : <input type = "text" name = "writer"/><br/>
		content : <textarea rows="10" cols="20" name = "content"></textarea><br/>
		<input type = "submit"/>
	</form>
	<script> // 자바스크립트태그
		function formCheck(){
			var title = document.forms[0].title.value;
			var writer = document.forms[0].writer.value;
			var content = document.forms[0].content.value;
			
			if (title == null || title == ""){
				alert('제목을 입력하세요');
				document.forms[0].title.focus(); //해당태그에 포커스를줌
				return false;
			}
			if (writer == null || writer == ""){
				alert('작성자를 입력하세요');
				document.forms[0].writer.focus(); //해당태그에 포커스를줌
				return false;
			}
			if (content == null || content == ""){
				alert('내용를 입력하세요');
				document.forms[0].content.focus(); //해당태그에 포커스를줌
				return false;
			}

			if(!((writer.match(/^(\w+)@(\w+)[.](\w+)$/ig)) || (writer.match(/^(\w+)@(\w+)[.](\w+)[.](\w+)$/ig)))){
				alert("이메일 형식이 맞지 않습니다");
				return false;
			}
		}
	</script>
</body>
</html>