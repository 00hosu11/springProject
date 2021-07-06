<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style type="text/css">
div#nameDiv, div#idDiv , div#pwdDiv {
	color: red;
	font-size: 8pt;
	font-weight: bold;

</style>

   <form name="modifyForm" method="post" action="/spring/member/modify">
      <h1 align="center">회원정보수정</h1>

      <table border="1" bordercolor="indigo" width="500" height="300"
         align="center" cellspacing="0" cellpadding="10">

         <!--이름 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100">이름</td>
            <td><input name="name" id="name" type="text" value="${memberDTO.name}">
            <div id="nameDiv"></div>
            </td>
         </tr>

         <!-- 아이디 -->
         <tr>
            <td bgcolor="skyblue" align="center" width="100">아이디</td>
            <td><input name="id" id="id" type="text" value="${memberDTO.id}" readonly>
            </td>
         </tr>


         <!-- 비밀번호 -->

         <tr>
            <td bgcolor="skyblue" align="center" width="100">비밀번호</td>
            <td><input name="pwd" id="pwd" type="password">
             <div id="pwdDiv"></div></td>
    
         </tr>

         <!-- 재확인 -->

         <tr>
            <td bgcolor="skyblue" align="center" width="100">재확인</td>
            <td><input name="repwd" id="repwd" type="password"></td>
         </tr>



         <!--성별-->
         <tr>
            <td bgcolor="skyblue" align="center">성별</td>
            <td>
               <input type="radio" name="gender" value="0">남 <!-- radio값은 항상 배열로 인식하기때문에 밸류값은 그대로 냅두기 -->
               <input type="radio" name="gender" value="1">여
            </td>
         </tr>



         <!-- 이메일 -->
         <tr>
            <td bgcolor="skyblue" align="center">이메일</td>
            <td><input type="text" name="email1" size="15" value="${memberDTO.email1}"> @ 
      			 <input type="email" list="email2" name="email2"  size="15">
  				  <datalist id="email2">	  
                  <option value="gmail.com"></option>
                  <option value="hanmail.com"></option>
                  <option value="naver.com"></option>
                  </datalist>
            </td>
         </tr>

         <!--핸드폰 -->
         <tr>
            <td bgcolor="skyblue" align="center">핸드폰</td>
            <td><select name="tel1" style ="width:70px;" onfocus="${memberDTO.tel1}">
                  <option value="010">010</option>
                  <option value="011">011</option>
                  <option value="019">019</option>
               </select>
                -
               <input type="text" name="tel2" value="${memberDTO.tel2}" size="3" maxlength="4" />
                - 
               <input type="text" name="tel3" value="${memberDTO.tel3}" size="3" maxlength="4" />
            </td>
         </tr>


         <!--주소 -->
         <tr>
            <td bgcolor="skyblue" align="center">주소</td>
            <td>
            <input type="text" size="10" readonly name="zipcode"  value="${memberDTO.zipcode}" id="zipcode">
            <input type="button" value="우편번호 검색" id="checkPostBtn"> 
            <br> 
            <input type="text" name="addr1" size="50" value="${memberDTO.addr1}" readonly id="addr1"> 
            <input type="text" name="addr2" size="50" value="${memberDTO.addr2}" id="addr2">
            </td>
         </tr>


         <!--버튼 -->
         <tr>
            <td colspan="2" width="200" align="center">
            <input type="button" value="회원정보수정" id="modifyBtn">
            <input type="reset" value="다시작성" onclick="location.reload()">
            </td>
         </tr>


      </table>
   </form>
   
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/member.js"></script>
<script type="text/javascript">
	window.onload=function(){ /* body태그에다가 onload 써줘도된다 */
	document.modifyForm.gender["${memberDTO.gender}"].checked = true;
	document.modifyForm.email2.value="${memberDTO.email2}";
 	document.modifyForm.tel1.value="${memberDTO.tel1}";
	}
</script>
