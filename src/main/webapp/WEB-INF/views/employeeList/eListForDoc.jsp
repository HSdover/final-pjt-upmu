<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직원 리스트</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/eListForDoc.css" />
</head>
<body>

<div class="list-form">
	<div class="depart-list list">
		<details>
	        <summary class="dList-all">
	        	부서 목록
	        </summary>
		    <c:forEach items="${dList}" var="dept">
				<p class="${dept.depNo} dept">${dept.depName}</p>
			</c:forEach>
	   	</details>
	</div>
	<div class="employee-list list">
	</div>
	
	<div class="right-box">
		
		<!-- 결재자 선택결과 -->
		<div class="approver-list list">
			<!-- listBox는 일부만 다르므로 함수형태로. -->
			<c:set var="approverTypeArray">approver,agreer,enforcer,referer</c:set>
			<c:forEach var="approverType" items="${approverTypeArray}">
			<div class="listBox">
				<button type="button" class="btn btn-outline-primary btn-block" name="approver-btn" value="${approverType}">
					<c:choose>
						<c:when test="${approverType eq 'approver'}">결재자</c:when>
						<c:when test="${approverType eq 'agreer'}">합의자</c:when>
						<c:when test="${approverType eq 'enforcer'}">시행자</c:when>
						<c:when test="${approverType eq 'referer'}">수신참조자</c:when>
					</c:choose>
				▼</button>
				<select id="${approverType}" size="5" ></select>
				<div>			
					<button class="btn btn-outline-secondary" id="optUp">▲</button>
					<button class="btn btn-outline-secondary" id="optDown">▼</button>
					<button class="btn btn-outline-secondary" id="optDel">Ｘ</button>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="right-down">
			<button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="right" 
			title="결재자 : 실제 문서의 결재선에 포함되는 사람. 여기서 미결재가 존재하면 결재가 종료되지 않는다.
	윗사람이 결재를 승인하면 아랫사람은 후열로 자동 변경된다.
합의자 : 문서의 결재선에는 포함되어 있지만 결재승인을 해도 자기자신만 결재완료로 변경되며
	다른 사람의 결재상태를 변경시키지 않는다.
시행자/수신참조자 : 결재요구하는 대상자는 아니지만 문서에 추가하여 열람을 요구한다.">
			  결재자란?
			</button>
			<button type="button" class="btn btn-outline-success" onclick="saveBtn();">저장</button>
			<button type="button" class="btn btn-outline-danger" onclick="window.close();">닫기</button>
			<!-- <button type="button" class="btn btn-outline-danger" onclick="test();">test</button> -->
		</div>
	</div>
	
</div>

<script>
$(document).on('click', '#optUp', function(e) {
	var $selected = $(e.target).closest('.listBox').find('option:selected');
	$selected.insertBefore($selected.prev().get(0));
});
$(document).on('click', '#optDown', function(e) {
	var $selected = $(e.target).closest('.listBox').find('option:selected');
	$selected.insertAfter($selected.next().get(0));
});
$(document).on('click', '#optDel', function(e) {
	var $selected = $(e.target).closest('.listBox').find('option:selected');
	$selected.remove();
});

function test(){
	$optArr = $("option");
	var apCnt = 0;
	let agrCnt = 0;
	
	$optArr.each(function(index, item){
		approverType = item.dataset.approvertype;

		switch(approverType){
		case 'approver' : apCnt++; break;
		case 'agreer' : agrCnt++; break;
		}
	});
	//합의자는 결재자가 존재할때만 입력할 수 있다
	//즉 결재자가 0이면서 합의자>0은 존재해선 안된다.
	if(apCnt==0 && agrCnt>0){
		console.log("합의자를 등록하려면 결재자가 한명 이상 있어야 합니다.");
	}
}

