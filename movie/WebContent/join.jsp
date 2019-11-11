<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>콱 씨네마 - 회원가입</title>
</head>
<body>
<script src = "js/join.js"></script>


<FORM name="f" method="post" action="login2.jsp" onsubmit="return validate()">
<table width="60%" height="70%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="#9999FF">
    <tr align="center">
        <td colspan="2" align="center" bgcolor="skyblue">
            <div style="font-weight: bold; font-size: 18px">회원 기본 정보
            </div></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center">
            <div style="font-weight: bold;">아이디:
            </div></td>
        <td>&nbsp<input type="text" name="my_id" id="my_id" size="12" maxlength="12">
            &nbsp4~12자의 영문 대소문자와 숫자로만 입력</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">비밀번호:</div></td>
        <td>&nbsp<input type="password" id="my_pwd" name="my_pwd" size="12" maxlength="12">
            &nbsp4~12자의 영문 대소문자와 숫자로만 입력</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">비밀번호 확인:</div></td>
        <td>&nbsp<input type="password" id="my_pwd2" name="my_pwd2" size="12" maxlength="12"></td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">메일주소:</div></td>
        <td>&nbsp<input type="text" name="my_mail" id="my_mail" size="30" maxlength="30">
            &nbsp예)id@domain.com</td>
    </tr>
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">이름:</div></td>
        <td>&nbsp<input type="text" name="my_name" id="my_name" size="10" maxlength="10"></td>
    </tr>
    
    <tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">주민등록번호:</div></td>
        <td>&nbsp<input type="text" id="my_num1" name="my_num1" size="6" maxlength="6">
            &nbsp&nbsp 
            <input type="password" id="my_num2" name="my_num2" size="7" maxlength="7">
            &nbsp예)123456-1234567</td>
    </tr>
   	<tr>
        <td bgcolor="pink" align="center"><div style="font-weight: bold;">휴대폰 번호 :</div></td>
        <td>&nbsp<input type="text" name="my_phonenum" id="my_phonenum" size="20" maxlength="20"></td>
    </tr>
 
</table>
    <p align="center">
    <input type="submit" name="submit" value="회원 가입" >
    <input type="reset" value="다시 입력">
</FORM>
</body>
</html>