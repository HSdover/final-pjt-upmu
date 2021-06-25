<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js" integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sidebars.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directMsg.css">  
	
<div class="flex-shrink-0 p-3 bg-white" style="width: 200px; left:0; margin:0px; position:fixed">
    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-5 fw-semibold">Collapsible</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
          Home
        </button>
        <div class="collapse show" id="home-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="link-dark rounded">Overview</a></li>
            <li><a href="#" class="link-dark rounded">Updates</a></li>
            <li><a href="#" class="link-dark rounded">Reports</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          Dashboard
        </button>
        <div class="collapse" id="dashboard-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="link-dark rounded">Overview</a></li>
            <li><a href="#" class="link-dark rounded">Weekly</a></li>
            <li><a href="#" class="link-dark rounded">Monthly</a></li>
            <li><a href="#" class="link-dark rounded">Annually</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#join-collapse" aria-expanded="false">
          채널 리스트
        </button>
        <div class="collapse" id="join-collapse">
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
          유저 리스트
        </button>
        <div class="collapse" id="account-collapse">
        </div>
      </li>
    </ul>
  </div>

<div class="container offset-md-2">
	<div class="row justify-content-start">
		<h2>방 이름 : ${chatroom.title}</h2>
	
	
		<!-- <div class="col-md-2 d-flex flex-column flex-shrink-0 p-3">
		 <div class="accordion" id="accordionPanelsStayOpenExample">
	  		<div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		         테스트 #1
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingOne">
		      <div class="accordion-body">
		        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            <li><a href="#" class="link-dark rounded">Overview</a></li>
		            <li><a href="#" class="link-dark rounded">Updates</a></li>
		            <li><a href="#" class="link-dark rounded">Reports</a></li>
		          </ul>
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
		        참여 채널리스트
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
		      <div class="accordion-body" id="joinList">
		     </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		        유저리스트
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
		      <div class="accordion-body" id="userList">
		      </div>
		    </div>
		  </div>
		</div>
	</div> 
 -->
	
	
	<div class="col-12">
		<div class="col-md-8 ">
	          <label for="webchat_username">Username(로그인 대신) : </label>
	          <input type="text" id="webchat_username" placeholder="Put your username here..."/>
	          <button class="btn btn-primary" type="button" id="nameSend">유저네임보내기(로그인)</button>
	           <button class="btn btn-primary" type="button" id="disconnect">나가기(로그아웃)</button>
	    </div>
	        <div class="col-md-8">
	          <label for="webchat_username">Dm 받을 사람: </label>
	          <input type="text" id="receive_username" placeholder="Put your receiver here..."/>
	           <button class="btn btn-primary" type="button" id="dmSub">dm보낼 사람과 연결 구독</button>
	        </div>
		<div id="cont" class="mb-3" style="height: 500px; overflow: auto; border:1px solid;">
			
			<ul class="list-group list-group" id="greetings">
			
			</ul>
		</div>
			<div class="input-group mb-3" id="msg-input">
			  <input type="text" id="msg" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2">
			  <button class="btn btn-primary" type="button" id="msgSend"><i class='bx bxs-send' ></i></button>
			</div>
			<div class="input-group mb-3" id="update-container" style="display:none;">
			  <input type="text" class="form-control" placeholder="" id="updateInput" aria-label="Recipient's username" aria-describedby="button-addon2">
			  <input type="hidden" name="msgNo" value="">
			  <button class="btn btn-info" type="button" id="button-addon2" onclick="updateMsgReal()"><i class='bx bxs-send' ></i></button>
			</div>
	
</div>
</div>

