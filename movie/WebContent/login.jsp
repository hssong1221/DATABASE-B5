<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ���׸� - �α���</title>
</head>
<body>
	<% session.invalidate(); %>
	
	<form method="post" action="login3.jsp">
		<table border="1px">
			<tr>
				<td colspan="2" align="center">
					<h1>�α��� ������</h1>
				</td>
			</tr>

			<tr>
				<td>���̵� :</td>
				<td>
				<input type="text" id="my_id" name="my_id" 
				value="���̵�" onfocus="this.value=''" required><!-- required�� �ʼ��׸� -->
				</td>
			</tr>

			<tr>
				<td>��й�ȣ :</td>
				<td>
				<input type="text" id="my_pwd" name="my_pwd" value="��й�ȣ"
					onfocus="this.value='', this.type='password'" required>
					</td>
			</tr>

			<tr>
				<td colspan="2">
				<input type="submit" value="�α���">
					</form>
					<form action="join.jsp">
						<input type="submit" value="ȸ������">
					</form></td>
			</tr>
		</table>
	</form>
</body>
</html>