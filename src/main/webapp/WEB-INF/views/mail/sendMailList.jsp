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

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
function goMailForm(){
	location.href = "${pageContext.request.contextPath}/mail/mailForm.do";
}

function chkOne(chk){
     var parentTd = chk.parentNode;
     console.log(parentTd);

     if(chk.checked)
         parentTd.classList.toggle("on");
     else
         parentTd.classList.toggle("on");

     var chkbox = document.querySelectorAll("[name=chkbox");
     for(var i = 0; i < chkbox.length; i++){
         if(!chkbox[i].checked){
             checkAll.checked = false;
             return;
        }
    }
}

function chkAll(){
     var chkbox = document.querySelectorAll("[name=chkbox]");
     console.log(chkbox);
     var checkAll = document.querySelector("#checkAll");
     console.log(checkAll);
     for(var i = 0; i < chkbox.length; i++){
    	 chkbox[i].checked = checkAll.checked;
    }
}

$(() => {
	$("tr[data-no]").click(e=> {

		var $tr = $(e.target).parents();
		var no = $tr.data("no");
		//location.href = "${pageContext.request.contextPath}/mail/mailDetail.do?no=" + no;
		location.href = "${pageContext.request.contextPath}/mail/sendMailView.do?no=" + no;
	});

	$( "#searchMail" ).autocomplete({
 		source: function(request, response){	 		
  			var searchMap= {
 		 			"searchTerm": request.term,
 		 			"who": 1
			
 		 	};
 	 	  $.ajax({
			url: "${pageContext.request.contextPath}/mail/searchMail.do",
			data: 
				searchMap
			,
			success(data){
				console.log(data);
				const {list} = data;
				const arr = 
					list.map(({mailNo, mailTitle, mailContent, receiverAdd}) => ({
						label: '메일 제목 : ' + mailTitle,
						value: mailTitle,
						mailNo
/* 						mailContent,
						receiverAdd,
						mailNo */
					}));
				console.log(arr);
				response(arr);
			},
			error(xhr, statusText, err){
				console.log(xhr, statusText, err);
			}
 	  	  });
		},
		select: function(event, selected){
			const {item: {mailNo}} = selected;
			console.log(mailNo);
			//location.href = "${pageContext.request.contextPath}/mail/mailDetail.do?no=" + mailNo;
			location.href = "${pageContext.request.contextPath}/mail/sendMailView.do?no=" + mailNo;
		},
		focus: function(event, focused){
		 return false;
		},
		autoFocus: true
 	});


});

function deleteMail(){
	//보낸 사람 삭제 구분 변수
	//1 : sender, 2 : receiver
	var who = 1;
	var valueArr = new Array();
	var list = $("input[name='chkbox']");
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){
			valueArr.push(list[i].value);
		}
	}
	if(valueArr.length == 0){
		alert("선택된 글이 없습니다.");
	}
	else {
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
						location.reload();
						//window.location.href='${pageContext.request.contextPath}/mail/sendMailList.do?sender_no=1'
					}
					else {
						alert("삭제 실패하였습니다.");	
					}
				}

			});
		}
	}
}
</script>

<div class="container">
	<h4 class="page-header">보낸 메일함</h4>
	
	<input type="search" placeholder="메일 제목, 받은 사람, 내용 검색" id="searchMail" class="form-control col-sm-3 d-inline"/>
	<div class="text-right"> 
		<input type="button" value="메일 보내기" id="writeBtn" class="btn btn-outline-primary" onclick="goMailForm();"/>
		<input type="button" value="삭제" id="delBtn" class="btn btn-outline-danger" onclick="deleteMail();"/>
	</div>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">
					선택
					<input type="checkbox" id="checkAll" onchange="chkAll();">
				</th>
				<th scope="col">받은 사람</th>
				<th scope="col">제목</th>
				<th scope="col">발신일</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="mail">
				<tr data-no="${mail.mailNo}">
					<td onclick="event.cancelBubble=true"><input id="chk" type="checkbox" name="chkbox" onclick="chkOne(this)" value="${mail.mailNo}"/></td>
					<%-- <td>${mail.receiverNo}</td> --%>
					<%-- <td>${mail.receiverAdd}</td> --%>
					<td>
						<c:set var = "receiverAdd" value="${fn:replace(mail.receiverAdd, ':', '')}"/>
						${receiverAdd}
					</td>
					<td>${mail.mailTitle}</td>
					<td><fmt:formatDate value="${mail.sendDate}" pattern="yy-MM-dd HH:mm:ss"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	${pageBar}
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>