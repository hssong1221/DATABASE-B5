<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ���׸� - ȸ������</title>
</head>
<body>
<script src = "js/join.js"></script>


<FORM name="f" method="post" action="login2.jsp" onsubmit="return validate()">
<table width="60%" height="70%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#9999FF">
    <tr align="center">
        <td colspan="2" align="center" bgcolor="skyblue">
            <div style="font-weight: bold; font-size: 18px">ȸ�� �⺻ ����
            </div></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center">
            <div style="font-weight: bold;">���̵�:
            </div></td>
        <td>&nbsp<input type="text" name="my_id" id="my_id" size="12" maxlength="12">
            &nbsp4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">��й�ȣ:</div></td>
        <td>&nbsp<input type="password" id="my_pwd" name="my_pwd" size="12" maxlength="12">
            &nbsp4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">��й�ȣ Ȯ��:</div></td>
        <td>&nbsp<input type="password" id="my_pwd2" name="my_pwd2" size="12" maxlength="12"></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">�����ּ�:</div></td>
        <td>&nbsp<input type="text" name="my_mail" id="my_mail" size="30" maxlength="30">
            &nbsp��)id@domain.com</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">�̸�:</div></td>
        <td>&nbsp<input type="text" name="my_name" id="my_name" size="10" maxlength="10"></td>
    </tr>
    
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">�ֹε�Ϲ�ȣ:</div></td>
        <td>&nbsp<input type="text" id="my_num1" name="my_num1" size="6" maxlength="6">
            &nbsp&nbsp 
            <input type="password" id="my_num2" name="my_num2" size="7" maxlength="7">
            &nbsp��)123456-1234567</td>
    </tr>
   	<tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">�޴��� ��ȣ :</div></td>
        <td>&nbsp<input type="text" name="my_phonenum" id="my_phonenum" size="20" maxlength="20"></td>
    </tr>
 
</table>
    <p align="center">
    <input type="submit" name="submit" value="ȸ�� ����" >
    <input type="reset" value="�ٽ� �Է�">
</FORM>
</body>
</html>