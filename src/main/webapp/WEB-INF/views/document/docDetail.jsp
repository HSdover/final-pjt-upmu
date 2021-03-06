<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:import url="/document/docMenu"></c:import>
<style>
#title{
	text-align: center;
}
#docColumn{
	width: 300px;
}
/* table{
	border: 2px solid black;
}
th, td{
	border: 1px solid black;
} */
tr, th, td{
	/* 혹시 table 속성 안먹이면 테두리 없이 나오니까 */
	border: 1px solid #dee2e6;
}

#docLineTable{
	text-align: center;
}
.tableDiv{
	display: inline-block;
}
#docLineDiv{
	float: right;
}

#attach-container{
	width: 500px;
}
#reply-container{
	overflow: hidden;
}
textarea{
	width: 100%;
	display: block;
}
#replyBtn{
	float: right;
}
.doc-content>table{
	width:100%;
}
</style>

<div class="col-xl-9">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">결재문서</h6>
		</div>
		<!--  Body -->
		<div class="card-body ">
		<section>
			<article>
				<%-- 로그인유저 사번을 loginEmpNo에 넣어 사용 --%>
				<sec:authentication property="principal.empNo" var="loginEmpNo"/>
				<h1 id="title">${document.title}</h1>
				<br />
				<div class="tableDiv" id="docColumn">
					<table class="table table-sm table-bordered">
						<tr>
							<td style="width: 100px;">기안자</td><td>${document.writerName}</td>
						</tr>
						<tr>
							<td>소속</td><td>${document.depName}</td>
						</tr>
						<tr>
							<td>직위</td><td>${document.jobName}</td>
						</tr>
						<tr>
							<td>기안일</td><td>${document.requestDate}</td>
						</tr>
						<tr>
							<td>문서번호</td><td>${document.docNo}</td>
						</tr>
					</table>
				</div>
				
				<div class="tableDiv" id="docLineDiv">
					<table id="docLineTable" class="table-bordered">
						<tr>
							<td rowspan="4" align="center" class="table-secondary">결<br/>재</td>
						</tr>
						<c:set var="counter" value="0" />
						<c:forEach items="${document.docLine}" var="docLine">
							<c:if test='${docLine.approverType eq "approver"}'>
							<tr>
								<td>${docLine.jobName}</td>
								<c:choose>
									<c:when test="${docLine.status eq 'notdecided' }">
										<c:if test="${docLine.approver == loginEmpNo }">
										<td>
											<button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#approvalModal">선택</button>
											<input type="hidden" id="maxAuthority" value="${docLine.maxAuthority}"/>
											<input type="hidden" id="lv" value="${docLine.lv}"/>
										</td>
										</c:if>
										<c:if test="${docLine.approver != loginEmpNo }">
										<td class="bg-warning text-white">미결재</td>
										</c:if>
									</c:when>
									<c:when test="${docLine.status eq 'approved' }">
										<c:set var="counter" value="${counter + 1}"/>
										<td class="bg-success text-white">결재완료</td>
									</c:when>
									<c:when test="${docLine.status eq 'rejected' }">
										<c:set var="counter" value="${counter + 1}"/>
										<td class="bg-danger text-white">반려</td>
									</c:when>
									<c:when test="${docLine.status eq 'afterview' }">
										<c:set var="counter" value="${counter + 1}"/>
										<td class="bg-secondary text-white">후열</td>
									</c:when>
								</c:choose>
								<td>${docLine.empName}</td>
							</tr>
							</c:if>
						</c:forEach>
						
						<tr>
							<td rowspan="4" align="center" class="table-secondary">협<br/>의</td>
						</tr>
						<c:forEach items="${document.docLine}" var="docLine">
							<c:if test='${docLine.approverType eq "agreer"}'>
							<tr>
								<td>${docLine.jobName}</td>
								<c:choose>
									<c:when test="${docLine.status eq 'notdecided' }">
										<c:if test="${docLine.approver == loginEmpNo }">
										<td>
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#approvalModal">결재</button>
											<input type="hidden" id="maxAuthority" value="${docLine.maxAuthority}"/>
											<input type="hidden" id="lv" value="${docLine.lv}"/>
										</td>
										</c:if>
										<c:if test="${docLine.approver != loginEmpNo }">
										<td class="bg-warning text-white">미결재</td>
										</c:if>
									</c:when>
									<c:when test="${docLine.status eq 'approved' }">
										<td class="bg-success text-white">결재완료</td>
									</c:when>
									<c:when test="${docLine.status eq 'rejected' }">
										<td class="bg-danger text-white">반려</td>
									</c:when>
									<c:when test="${docLine.status eq 'afterview' }">
										<td class="bg-secondary text-white">후열</td>
									</c:when>
								</c:choose>
								<td>${docLine.empName}</td>
							</tr>
							</c:if>
						</c:forEach>
						<tr>
							<td rowspan="4" align="center" class="table-secondary">시<br/>행</td>
						</tr>
						<c:forEach items="${document.docLine}" var="docLine">
							<c:if test='${docLine.approverType eq "enforcer"}'>
							<tr>
								<td>${docLine.jobName}</td>
								<c:if test="${docLine.status eq 'afterview' }">
									<td class="bg-secondary text-white">후열</td>
								</c:if>
								<td>${docLine.empName}</td>
							</tr>
							</c:if>
						</c:forEach>
						<tr>
							<td rowspan="4" align="center" class="table-secondary">수<br/>신<br/>참<br/>조</td>
						</tr>
						<c:forEach items="${document.docLine}" var="docLine">
							<c:if test='${docLine.approverType eq "referer"}'>
							<tr>
								<td>${docLine.jobName}</td>
								<c:if test="${docLine.status eq 'afterview' }">
									<td class="bg-secondary text-white">후열</td>
								</c:if>
								<td>${docLine.empName}</td>
							</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
				<div class="doc-content">
					${document.content}
				</div>
		
				<div id="attach-container">
				
				<c:forEach items="${docAttachList}" var="attach">
				<button type="button" 
						class="btn btn-outline-success btn-block"
						onclick="location.href='${pageContext.request.contextPath}/document/fileDownload.do?no=${attach.no}';">
					첨부파일 - ${attach.originalFilename }
				</button>
				</c:forEach>
				</div>

			</article>
		</section>
		
		<sec:authorize access="hasRole('ROLE_ADMIN')" >
			<form:form id="docDelFrm" 
				action="${pageContext.request.contextPath}/document/docDelete"
				method="POST">
			<input type="hidden" name="docNo" value="${document.docNo}"/>
			<button type="submit" id="delBtn" class="btn btn-danger">문서 삭제</button>
			</form:form>
		</sec:authorize>
		
		<sec:authorize access="!hasRole('ROLE_ADMIN')" >
			<sec:authentication property="principal.empNo" var="empNo" />
			<c:if test="${document.writer eq empNo}">
				<form:form id="docDelFrm"
					action="${pageContext.request.contextPath}/document/docDelete"
					method="POST">
				<input type="hidden" name="docNo" value="${document.docNo}"/>
				<button type="submit" id="delBtn" class="btn btn-danger">문서 삭제</button>
				</form:form>
			</c:if>
		</sec:authorize>
		</div>
	</div>
	<!-- footer -->
	<div class="card shadow mb-4">
	<!-- Card Header - Dropdown -->
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">댓글</h6>
	</div>
	<!--  Body -->
	<div class="card-body ">
	
			<footer>
			<div id="reply-container">
				<ul class="list-group">
					
				<c:forEach items="${docReplyList}" var="docReply" varStatus="">
				<li class="list-group-item">
					<div class="d-flex w-100 justify-content-between">
						<p class="mb-1 font-weight-bold" >
							${docReply.depName }
							${docReply.jobName }
							${docReply.writerName }
						</p>
						<small><fmt:formatDate value="${docReply.regDate }" pattern="yyyy-MM-dd hh:mm:ss"/></small>
					</div>
					<p class="mb-1">${docReply.content }</p>
				</li>
				</c:forEach>
				</ul>
				<br />
				<form:form id="replyFrm" 
					action="${pageContext.request.contextPath}/document/docReply"
					method="post">
				<input type="hidden" name="docNo" value="${document.docNo}"/>
				<input type="hidden" name="writer" value="${loginEmpNo}"/>
				<textarea class="form-control" name="content"></textarea>
				<br />
				<button type="submit" id="replyBtn" class="btn btn-primary">댓글등록</button>
				</form:form>
			</div>
		</footer>
		
	</div>
