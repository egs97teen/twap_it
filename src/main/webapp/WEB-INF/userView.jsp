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
			<a class="nav-item nav-link" href="#">Notifications <span class="badge badge-secondary">#</span></a>
			<a class="nav-item nav-link" href="#">Messages <span class="badge badge-secondary">#</span></a>
		</div>
	</div>
	
	<div class="collapse navbar-collapse">
	<form class="form-inline">
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">@</span>
			<input type="text" class="form-control" placeholder="Search users..." aria-label="name" aria-describedby="basic-addon1">
		</div>
	</form>
	
	<ul class="navbar-nav ml-auto nav-flex icons">
		<li class="nav-item avatar dropdown">
			<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<c:choose>
					<c:when test="${currentUser.imgUrl.equals('')}">
						<img id="profPic" src="/images/cat_profile-512.png">
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
					<img alt="" src="${currentUser.imgUrl}">
				</div>
				<div class="info">
					<div class="title">${currentUser.name}</div>
					<p>${currentUser.email}</p>
				</div>
			</div>
			<div class="userFeed">
				<h2>Twaps</h2>
			</div>
			<div id="friends">
				<h2>Friends</h2>
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
<script src="/js/user.js"></script>
<script>
$('#logoutLink').on('click', function(e) {
	e.preventDefault();
	$('#logoutForm').submit();
})
</script>
</body>
</html>