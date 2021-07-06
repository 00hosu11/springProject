<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 과제</title>
</head>

<body>

   <form name='loginForm' id='loginForm' >
    <!--   <h3 align="center">로그인</h3> -->

      <table border="1" bordercolor="indigo" width="100%" height="100px"
         align="center" cellspacing="0" cellpadding="5">

         <!-- 아이디 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100%">아이디</td>
            <td><input name="id" id="id" type="text" placeholder="아이디 입력" >
            <div id="idDiv"></div>
            </td>
         </tr>


         <!-- 비밀번호 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100%">비밀번호</td>
            <td><input name="pwd" id="pwd" type="password" >
             <div id="pwdDiv"></div>
            </td>
         </tr>

         <!--버튼 -->
         <tr>
            <td colspan="2" width="200" align="center">
             <input type="button" value="로그인" id="loginBtn">
             <input type="button" value="회원가입" id="writeFormBtn">
            </td>
         </tr>

      </table>
   </form>
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="/spring/js/member.js"></script>


</body>
</html>