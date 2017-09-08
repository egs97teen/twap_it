<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Twap It</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/user.css"/>
	<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
</head>
<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-sm navbar-light" style="background-color: #F1F5F4;">
	<span class="navbar-brand mb-0 navbar-text">
		<img src="/img/logo.png"width="20" height="20" alt=""> Twap It
	</span>

	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	<span class="navbar-toggler-icon"></span>
	</button>
	
	<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
		<div class="navbar-nav">
			<a class="nav-item nav-link" href="/dashboard">Home</a>
			<a id="notifications" class="nav-item nav-link notif" href="#">Notifications 
					<c:if test="${invitations != null}">
					<span class="badge badge-secondary">${invitations.size()}</span>
					</c:if>
			</a>
			<a class="nav-item nav-link" href="#">Messages <span class="badge badge-secondary">#</span></a>
		</div>
	</div>
	
	
	<div class="collapse navbar-collapse">
	
	<ul class="navbar-nav ml-auto nav-flex icons">
	
	<!-- SEARCH USERS -->
	<form class="form-inline">
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1"><i class="fa fa-user"></i></span>
			<input type="text" id="searchUsers" class="form-control" placeholder="Search users" aria-label="tag" aria-describedby="basic-addon1">
		</div>
	</form>
	
	<!-- PROFILE PIC DROPDOWN -->
		<li class="nav-item avatar dropdown">
			<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<c:choose>
					<c:when test="${currentUser.imgUrl.equals('')}">
						<img id="profPic" src="/img/cat_profile-512.png">
					</c:when>
					<c:otherwise>
						<img id="profPic" src="${currentUser.imgUrl}" style="border-radius:50%">
					</c:otherwise>
				</c:choose>
			</a>
			<div class="dropdown-menu dropdown-menu-right dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
				<a class="dropdown-item waves-effect waves-light" href="/user/${currentUser.id}">My Profile</a>
				<c:if test="${currentUser.level == 'admin'}">
					<a class="dropdown-item waves-effect waves-light" href="/admin">Admin Dashboard</a>
				</c:if>
				<a class="dropdown-item waves-effect waves-light" id="logoutLink">Logout</a>
			</div>
		</li>
	</ul>
</div>
</nav>
<!-- SEARCH RESULTS DIV -->
<div id="results"></div>

<!--  IF SELF, SHOW INVITATIONS UNDER NOTIFICATIONS BAR -->
<div id="invites">
	<c:forEach var="invite" items="${invitations}">
		<p><strong>Invitation from</strong> ${invite.name} • <a class="g" href="/accept/${invite.id}">Accept</a> • <a class="r" href="/reject/${invite.id}">Reject</a></p>
	</c:forEach>
</div>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-10">
			<!-- USER INFO -->
			<div class="card hovercard">
				<div class="cardheader">
				</div>
				<div class="avatar">
					<img alt="" src="${user.imgUrl}">
				</div>
				<div class="info">
					<div class="title">${user.name}</div>
					<p>${user.email}</p>
				</div>
			</div>
			<!-- NOT SELF&NOT FRIENDS YET, SHOW THIS BUTTON -->
			<c:if test="${!self}">
				<div id="friendStatus">
					<c:choose>
						<c:when test="${friendship == 'none'}">
							<a href="/invite/${user.id}">Add Friend</a>
						</c:when>
						<c:when test="${friendship == 'invited'}">
							<span>Pending Invite</span>
						</c:when>
					</c:choose>
				</div>
			</c:if>
			
			<!-- TWAP FEED -->
			<div class="userFeed">
				<h2>Twaps</h2>
				<c:forEach var="twap" items="${user.twaps}">
					<p id="time"><fmt:formatDate type="both" dateStyle="short" timeStyle="short" value="${twap.createdAt}" /></p>
					<p>${twap.content}</p>
					<c:if test="${self}">
						<a href="/delete/${twap.id}">delete</a>
					</c:if>
				</c:forEach>
			</div>
			<!-- FRIENDS LIST -->
			<div id="friends">
				<h2>Friends</h2>
				<c:if test="${!self}">
					<c:if test="${friendship == 'friends'}">
						<p>Yay! We're Friends!</p>
					</c:if>
				</c:if>
				<c:if test="${!friends_list.equals(null)}">
					<ul>
						<c:forEach var="friend" items="${friends_list}">
							<li><a href="/user/${friend.id}">${friend.name}</a></li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>
		<div class="col-md-1">
		</div>
	</div>
</div>

	<!-- LOGOUT -->
	<form id="logoutForm" method="POST" action="/logout">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="" />
	</form>
	
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script>
<!-- WHEN CLICKING ON NOTIFICATIONS -->
$(document).ready(function() {
	$('#invites').hide();
	$(this).click(function(e) {
		if($(e.target).hasClass('notif')) {
			$('#invites').show();
		} else {
			$('#invites').hide();	
		}
	})
})

<!-- LOGOUT FUNCTIONALITY -->
$('#logoutLink').on('click', function(e) {
	e.preventDefault();
	$('#logoutForm').submit();
})

<!-- SEARCH USERS FUNCTIONALITY -->
$('#searchUsers').on('input', function() {
	var searchQuery = $(this).val();
	$.get('/search', {query: searchQuery}, function(response) {
		var results = "";
		if(searchQuery == "") {
			results = "";
		} else if(response.length > 8) {
			for(var i = 0; i < 8; i++) {
				results += "<a href='/user/"+response[i][0]+"'><div class='search_result'><img class='user_pic' src='"+response[i][1]+"'><div class='user_info'><p class='user_name'>"+response[i][2]+"</p><p class='user_email'>"+response[i][3]+"</p></div></div></a>";
			}
		} else {
			for(var i = 0; i < response.length; i++) {
				results += "<a href='/user/"+response[i][0]+"'><div class='search_result'><img class='user_pic' src='"+response[i][1]+"'><div class='user_info'><p class='user_name'>"+response[i][2]+"</p><p class='user_email'>"+response[i][3]+"</p></div></div></a>";
			}
		}
		if(response) {
			$('#results').show().html('<div id="results">'+results+'</div>')
			$(document).click(function(e) {
				if($(e.target).hasClass('form-control')) {
					$('#results').show();
				} else {
					$('#results').hide();
				}
			})
		}
	}, 'json')
})
</script>
</body>
</html>