</div>
</div>
		
</main>
<script>

<sec:authorize access="!hasRole('ROLE_ADMIN')" >
$("#docDelFrm").submit(function( event ) {
	  if(${counter}>0){
		  alert("이미 결재가 진행되어 문서를 삭제할 수 없습니다.")
		  event.preventDefault();
		}
	});
</sec:authorize>

//결재선 가로정렬
$("#docLineTable").each(function() {
    var $this = $(this);
    var newrows = [];
    $this.find("tr").each(function(){
        var i = 0;
        $(this).find("td").each(function(){
            i++;
            if(newrows[i] === undefined) { newrows[i] = $("<tr></tr>"); }
            newrows[i].append($(this));
        });
    });
    $this.find("tr").remove();
    $.each(newrows, function(){
        $this.append(this);
    });
});

$(document).ready(function(){       
    $('#approvalModal').on('hidden.bs.modal', function () {
        console.log("숨겨짐");
    });

	$("#save").click(function(event){
		//event.preventDefault();
		var maxAuthority = $("#maxAuthority").val();
		var lv = $("#lv").val();

		$("#docLineFrm").find("[name=maxAuthority]").val(maxAuthority);
		$("#docLineFrm").find("[name=lv]").val(lv);

	});
});
 

</script>

<!-- Modal -->
<div class="modal fade" id="approvalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결재여부 선택</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form:form
      		id="docLineFrm"
      		action="${pageContext.request.contextPath}/document/docDetail"
			method="POST">
      <div class="modal-body">
		<div class="form-check">
	      <input class="form-check-input" type="radio" name="status" value="approved" id="btn1" />
	      <label class="form-check-label" for="btn1">
	      	승인
	      </label>
		</div>
		<div class="form-check">
	      <input class="form-check-input" type="radio" name="status" value="rejected" id="btn2"/>
	      <label class="form-check-label" for="btn2">
	      	반려
	      </label>
		</div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-success" id="save">저장</button>
        <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
      </div>
      <input type="hidden" name="docNo" value="${document.docNo}"/>
      
      <input type="hidden" name="approver" value="${loginEmpNo}"/>
      <input type="hidden" name="maxAuthority" value=""/>
      <input type="hidden" name="lv" value=""/>
      </form:form>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	