<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cal.min.css" />
<script src="<%= request.getContextPath() %>/resources/js/calendar/main.min.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/calendar/ko.js"></script>

<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/js/tempusdominus-bootstrap-4.min.js" integrity="sha512-k6/Bkb8Fxf/c1Tkyl39yJwcOZ1P4cRrJu77p83zJjN2Z55prbFHxPs9vN7q3l3+tSMGPDdoH51AEU8Vgo1cgAA==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/css/tempusdominus-bootstrap-4.min.css" integrity="sha512-3JRrEUwaCkFUBLK1N8HehwQgu8e23jTH4np5NHOmQOobuC4ROQxFwFgBLTnhcnQRMs84muMh0PnnwXlPq5MGjg==" crossorigin="anonymous" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.1.4/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.1.4/css/bootstrap-datetimepicker.min.css"> -->

<script>
var calendar = null;

$(document).ready(function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: 'dayGridMonth',
    	headerToolbar: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      	},
	    locale: 'ko',
	    selectable: true,
	    /* initialDate: '2020-09-12', */
	    navLinks: true, // can click day/week names to navigate views
	    editable: true,
	    dayMaxEvents: true, // allow "more" link when too many events
	
	    dateClick: function(info){
		      //alert(info.dateStr);
		      $('#eventModal').modal();
		      $('.btn-modifyEvent').hide();

		},
	   
/* 	    events: [
	      {
	        title: 'All Day Event',
	        start: '2020-09-01'
	      },
	      {
	        title: 'Long Event',
	        start: '2020-09-07',
	        end: '2020-09-10'
	      },
	      {
	        groupId: 999,
	        title: 'Repeating Event',
	        start: '2020-09-09T16:00:00'
	      },
	      {
	        groupId: 999,
	        title: 'Repeating Event',
	        start: '2020-09-16T16:00:00'
	      },
	      {
	        title: 'Conference',
	        start: '2020-09-11',
	        end: '2020-09-13'
	      },
	      {
	        title: 'Meeting',
	        start: '2020-09-12T10:30:00',
	        end: '2020-09-12T12:30:00'
	      },
	      {
	        title: 'Lunch',
	        start: '2020-09-12T12:00:00'
	      },
	      {
	        title: 'Meeting',
	        start: '2020-09-12T14:30:00'
	      },
	      {
	        title: 'Happy Hour',
	        start: '2020-09-12T17:30:00'
	      },
	      {
	        title: 'Dinner',
	        start: '2020-09-12T20:00:00'
	      },
	      {
	        title: 'Birthday Party',
	        start: '2020-09-13T07:00:00'
	      },
	      {
	        title: 'Click for Google',
	        url: 'http://google.com/',
	        start: '2020-09-28'
	      }
	    ]*/
	  });

 	  $('#sch-start').datetimepicker({
			format: 'YYYY-MM-DD HH:mm',
			locale: 'ko'
		});

 	  $('#sch-end').datetimepicker({
			format: 'YYYY-MM-DD HH:mm',
			locale: 'ko'
		});
	
	  calendar.render();
	
});

function beforeSubmit(){
	if(($('#sch-title').val())  == '') {
		alert("일정 제목을 적어주세요.");
		return false;
	}

	if(($('#sch-start').val()) > ($('#sch-end').val())){
		alert("끝나는 날짜가 시작 날짜보다 먼저입니다.");
		return false;
	}

	var calMap= {
			"title": $('#sch-title').val(),
			"start": $('#sch-start').val(),
			"end": $('#sch-end').val(),
			"content": $('#sch-content').val(),
			"type": $('#sch-type').val(),
			"empNo": 1 //수정
	};

	$.ajax({
		url: "${pageContext.request.contextPath}/calendar/calendarEnroll.do",
		data: calMap,
		type: "POST",
		success: function(data){
			alert("일정 등록 성공");
			$('#eventModal').modal('hide');
			//location.reload();
		}
	});

}
</script>

<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>
</head>
<body>

  <div id='calendar'></div>
  
  <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
  	<div class="modal-dialog" role="document">
  		<div class="modal-content">
  			<div class="modal-header">
  				<h5 class="modal-title" id="headerLabel">일정 추가</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
  			</div>
  			
  			<div class="modal-body">
  			<table class="table">
				<tr>
					<td>하루 종일</td>
					<td><input class="allDayNewEvent" type="checkbox" name="sch-allDay" id="sch-allDay"/></td>
				</tr>
				<tr>
					<td>시작</td>
					<td><input class="inputModal" type="text" name="sch-start" id="sch-start" data-toggle="datetimepicker" data-target="#sch-start"/></td>
				</tr>
				<tr>
					<td>끝</td>
					<td><input class="inputModal" type="text" name="sch-end" id="sch-end" data-toggle="datetimepicker" data-target="#sch-end"/></td>
				</tr>
				<tr>
					<td>구분</td>
					<td>
						<select class="inputModal" type="text" name="sch-type" id="sch-type">
  							<option value="회의" style="color:red;">회의</option>
  							<option value="출장" style="color:green;">출장</option>
  							<option value="프로젝트" style="color:blue;">프로젝트</option>
  							<option value="기타" style="color:purple;">기타</option>
  						</select>
  					</td>
				</tr>
				<tr>
					<td>일정 제목</td>
					<td><input class="inputModal" type="text" id="sch-title" name="sch-title" required/></td>
				</tr>
				<tr>
					<td>일정 내용</td>
					<td><textarea rows="7" cols="50" class="inputModal" id="sch-content" name="sch-content" style="resize: none"></textarea></td>
				</tr>
			</table>
			</div>
			
  			<div class="modal-footer btn-addEvent">
  				<button type="button" class="btn btn-outline-primary" onclick="beforeSubmit();">저장</button>
  				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
  			</div>
  			<div class="modal-footer btn-modifyEvent">
  				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
  				<button type="button" class="btn btn-outline-primary">저장</button>
  				<button type="button" class="btn btn-outline-danger">삭제</button>
  			</div>
  		</div>
  	</div>  
  </div>

</body>
</html>
