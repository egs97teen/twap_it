<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Twap It | Admin</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/admin.css"/>
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
			<a class="nav-item nav-link" href="#">Messages</a>
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
						<img class="profPic" src="/img/cat_profile-512.png">
					</c:when>
					<c:otherwise>
						<img class="profPic" src="${currentUser.imgUrl}" style="border-radius:50%">
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
		<div class="inv">
			<img class="user_pic" src="${invite.imgUrl}">
			<div class="text">
				<p class="user_name">${invite.name}</p>
				<a class="g" href="/accept/${invite.id}">Accept</a> • <a class="r" href="/reject/${invite.id}">Reject</a>
			</div>
		</div>
	</c:forEach>
</div>

<!-- header -->
<div id="viewButtons">
	<button id="twaps_button">Twaps</button>
	<button id="users_button">Users</button>
</div>

<!-- Twap List -->
<div id="twap_list">
	<h3>Twaps</h3>
	<input type="text" id="twaps_search" class="form-control" onkeyup="twapsSearch()" placeholder="Search Twaps" />
	
	<hr>
		
	<div class="container-fluid" style="width:80vw;margin:auto;">
		<div class="table-responsive">
			<table class="table table-hover table-bordered" id="twaps_table">
				<thead>
					<tr>
						<th class="w-45">Twap</th>
						<th class="w-25">Twapped By</th>
						<th class="w-5">Actions</th>
					</tr>
				</thead>
				<tbody id="twaps_table_body">
					<c:forEach items="${twaps}" var="twap">
						<tr>
							<td class="w-45">${twap.content}</td>
							<td class="w-25">${twap.user.name}</td>
							<td class="w-5"><a class="r" href="/delete/${twap.id}"><img class="icon" src="/img/trash-512.png">delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- User List -->
<div id="users_display">
	<h3>Users</h3>
	<input type="text" id="users_search" class="form-control" onkeyup="usersSearch()" placeholder="Search Users" />

	<hr>
	
	<div class="container-fluid" style="width:80vw;margin:auto">

		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover"  id="users_table">
				<thead>
					<tr>
						<th>Name</th>
						<th>Email</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody id="users_table_body">
					<c:forEach items="${allUsers}" var="user" >
						<c:if test="${user != currentUser}">
							<c:if test="${user.level == 'admin'}">
							<tr>
								<td><a href="/user/${user.id}">${user.name}</a></td>
								<td>${user.email}</td>
								<td>Already Admin</a> | <a href="/admin/delete/${user.id}"><i class="fa fa-user-times prefix grey-text"></i>Delete User</a></td>
							</tr>
							</c:if>			
							<c:if test="${user.level != 'admin'}">
							<tr>
								<td><a href="/user/${user.id}">${user.name}</a></td>
								<td>${user.email}</td>
								<td><a href="/admin/promote/${user.id}"><i class="fa fa-user-plus prefix grey-text"></i>Make Admin</a> | <a class="r" href="/admin/delete/${user.id}"><i class="fa fa-user-times prefix grey-text"></i>Delete User</a></td>
							</tr>
							</c:if>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
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
<script src="/js/admin.js"></script>
<script>
$('#logoutLink').on('click', function(e) {
	e.preventDefault();
	$('#logoutForm').submit();
})
</script>
</body>
</html>