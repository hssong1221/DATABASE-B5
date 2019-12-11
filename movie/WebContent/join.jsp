<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콱 씨네마 - 회원가입</title>
    <script src = "js/join.js"></script>
    <link href="./style/join.css" type="text/css" rel="stylesheet" />
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript">
    $(document).ready( function() {
        $("#head").load("./style/head.html");
        $("#footer").load("./style/footer.html");
	});

	var xhr=null;
 
 	function getXHR(){
  		if(window.XMLHttpRequest){
   		//IE 7.0이상,Chrome,Firefox,Safari,....
   			return new XMLHttpRequest();
  		}else{
   		//IE 하위버젼(6.0이하)
   			return new ActiveXObject("Microsoft.XMLHTTP");
  		}
 	}
 
 	function idCheck(){
  		xhr=getXHR();
  		xhr.onreadystatechange=getResult;
  		var id=document.getElementById("id").value;
  		xhr.open("get","idcheck.jsp?id="+id,true);
  		xhr.send(null);
 		}
 
 	function getResult(){
 		var id=document.getElementById("id").value;
  		if(xhr.readyState==4 && xhr.status==200){
   			var xml=xhr.responseXML;
   			var re=xml.getElementsByTagName("result")[0].firstChild.nodeValue;
   
   		if(re=='true'){
    		//span에 결과 출력하기
    		document.getElementById("idcheck").innerHTML="이미 사용중인 아이디 입니다.";
   		}
   		else{
    		document.getElementById("idcheck").innerHTML="중복되지 않는 아이디 입니다.";
   		}
  	}	
}
</script>

</head>
    <div id="head" > </div>

<body>

    <div class="maindiv">
    	<div class="new">
        <FORM class="login-form" name="f" method="post" action="login2.jsp" onsubmit="return validate()">
                <div class="join-logo-div">
                    <img class='join-logo' src='./style/welcome.png' />
                </div>

				<fieldset><legend>회원가입</legend>
	                <label class="rowtext"><span>아이디<span class="required">*</span></span>
	                    <input class="text" type="text" name="id" id="id" size="30" maxlength="12"
	                        placeholder="4~12자의 영문 대소문자와 숫자로만 입력"  required/>
                        <input type="button" onclick="idCheck()" value="중복체크"/>
                        <div id="idcheck"></div>
	                </label>
	
	                <label class="rowtext"><span>비밀번호<span class="required">*</span></span>
	                    <input class="text" type="text" id="my_pwd" name="my_pwd" size="30" maxlength="12" placeholder="4~12자의 영문 대소문자와 숫자로만 입력" required />
	                </label>
	
	                <label class="rowtext"><span>비밀번호 확인<span class="required">*</span></span>
	                    <input class="text" type="text" id="my_pwd2" name="my_pwd2" size="30" maxlength="12" placeholder="4~12자의 영문 대소문자와 숫자로만 입력" required /> 
	                </label>
	
	                <label class="rowtext"><span>메일주소<span class="required">*</span></span>
	                    <input class="text" type="text" name="my_mail" id="my_mail" size="30" maxlength="30"
	                    placeholder="예) id@domain.com"  required />
	                </label>
	
	                <label class="rowtext"><span>이름<span class="required">*</span></span>
	                    <input class="text" type="text" name="my_name" id="my_name" size="10" maxlength="10"
	                 />
	                </label>
	
	                <label class="rowtext"><span>주민등록번호<span class="required">*</span></span>
	                    <input class="text" type="text" id="my_num1" name="my_num1" size="7" maxlength="6"> -
	                    <input class="text" type="password" id="my_num2" name="my_num2" size="6" maxlength="7"  />
	                </label>
	
	                <label class="rowtext"><span>휴대폰 번호 <span class="required">*</span></span>
	                    <input class="text" type="text" name="my_phonenum" id="my_phonenum" size="20" maxlength="20" placeholder="숫자만 입력">
	                </label>
        	 </fieldset>
            <p align="center"></p>
            <div class="btn">
                <button type="submit" name="submit" value="회원 가입" >회원가입</button>
                <button type="reset" value="다시 입력">다시입력</button>
               </div>
            
        </FORM>
        
        </div>
    </div>

</body>
        <div id="footer" > </div>

</html>