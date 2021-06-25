<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
<title>${param.title}</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- 조직도 테이블 관련 -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@300&display=swap" rel="stylesheet">

<!-- bootstrap css -->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous"> -->

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />

<%-- <c:if test="${not empty msg}">
<script>							
	alert("${msg}");
</script> 
</c:if>--%>
</head>
<body>
	<header class="header responsive-wrapper">
  <a class="header-left" href="${pageContext.request.contextPath}">
  <img alt="logo" src="${pageContext.request.contextPath }/resources/images/logo1.png"  width="200" height="150">
  </a>
  <div class="header-right">
    <nav class="header-nav">
      <!-- 로그인이전 -->
      <a href="${pageContext.request.contextPath }/employee/empLogin.do" class="header-link">Login</a>
      <!-- 로그인이후 -->
<%--       <a href="${pageContext.request.contextPath }/member/memberLogout.do" class="header-link"> Logout</a> --%>
      <a href="${pageContext.request.contextPath }/employee/empEnroll.do" class="header-link header-link--button">Sign Up</a> 
    </nav>
  </div>
</header>
