<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콱 씨네마 - 회원가입</title>
    <link href="./style/master.css" type="text/css" rel="stylesheet" />
    <link href="./style/join.css" type="text/css" rel="stylesheet" />
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript">
    $(document).ready( function() {
        $("#head").load("./style/head.html");
        $("#footer").load("./style/footer.html");
    });
    </script>
</head>
<body>
    <script src = "js/join.js"></script>
    <div id="head" > </div>

    <div class="new">
        <FORM class="login-form" name="f" method="post" action="login2.jsp" onsubmit="return validate()">
                <div class="join-logo-div">
                    <img class='join-logo' src='./style/welcome.png' />
                </div>

                <div class="rowtext">아이디:
                    <input class="text" type="text" name="my_id" id="my_id" size="28" maxlength="12"
                        value="4~12자의 영문 대소문자와 숫자로만 입력" onfocus="this.value=''" required/>
                </div>

                <div class="rowtext">비밀번호:
                    <input class="text" type="text" id="my_pwd" name="my_pwd" size="28" maxlength="12" value="4~12자의 영문 대소문자와 숫자로만 입력" onfocus="this.value='', this.type='password'" required />
                </div>

                <div class="rowtext">비밀번호 확인:
                    <input class="text" type="text" id="my_pwd2" name="my_pwd2" size="28" maxlength="12" value="4~12자의 영문 대소문자와 숫자로만 입력" onfocus="this.value='', this.type='password'" required /> 
                </div>

                <div class="rowtext">메일주소:
                    <input class="text" type="text" name="my_mail" id="my_mail" size="30" maxlength="30"
                    value="예) id@domain.com" onfocus="this.value=''" required />
                </div>

                <div class="rowtext">이름:
                    <input class="text" type="text" name="my_name" id="my_name" size="10" maxlength="10"
                onfocus="this.value=''" />
                </div>

                <div class="rowtext">주민등록번호:
                    <input class="text" type="text" id="my_num1" name="my_num1" size="6" maxlength="6"> -
                    <input class="text" type="password" id="my_num2" name="my_num2" size="7" maxlength="7" value="예) 123456-1234567" onfocus="this.value=''" />
                </div>

                <div class="rowtext">휴대폰 번호 :
                    <input class="text" type="text" name="my_phonenum" id="my_phonenum" size="20" maxlength="20" onfocus="this.value=''">
                </div>
         
            <p align="center"></p>
            <div class="btn">
                <button type="submit" name="submit" value="회원 가입" >회원가입</button>
                <button type="reset" value="다시 입력">다시입력</button>
            </div>
        </FORM>
    </div>

        <div id="footer" > </div>
</body>
</html>