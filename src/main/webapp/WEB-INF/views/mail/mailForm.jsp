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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mail.css" />

<script>
function mailValidate(){
	var $title = $("[name=mailTitle]");
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	return true;
}

var receiverArr = [];

$(() => {
	$("[name=upFile]").change(e => {
		var file = $(e.target).prop('files')[0];
		console.log(file);
		var $label = $(e.target).next();
		
		$label.html(file? file.name : "파일을 선택하세요.");
	});
});

$(() => {

	let b;
	
	$("#toInput").on("propertychange change keyup paste input", function(){
		var currentVal = $(this).val();

		console.log(currentVal.indexOf(','));
		if(currentVal.indexOf(',') != -1 ){
			$("#toInput").val('');
			let c = currentVal.split(',');
			var a = c[0];
			
			if(a.indexOf('@') != -1){
				b = a.replace('@', '').split('.')[0];

				for(var i = 0; i < $('.tf_edit').length; i++){
					if($('.tf_edit').eq(i).attr("value") == a){
							alert("받는 사람이 중복되었습니다.");

							$(this).val("");
							return false;
						}
				}

				$("#toInput").before(
						"<div class='box_address box_out' id=a" + b + ">" + 
						"<em class='txt_address'>" + a + "</em>" + 
						"<a href='javascript:delBtn(a" + b + ", 3);' class='btn_del' title='" + a + " 삭제'>" +
							"<span> X</span>" + 
						"</a>" + 
						"<input class='tf_edit' type='hidden' value=" + a + ">" +
					"</div>"
				);

			}
			else {
				//b = a;
				$("#toInput").before(
						"<div class='box_address box_invalid' id=" + a + ">" + 
						"<em class='txt_address'>" + a + "</em>" + 
						"<a href='javascript:delBtn(" + a + ", 2);' class='btn_del' title='" + a + " 삭제'>" +
							"<span> X</span>" + 
						"</a>" + 
						/* "<input class='tf_edit' type='hidden' value=" + a + ">" + */
					"</div>"
					);
			}
		}	
	});

	$("#toInput").autocomplete({
 		source: function(request, response){	 		

 	 	  $.ajax({
			url: "${pageContext.request.contextPath}/mail/searchReceiver.do",
			data: {
				searchReceiver: request.term
			},
			success(data){
				console.log(data);
				const {list} = data;
				const arr = 
					list.map(({empNo, empName, jobName, depName}) => ({ // 부서명, 직업명, 이름, 사원번호
						label: empName + ' ' + jobName + '(' + depName + ')',
						value: empName,
						empNo
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
			
			const {item: {value, empNo}} = selected;

			b = value;

			for(var i = 0; i < $('.tf_edit').length; i++){
				//if($('.tf_edit').eq(i).attr("value") == empNo){
				if($('.tf_edit').eq(i).attr("value") == value){
						alert("받는 사람이 중복되었습니다.");

						$(this).val("");
						return false;
					}
			}

 			$("#toInput").before(
					"<div class='box_address' id=" + value + ">" + 
					"<em class='txt_address'>" + value + "</em>" +
					"<a href='javascript:delBtn(" + b + ", 1);' class='btn_del' title='" + value + " 삭제'>" + 
						"<span> X </span>" + 
					"</a>" + 
					/* "<input class='tf_edit' type='hidden' value=" + empNo + ">" +  */
					"<input class='tf_edit' type='hidden' value=" + value + ">" +
					"</div>"
				);

 			$(this).val("");
			return false;

		},
		focus: function(event, focused){
		 return false;
		},
		autoFocus: true
 	});

});

function beforeSubmit(){
	var mailFrm = document.mailFrm;

	for(var i = 0; i < $('.tf_edit').length; i++){
		receiverArr.push($('.tf_edit').eq(i).attr("value"));
	}
	
	$("#receiverArr").val(receiverArr);

	mailFrm.submit();
}
function delBtn(b, i){
	if(i == 1){
		//console.log(b.id);
		$("#" + b.id).remove();
	}
	else if (i == 2){
		$("#" + b).remove();
	}
	else if (i == 3){
		//console.log(b.id);
		$("#" + b.id).remove();
	}
}
	
function goBack(){
	window.history.back();
	
}
</script>

<div class="container">
	<h4 class="page-header">메일 보내기</h4>
	<form
		name="mailFrm"
		action="${pageContext.request.contextPath}/mail/mailEnroll.do"
		method="post"
		enctype="multipart/form-data"
		onsubmit="return mailValidate();">
		
		<table class="table">
		<tr>
			<td style="width: 10%">보내는 사람</td>
			<td>1</td> <%-- ${이름} --%>
		</tr>
		<tr>
			<td style="width: 10%">받는 사람</td>
			<td style="height: 0.5vh">
				<div class = "address_info">
					<!-- <input class="hiddenForBubble" type="text" aria-hidden="true" style="left: -10000px;width: 1px; position: absolute;" value> -->
					<!-- <textarea id="toTextarea" class="tf-address"></textarea> -->
					<input style="width: 40%" id="toInput" class="tf-address"/>
					<br><span class="s1"style="border: 1px; font-size:1px; color: #848485">사내 메일은 선택, 외부 이메일은 ,로 구분합니다.</span>
					<input type="hidden" name="receiverArr" id="receiverArr" value=''>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width: 10%">제목</td>
			<td><input type="text" name="mailTitle" id="mailTitle" style="width: 60%" required></td>
		</tr>
		<tr>
			<td style="width: 10%">첨부</td>
			<td>
				 <div class="custom-file">
				   <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple />
				   <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
				 </div>
			</td>
		</tr>
		<tr>
			<td colspan="2"><textarea class="form-control" name="mailContent" rows="10"></textarea></td>
		</tr>
		</table>
			
		<div class="text-right">
			<input type="button" class="btn btn-outline-primary" onclick="beforeSubmit();"value="전송"/>
			<button type="button" class="btn btn-outline-danger" onclick="goBack();">취소</button>
		</div>
	</form>	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>