<!-- 오프캔버스 버튼 -->
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">주소록 오프캔버스</button>
<button type="button" class="btn btn-primary" onclick="openChat();"><box-icon name='chat' type='solid' color='#ffffff' ></box-icon>
</button>

	<!-- 주소록 오프캔버스 -->
	<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
	  <div class="offcanvas-header">
	    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">주소록</h5>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	  </div>
	  <div class="offcanvas-body">
	    <p>주소록</p>
	    <div class="list-group list-group-flush border-bottom scrollarea" id="addrList">
	      <div class="list-group-item list-group-item-action py-3 lh-tight" > 
	        <div class="d-flex w-80 align-items-center justify-content-between">
	          <strong class="mb-1">사람이름 </strong>
	          <i id="dropdwonIcon" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
			  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
			    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateModal" data-no="" data-title="" id="updateBtn">방 이름 변경</a></li>
			      <li><hr class="dropdown-divider"></li>
			    <li><a class="dropdown-item">주소록 삭제</a></li>
			  </ul>
	        </div>
	     </div> 
	    </div>
	  </div>
	</div>

</div>

 <!-- 개인채팅창 -->
<div class="card card-bordered" id="chat-pop">
 	<div class="card-header">
 		<h4 class="card-title"><strong>Chat</strong></h4>
	</div>
	<div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height:400px !important;">               
		<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;">
			<div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
        </div>
        <div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;">
            <div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div>
        </div>
    </div>
    <div class="publisher bt-1 border-light" id="dm-input"> 
    	<input class="publisher-input" type="text" placeholder="Write something" id="directMsg"> 
    	<span class="publisher-btn file-group"><i class='bx bxs-send' id="dmSend"></i></span>
    </div>
    <div class="publisher bt-1 border-light" id="dm-update" style="display:none;"> 
    	<input class="publisher-input" type="text" placeholder="Write something" id="updateDmInput" >
    	<input type="hidden" name="messageNo" value="">
    	<span class="publisher-btn file-group"><i class='bx bxs-send' onclick="updateDmReal()"></i></span>
    </div>
    
   <!--  <div class="input-group mb-3">
		<input type="text" class="form-control" placeholder="개인메세지 수정할 내용 표시"  aria-label="Recipient's username" aria-describedby="button-addon2">
		
		<button class="btn btn-info" type="button" id="button-addon2" ><i class='bx bxs-send' ></i></button>
	</div> -->
</div>
 
<!-- 토스트 -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 5">
  <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Bootstrap</strong>
      <small id="joinDate">11 mins ago</small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
    </div>
  </div>
</div>


