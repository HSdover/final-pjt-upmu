<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<script>
function goMailForm(s){
	//console.log(s);
	//location.href = "${pageContext.request.contextPath}/mail/mailForm.do";
//	var mailForm = document.mailForm;
//	console.log(mailForm);
//	mailForm.receiverNo.value = s;
	//mailForm.submit();

//	var form = document.forms["replyFrm"];
//	form.
}
</script>

<div class="container">
<form
	action="${pageContext.request.contextPath}/mail/mailForm.do"
	name="replyFrm"
	method="POST">
<input type="hidden" name="reply" value="${mail.receiverNo}"/>
</form>
	<div class="row">
		<h4 class="page-header">보낸 메일함</h4>
		
		<table class="table">
		<tbody>
			<tr>
				<td>보낸 사람</td>
				<td>${mail.senderNo}</td>
			</tr>
			<tr>
				<td>받는 사람</td>
				<td>${mail.receiverNo}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${mail.mailTitle}</td>
			</tr>
			
			<tr>
			<td>첨부파일</td>
			<td>
			<%-- <c:if --%>
			<c:forEach items="${mail.attachList}" var="attach">
				<button type="button" 
						class="btn btn-outline-success btn-block"
						onclick="location.href='${pageContext.request.contextPath}/mail/fileDownload.do?no=${attach.attachNo}';">
					첨부파일 - ${attach.originalFilename}
				</button>
			</c:forEach>
			</td>
			</tr>
			
			<tr>
				<td>보낸 시간</td>
				<td>
					<fmt:formatDate value="${mail.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					${mail.mailContent}
				</td>
			</tr>
		
		</tbody>
		</table>
		<div class="text-right">
				<input type="submit" class="btn btn-outline-primary" value="답장" onclick="goMailForm(${mail.receiverNo});"/>
				<input type="submit" class="btn btn-outline-primary" value="답장2" onclick="javascript:document.replyFrm.submit();"/>
				<button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/mail/sendMailList.do?no=1';">목록</button>
				<button type="button" class="btn btn-outline-danger" onclick="">삭제</button>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include></html>