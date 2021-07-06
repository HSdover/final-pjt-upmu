<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<style>
.li-title{
	/* background-color: #b3e0ff; */
}
.list-group{
	height : 400px;
	overflow: auto;
}
.li-header{
	height: 10%;
	position: relative;
}
.li-body{
	background-color : white;
}
.span-header{
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

</style>
</head>
<body>
	<div class="list-group">
		<div class="li-header" ><span>일 정 <span class="badge badge-primary badge-pill">${fn:length(list)}</span></span></div>
		<div class="li-body" style="height: 90%">
			<c:choose>
				<c:when test="${empty list}">

				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="sch" varStatus="status">
						<a href="${pageContext.request.contextPath}/schedule/schedule.do" class="list-group-item list-group-item-action text-left">
							${sch.schStart} <span style="font-weight: bold">${sch.schTitle}</span>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>