<script>



 		var stompClient = null;
       	
		
    	//native
    	function connect() {
    		const socket = new SockJS(
    				'${pageContext.request.contextPath}/websocket-chat');
    		stompClient = Stomp.over(socket);
    		
    		stompClient.connect({}, frame => {

    			console.log('Connected: ' + frame);
    			
    			//특정 방 구독, 메세지 입력
    			stompClient.subscribe(`/topic/chat/room/${chatroomNo}`, frame => {
    				console.log(frame)
    				showMsg(frame);
    				
    				
    			});

    			//입장 구독
    			stompClient.subscribe(`/topic/chat/greeting/${chatroomNo}`, frame => {
    				console.log(frame);
    				showGreeting(frame);
    				//유저리스트 갱신
    				showUserList();
    				
    			});
				//업데이트 구독
				stompClient.subscribe(`/topic/chat/updated/${chatroomNo}`, frame => {
					//업데이트한 메세지의 높이 전달
    				const type = "up";
    				const body = JSON.parse(frame.body)
    				const {msgNo} = body;
    				const height = $(`#\${msgNo}`).data("lo");
    				
    				chatList(type, height);
    			
    				
				});
				//삭제 구독
				stompClient.subscribe(`/topic/chat/deleted/${chatroomNo}`, frame => {
					    				
    				chatList();
    				
				});

				//나갈때 구독
    			stompClient.subscribe(`/topic/chat/disconnect/${chatroomNo}`, frame => {
    				console.log(frame);
    				showDisconnect(frame.body);
    				//유저리스트 갱신
    				showUserList();
    			});

    		
    			
    		});
    	}		

    	//개인메세지 구독
    	function dconnect() {
    		const socket = new SockJS(
    				'${pageContext.request.contextPath}/websocket-chat');
    		stompClient = Stomp.over(socket);
    		
    		stompClient.connect({}, frame => {

        			//내 개인메세지 구독
    				showDmList();
    				
    				const username = $("#webchat_username").val();
    				const recvname = $("#receive_username").val();
        			stompClient.subscribe(`/user/\${username}/directMsg`, frame => {
        				console.log(frame)
        				showDm(frame);
        				//showDmList();
        			});

        			stompClient.subscribe(`/user/\${username}/updated`, frame => {
        				//업데이트한 메세지의 높이 전달
        				const type = "up";
        				const body = JSON.parse(frame.body)
        				const {messageNo} = body;
        				const height = $(`#\${messageNo}`).data("lo");
        				
        				showDmList(type, height);
        				
        				//showDm(frame);
        						
        			});
				
        			stompClient.subscribe(`/user/\${username}/deleted`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});
    			
    			//보낸개인메세지 구독
        			stompClient.subscribe(`/user/\${recvname}/directMsg`, frame => {
        				//showDmList();
        				
        				showDm(frame);
        						
        			});

        			
        			stompClient.subscribe(`/user/\${recvname}/updated`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});

        			stompClient.subscribe(`/user/\${recvname}/deleted`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});
    			

    		    })
    		}			

				
    			//채팅방에 참여한 인원 가져오는 펑션
				const showUserList = () => {
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/userList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							const $userContainer = $("#account-collapse");
							let html = "<ul class='btn-toggle-nav list-unstyled fw-normal pb-1 small'>";

							$(data).each((index, user) => {
								console.log(user)
								html += `<li>\${user.empNo}</li>`;
								
							})
							
							html += "</ul>";
							$userContainer.html(html);

						},
						error:console.log,

						
					})
				}

				//참여한 채널,챗룸 가져오는 펑션
				const showJoinList = () => {
					const empNo = $("#webchat_username").val();
					
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/joinList/\${empNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							const $joinContainer = $("#join-collapse");
							console.log($joinContainer)
							let html = "<ul class='btn-toggle-nav list-unstyled fw-normal pb-1 small'>";
							
							$(data).each((index, room) => {
								const title = room.TITLE;
								const chatroomNo = room.CHATROOM_NO;
								
								html += `<li>
										<a href=${pageContext.request.contextPath}/chat/room/enter/\${chatroomNo} class="link-dark rounded">\${title}</a>
										</li>`;
							})
							
							html += "</ul>";
							$joinContainer.html(html);

						},
						error:console.log,
					})
				}
							

				//채팅내역 가져오는 펑션
				const chatList = (type, height) => {
					
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/room/chatList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						success(data){
							
							const $container = $("#greetings");
							let html = '';
						
							$.each(data, function(key, value){
								const username = $("#webchat_username").val();
								//console.log(value);
								const {msgNo, chatroomNo, writerNo, msg, regDate} = value;
								const location = $container[0].scrollHeight;
								
								html += `<li class="list-group-item d-flex justify-content-between align-items-start" 
											id="\${msgNo}" data-lo="\${location}" onmouseover="showIcon(\${msgNo})">
											    <div class="ms-2 me-auto">
											      <div class="fw-bold">\${writerNo}</div>
											      \${msg}
											    </div>`;
											if(username == writerNo){    
												html += `<div class="icon-container"><box-icon type='solid' name='edit'
													onclick="updateMsg(\${msgNo}, '\${msg}')"></box-icon>
													<box-icon name='x'  
												    onclick="deleteMsg(\${msgNo})"></box-icon></div>`;
											}
											
										html += `</li>`;
								
								$container.html(html);
								
							})
							//업데이트한 경우 업데이트한 메세지 위치로 이동
							if(type=="up"){
								$("#cont").scrollTop(height);
							} else {
								$("#cont").scrollTop($container[0].scrollHeight);
							}
						
						},
						error:console.log,
					})
				}

				//메세지 수정 전 가져오기
        		const updateMsg = (no, msg) => {
            		$("#msg-input").hide();
            		
					$("#updateInput").val(msg);
					$("[name=msgNo]").val(no);

					$("#update-container").show();

            	}
        		//메세지 실제 수정 
				const updateMsgReal = () => {
					const msg = $("#updateInput").val();
					const msgNo = $("[name=msgNo]").val();
					const chatroomNo = ${chatroomNo};
										
	        		 stompClient.send("/app/update", {}, JSON.stringify({
						'chatroomNo': ${chatroomNo},
						'msgNo' : msgNo,
						'msg' : $("#updateInput").val()
	
					}));
	        			
	        		 $("#msg-input").show();
	        		 $("#update-container").hide();
				}
        		
				
				//메세지 삭제
				const deleteMsg = (msgNo) => {
					console.log(msgNo);

					 stompClient.send("/app/delete", {}, JSON.stringify({
						 'chatroomNo': ${chatroomNo},
							'msgNo' : msgNo
					 }));
					
				}


				//개인메세지 가져오기
    			const showDmList = (type, height) => {
    				const username = $("#webchat_username").val();
    				const recvname = $("#receive_username").val();
						$.ajax({
							url : `${pageContext.request.contextPath}/chat/dmList/\${username}/\${recvname}`,
							method: 'GET',
							contentType:"application/json; charset=utf-8",
							
							success(data){
								//const $container = $("#dmTable");
								const $container = $("#chat-content");
								
								let html = '';
								$.each(data, function(key, value){
									//console.log(value);
									const {messageNo, messageContent, messageTime, messageSender, messageReceiver, readCheck} = value;
															
									//서버와의 시간차 9시간 조정
									const time = moment(messageTime).format("Do hh:mm a")
														
									 if(username == messageSender){       
					                    	html += `<div class="media media-chat media-chat-reverse" id="dm\${messageNo}" onmouseover="showDmIcon(\${messageNo})">
							                            <div class="media-body reverse">
							                                <p>\${messageContent}</p>
								                            </div>
								                            <p class="meta-reverse">\${time}</p>
								                            <div class="icon-dm">
									                         <box-icon type='solid' name='edit' onclick="updateDm(\${messageNo}, '\${messageContent}')"></box-icon>
									                         <box-icon name='x'  onclick="deleteDm(\${messageNo})"></box-icon>
								                         </div>
							                         </div>`;
							                         
					                    	} else {
									
											html += `<div class="media media-chat"> 
							                            <div class="media-body">
							                                <p>\${messageContent}</p>
							                                
								                        </div>
								                        <p class="meta">\${time}</p>
								                     </div>`;
					                   }
									
									
								})
								
								
								$container.html(html)
								const location = $("#chat-content")[0].scrollHeight;
									
									console.log(location)
									
								//업데이트한 경우 업데이트한 메세지 위치로 이동
								if(type=="up"){
									$container.scrollTop(height);
								} else {
									$container.scrollTop($container[0].scrollHeight);
								}
							},
							error:console.log,
						})
						
							console.log($("#chat-content")[0].scrollHeight)
							
        		}


    			//메세지 수정 전 가져오기
        		const updateDm = (no, msg) => {
            		$("#dm-input").hide();
            		$("#dm-update").show();
            		console.log(no, msg)
					$("#updateDmInput").val(msg);
					$("[name=messageNo]").val(no);
					

            	}

        		

    			//실제 수정
				const updateDmReal = () => {
					
					const messageContent = $("#updateDmInput").val();
					const messageNo = $("[name=messageNo]").val();
					const directMsg = {messageContent, messageNo};
					
					stompClient.send("/app/updateDm", {}, JSON.stringify({
						'messageContent': messageContent,
						'messageNo' : messageNo,
						'messageReceiver' : $("#receive_username").val()
					}));

					$("#dm-input").show();
					$("#dm-update").hide();
				}

				//메세지 삭제
				const deleteDm = (messageNo) => {
					console.log(messageNo);
					
					 stompClient.send("/app/deleteDm", {}, JSON.stringify({
						 'messageReceiver' : $("#receive_username").val(),
							'messageNo' : messageNo
							
					 }));

				}
    	
				//입장
				const sendUser = () => {
					stompClient.send("/app/join", {}, JSON.stringify({
						'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
					}));
	
				}

				//나가기
				const sendDisconnect = (msg) => {
    				stompClient.send("/app/disconnect", {}, JSON.stringify({
    					'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
    				}));
    			}

				//메세지 보내기
				const sendMessage = (msg) => {
    				stompClient.send("/app/message", {}, JSON.stringify({
    					'chatroomNo': ${chatroomNo},
    					'writerNo' : $("#webchat_username").val(),
    					'msg' : $("#msg").val()

    				}));
    			}

				//dm 보내기
    			const sendDM = (msg) => {
					stompClient.send("/app/directMsg", {}, JSON.stringify({
    					'messageContent': $("#directMsg").val(),
    					'messageSender' : $("#webchat_username").val(),
						'messageReceiver' : $("#receive_username").val()
    				}));
    			}

    			
				 	
    			
				//입장메세지 출력
				const showGreeting = (joinInfo) => {
					const {empNo, regDate} = JSON.parse(joinInfo.body);
					
					 $(".toast-body").text(`\${empNo}님이 입장하셨습니다.`);
					 $("#joinDate").text(moment((moment().format())).fromNow());
					  $('#liveToast').toast('show');
	    			
	    			
	    		}

				//나갈때 출력
	    		const showDisconnect = (empNo) => {
		    		console.log(empNo)
		    		
		    		 $(".toast-body").text(`\${empNo}님이 나가셨습니다.`);
					 $("#joinDate").text(moment((moment().format())).fromNow());
					  $('#liveToast').toast('show');
	    		}
	   			
				
	 			//메세지 출력
	    		const showMsg = ({body}) => {
		    		const value = JSON.parse(body)
	    			const {msgNo, chatroomNo, writerNo, msg, regDate} = value;
					const username = $("#webchat_username").val();
	    			   			 
					let html = `<li class="list-group-item d-flex justify-content-between align-items-start">
								    <div class="ms-2 me-auto">
								      <div class="fw-bold">\${writerNo}</div>
								      \${msg}
								    </div>`;
								if(username == writerNo){    
									html += `<box-icon type='solid' name='edit'
										onclick="updateMsg(\${msgNo}, '\${msg}')"></box-icon>
										<box-icon name='x'  
									    onclick="deleteMsg(\${msgNo})"></box-icon>`;
								}
								
							html += `</li>`;
							
	    			$("#greetings").append(html);
	    			$("#cont").scrollTop($("#greetings")[0].scrollHeight);
	    		}

	    		

	    		//개인메세지 출력
	    		const showDm = ({body}) => {
		    		console.log(body)
	    			const value = JSON.parse(body);
	    			const {messageNo, messageContent, messageTime, messageSender, messageReceiver, readCheck} = value;
					
	    			const username = $("#webchat_username").val();
	    			
	    			const time = moment(moment()).format("Do hh:mm a");
	    			console.log(time)
	    			let html="";
	    			 if(username == messageSender){       
	                   html += `<div class="media media-chat media-chat-reverse">
			                            <div class="media-body reverse" id="dm\${messageNo}">
			                                <p>\${messageContent}</p>
				                            </div>
				                            <p class="meta-reverse">\${time}</p>
			                         </div>
			                         <div class="icon-dm">
				                         <box-icon type='solid' name='edit' 
				                                onclick="updateDm(\${messageNo}, '\${messageContent}')"></box-icon>
				                         <box-icon name='x' onclick="deleteDm(\${messageNo})"></box-icon>
				                     </div>`;
	                    	} else {
					
							html += `<div class="media media-chat"> 
			                            <div class="media-body">
			                                <p>\${messageContent}</p>
			                                <p class="meta">\${time}</p>
				                        </div>
				                     </div>`;
	                   }

	                   
						
	    			 $("#chat-content").append(html).scrollTop($("#chat-content")[0].scrollHeight);

					
	    		}

	    		
				//주소록리스트
				const showAddrList = () => {
					
					$.ajax({
						url : `${pageContext.request.contextPath}/address/addrList/1`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						success(data){
							console.log(data)
							const $Container = $("#addrList");
							let html = "";
							$(data).each((index, list) => {
								const {addrNo, savedEmp} = list
								 html += `<div class="list-group-item list-group-item-action py-3 lh-tight" onclick="addDm(\${savedEmp})"> 
								        <div class="d-flex w-80 align-items-center justify-content-between">
								          <strong class="mb-1">\${savedEmp}</strong>
								          <i id="dropdwonIcon" onclick="event.cancelBubble = true;" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
										  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
										    <li><a class="dropdown-item" onclick="event.cancelBubble = true; addrDelete(\${addrNo})">주소록 삭제</a></li>
										  </ul>
							          </div>
							        </div>`;
							})
						
							$Container.html(html);

						},
						error:console.log,
					})

				};
				
				//주소록에서 dm을 전달
				const addDm = (id) =>{
					$("#receive_username").val(id);
				}

				$("#dropdwonIcon", ".dropdown-item").click(e => {
					console.log(e);
					e.preventDefault();
				});

				//주소록 삭제
				const addrDelete = (addrNo) =>{
					//임시 사번
					const byEmp = 1;
					const address = {addrNo};
					console.log(address);
					$.ajax({
						url : `${pageContext.request.contextPath}/address/delete`,
						method: 'POST',
						contentType:"application/json; charset=utf-8",
						data : JSON.stringify(address),
						success(data){
							console.log(data);
							showAddrList();
						},
						error:console.log,
					})
					
				}


				const openChat = () => {
					if($("#chat-pop").css("display") == "none"){
					    $("#chat-pop").show();
					} else {
					    $("#chat-pop").hide();
					}
					
				}
				
				//대화창 수정, 삭제 아이콘 표시
				const showIcon = (msgNo) => {
					const $list = $(`#\${msgNo}`);
					const $icon = $(`#\${msgNo} .icon-container`);
					
					$list.hover(function(){
						$icon.show();
					})
					
					$list.mouseleave(function(){
						$icon.hide();
						
					})
				}
				
				//개인대화창 수정, 삭제 아이콘 표시
				const showDmIcon = (messageNo) => {
					
					const $list = $(`#dm\${messageNo}`);
					
					const $icon = $(`#dm\${messageNo} .icon-dm`);
					
					$list.hover(function(){
						$icon.show();
					})
					
					$list.mouseleave(function(){
						$icon.hide();
						
					})
				}
        	
			
			
    			$(function() {
        			
    				chatList();
    				
    			
					    			
					$("#dmSub").click(function(){
						dconnect();
					})
		    				    				
    				$("#disconnect").click(function() {
    					sendDisconnect();
    					
    				}); 
    				
    				$("#nameSend").click(function() {
    					sendUser();
    					showJoinList();
    					chatList();
    					
    					
    				});
    				$("#msgSend").click(function() {
    					sendMessage();
    				});

    				$("#dmSend").click(function(){
        				
    					sendDM();
    					//showDmList();
        			})
        		
        			
    			});

    			
    			
    			connect();
    			showUserList();
    			
    			showAddrList();
    			
    			
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />