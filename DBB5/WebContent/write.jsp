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
	<script> // �ڹٽ�ũ��Ʈ�±�
		function formCheck(){
			var title = document.forms[0].title.value;
			var writer = document.forms[0].writer.value;
			var content = document.forms[0].content.value;
			
			if (title == null || title == ""){
				alert('������ �Է��ϼ���');
				document.forms[0].title.focus(); //�ش��±׿� ��Ŀ������
				return false;
			}
			if (writer == null || writer == ""){
				alert('�ۼ��ڸ� �Է��ϼ���');
				document.forms[0].writer.focus(); //�ش��±׿� ��Ŀ������
				return false;
			}
			if (content == null || content == ""){
				alert('���븦 �Է��ϼ���');
				document.forms[0].content.focus(); //�ش��±׿� ��Ŀ������
				return false;
			}

			if(!((writer.match(/^(\w+)@(\w+)[.](\w+)$/ig)) || (writer.match(/^(\w+)@(\w+)[.](\w+)[.](\w+)$/ig)))){
				alert("�̸��� ������ ���� �ʽ��ϴ�");
				return false;
			}
		}
	</script>
</body>
</html>