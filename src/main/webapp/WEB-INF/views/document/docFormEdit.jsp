﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:import url="/document/docMenu"></c:import>

<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<style>
.note-editable {
	background-color: white; 
}
table {
  width: 100%;
  border: 1px solid #444444;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #444444;
  text-align: center;
}
.vertical{
	writing-mode: vertical-lr;
}
.vertical-th{
	width: 40px;
}
h1{
	margin: 20px;
	text-align: center;
}

</style>

<div class="col-xl-9">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">기존 문서양식 수정</h6>
		</div>
		<!--  Body -->
		<div class="card-body ">
		
<section>
<c:if test="${not empty msg}">
<div class="alert alert-warning alert-dismissible fade show" role="alert">
  <strong>${msg}</strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
</c:if>
	<header>
		<!-- <h1>기존 문서양식 수정 페이지</h1> -->
	</header>
	<article>
		<div id="container">
		<form:form 
			name="documentFrm" 
			action="${pageContext.request.contextPath}/document/docFormEdit" 
			method="post" >
			
			<!-- 문서양식 선택 -->
			<div class="input-group mb-3">
				<select class="custom-select" id="docFrmSelect">
					<option selected>문서양식을 선택하세요</option>
					<c:forEach items="${docFormList }" var="docForm">
					<option value="${docForm.no}">${docForm.title}</option>
					</c:forEach>
				</select>
			</div>
						
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">양식 번호</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				 name="no" id="no" required readonly>
			</div>			
						
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">양식 이름</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="title" id="title">
			</div>			
						
			<!-- <div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">양식 타입</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="type" id="type">
			</div> -->
			<!-- 테이블 임시 작성 -->
			<div id="tempDiv">

			
			
			
			</div>

			<textarea class="form-control" id="summernote" name="content"></textarea>
			<br />
			
			<input type="submit" class="btn btn-outline-success" value="제출" >
		</form:form>
	</div>
	</article>
</section>

		</div>
	</div>
</div>
</div>
		
</main>

<script>
function bootAlert(str,dest){
	var html = `
		<div class="alert alert-danger alert-dismissible fade show" role="alert">
			<strong>\${str}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			 <span aria-hidden="true">&times;</span>
			</button>
		</div>
		`;
	dest.before(html)
	//alert로 화면 이동
	var offset = $('.alert').offset();
	$('html').scrollTop(offset.top);
	//알람창 자동제거
    $(".alert").fadeTo(2000, 500).slideUp(500, function() {
        $(this).slideUp(500);
        $(this).remove();
    });
}
/* Validation */
$("[name=documentFrm]").submit(function(e) {

	var ex = $('#no').val();
	console.log("no = " + ex);
 	if ($('#no').val() == '' ) {
		bootAlert('문서양식을 선택해주세요',$('#docFrmSelect').closest('div'));
		return false;
	}
	
	
	if ($('#title').val()=='') {
		bootAlert('문서제목을 입력해주세요',$('#title').closest('div'));
		return false;
	}	
	
	if ($('#summernote').summernote('isEmpty')) {
		bootAlert('문서내용을 입력해주세요',$('#summernote'));
		return false;
	}

	return true;
});

$("#docFrmSelect").change(function(e) {
	console.log(this.value);
	//$('#summernote').summernote('insertText', '<p>테스트</p>');
	//$('.note-editable').html('<p>테스트</p>');
	
	$.ajax({
		url: `${pageContext.request.contextPath}/document/docFormSelect?no=\${this.value}`,
		success(data){
			console.log(data);

			if(data){
				$('.note-editable').html(data.content);
				$('#summernote').summernote('insertText', '');
				
				$('#title').val(data.title);
				$('#no').val(data.no);
			}
		},
		/*
			ResponseEntity로 검색결과 없을때 404 return하게 바꿨기 때문에
			위의 else문에 들어가지 않고 아래의 error코드로 들어가게 된다. 
		 */ 
		error(xhr, statusText, err){
			console.log(xhr, statusText, err);

			const {status} = xhr;
			status == 404 && alert("해당 양식이 존재하지 않습니다.");
			$("[name=id]", e.target).select();
		}
	});
	
});


$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 500,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  //placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
	//$('#summernote').summernote('insertText', 'textsomething');
	//$('#summernote').summernote('enable');
});-


$("#docLineBtn").click(function(){
	// 새창에 대한 세팅(옵션)
    var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=800,left=0,top=0';
    // 자식창을 열고 자식창의 window 객체를 windowObj 변수에 저장
    windowObj = window.open("${pageContext.request.contextPath}/employeeList/eListForDoc","자식창",settings);
    
    windowObj.onbeforeunload = function(){
        //자식창 닫힐때 이벤트감지
        
    };

   

});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	