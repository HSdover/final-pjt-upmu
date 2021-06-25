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
function deleteMail(){
	//삭제 구분 변수
	//1 : sender, 2 : receiver
	var who = 2;
	var valueArr = new Array();
	valueArr.push(${mail.mailNo});

	console.log("valueArr : " + valueArr);

	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		$.ajax({
			url: "${pageContext.request.contextPath}/mail/deleteMail.do",
			type: 'POST',
			traditional: true,
			data: {
				valueArr: valueArr,
				who : who
			},
			success: function(result){
				if(result == "OK"){
					alert("삭제하였습니다.");
					window.location.href='${pageContext.request.contextPath}/mail/receiveMailList.do'
				}
				else {
					alert("삭제 실패하였습니다.");	
				}
			}
		});
	}
}
</script>

<div class="container">
<form
	action="${pageContext.request.contextPath}/mail/mailReply.do"
	name="replyFrm"
	method="POST">
<input type="hidden" name="reply" value="${mail.senderAdd}"/>
</form>
	<h4 class="page-header">받은 메일함</h4>
	
	<table class="table">
		<tbody>
			<tr>
				<td>보낸 사람</td>
				<%-- <td>${mail.senderNo}</td> --%>
				<td>${mail.senderAdd}</td>
			</tr>
			<tr>
				<td>받는 사람</td>
				<td>
					<%-- <c:set var = "receiverAdd" value="${fn:replace(mail.receiverAdd, ':', '')}"/>
					${receiverAdd} --%>
					지금 로그인한 사람 이름
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${mail.mailTitle}</td>
			</tr>
			<tr>
				<td>보낸 시간</td>
				<td><fmt:formatDate value="${mail.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<c:forEach items="${mail.attachList}" var="attach">
						<c:if test="${attach.originalFilename != null}">
							<button type="button" 
									class="btn btn-outline-secondary btn-block"
									onclick="location.href='${pageContext.request.contextPath}/mail/fileDownload.do?no=${attach.attachNo}';">
								${attach.originalFilename}
							</button>
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="width: 100%; height: 50vh; overflow: auto">
					<pre>${mail.mailContent}</pre>
				</td>
			</tr>
		</tbody>
		</table>
		<div class="text-right">
				<input type="submit" class="btn btn-outline-primary" value="답장" onclick="javascript:document.replyFrm.submit();"/>
				<button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/mail/receiveMailList.do?no=1';">목록</button>
				<button type="button" class="btn btn-outline-danger" onclick="deleteMail();">삭제</button>
		</div>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>