function saveBtn(){
	$optArr = $("option");
	let apvCnt = 0;
	let agrCnt = 0;
	var flag = true;
	
	let html = `<table class="table table-sm" id="docLineTable">
		<tr>
			<th scope="col">결재종류</th>
			<th scope="col">직위</th>
			<th scope="col">이름</th>
		</tr>
	`;	
	
	$optArr.each(function(index, item){
		empNo = item.dataset.empno;
		empName = item.dataset.empname;
		approverType = item.dataset.approvertype;
		empJob = item.dataset.empjob;
		let typeName;

		switch(approverType){
		case 'approver' : 
			apvCnt++;
			typeName = '결재자'; 
			break;
		case 'agreer' : 
			agrCnt++;
			typeName = '합의자'; 
			break;
		case 'enforcer' : 
			typeName = '시행자'; 
			break;
		case 'referer' : 
			typeName = '수신참조자'; 
			break;
		}
		//합의자는 결재자가 존재할때만 입력할 수 있다
		//즉 결재자가 0이면서 합의자>0은 존재해선 안된다.
		if(apvCnt==0 && agrCnt>0){
			alert("합의자를 등록하려면 결재자가 한명 이상 있어야 합니다.");
			flag = false;
			return false;
		}
		
		html += `
			<tr>
				<td>\${typeName}</td>
				<td>\${empJob}</td>
				<td>\${empName}</td>
			</tr>
			<input type="hidden" name="docLines[\${index}].approver" value="\${empNo}"/>
			<input type="hidden" name="docLines[\${index}].approverType" value="\${approverType}"/>
			`;
		if(approverType == 'approver'){
			html+=`<input type="hidden" name="docLines[\${index}].lv" value="\${apvCnt}"/>`;
		}
	});
	if(flag==false)
		return false;
	

	//approver의 마지막 input만 maxAuthority="Y"
	if(apvCnt>0){
		html+=`<input type="hidden" name="docLines[\${apvCnt-1}].maxAuthority" value="Y"/>`;
		
	}

	html += "</table>";
	$(opener.document).find("#docLineDiv").html(html);
	window.close();
}

	//결재자 클릭하면 select name="approver" 에 id 추가
	$("[name=approver-btn]").click((e)=>{
		var approverType = e.target.value;
		
		var $emp = $("[name=radioBtn]:checked");
		if($emp.length==0){
			alert("선택된 인원이 없습니다");
			return;
		}
		
		empNo = $emp.data("empno");
		empName = $emp.data("empname");
		empJob = $emp.data("empjob");

		//empNo가 approver>option에 이미 존재하면 alert띄우고 추가시키면 안됨.
		var $approverList = $(".listBox>select>option");
		var flag = true;
		$approverList.each(function(index, item){
			if(empNo == item.dataset.empno){
				alert("이미 추가된 인원입니다");
				flag = false;
				return;
			}
		});
		if(flag==false)
			return;
		
		var option = `<option name="\${approverType}" data-empno="\${empNo}" data-empname="\${empName}" data-approvertype="\${approverType}" data-empjob="\${empJob}">\${empName}</option>`;
		var $select = $("#"+approverType);
		$select.append(option);
				
	});
	
	//목록에서 employee불러오기
	var getClass;
	
	$(".dept").click((e) => {
		getClass = {"depNo" : ($(e.target).attr('class').split(' '))[0]};

		console.log(getClass);
		$.ajax({
			url: "${pageContext.request.contextPath}/employeeList/selectOneDeptEmp.do",
			method: "GET",
			data: getClass,
			success(data){
				console.log(data);
				displayTable(data.eList);
			},
			error: console.log
		})
	});

	//DB에서 불러온 데이터 테이블에 추가하는 함수
	function displayTable(data) {
		let html = "<table><tr><th> </th><th>사번</th><th>이름</th><th>직급</th><th>부서</th></tr>";
		if(data.length > 0){
			$(data).each((i, eList) => {
				const {empNo, empName, empJob, empDept, empPhone, empEmail} = eList;
				html += `
					<tr>
					<td><input type="radio" name="radioBtn" data-empno="\${empNo}" data-empName="\${empName}" data-empjob="\${empJob}"></td>
					<td>\${empNo}</td>
					<td>\${empName}</td>
					<td>\${empJob}</td>
					<td>\${empDept}</td>
					</tr>`;
			});
		}
		else {
			html += "<td colspan='7'>결과가 없습니다.</td></tr>"
		}
		html += "</table>";
		$(".employee-list").html(html);
	}

	//부서삭제
	
	//마우스 오른쪽 버튼 끄기
	$(".dept").on('contextmenu', () => {
  		return false;
	});

	//context-menu 끄기
	$(document).click(e =>{
		$("#context-menu").hide();
	})

</script>
</body>
</html>