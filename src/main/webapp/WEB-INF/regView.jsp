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
	<link rel="stylesheet" type="text/css" href="/css/reg.css"/>
	<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
</head>

<body>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-4">

			<div class="popup">
				<div class="rectangle-speech-border">
					<div></div>
					<div class="dots"></div>
					<div class="text"><span>What's goin on?</span></div>
				</div>
			</div>

		</div>
		<div class="col-md-4">

		    <div id="regForm">
			
			<h2 style="text-align: center;">Register</h2>
			
		    <form:form method="POST" action="/registration" modelAttribute="userObject">
		    <div id="imageBox"></div>
		
		    <div class="form-group">
		    		<i class="fa fa-camera-retro prefix grey-text"></i>
		    		<form:label path="imgUrl">Image: </form:label>
				<form:input id="imageUrl" path="imgUrl" class="form-control form-control-sm"/>
		    </div>
		    
		    <div class="form-group">
		        <i class="fa fa-user prefix grey-text"></i>
		        <form:label path="name">Name: </form:label>
		        <form:input type="text" id="name" path="name" class="form-control form-control-sm"/>
		    </div>
		    <span><form:errors path="name"/></span>
		    
		    <div class="form-group">
		        <i class="fa fa-envelope prefix grey-text"></i>
		        <form:label path="email">Email: </form:label>
		        <form:input type="text" id="email" path="email" class="form-control form-control-sm"/>
		    </div>
		    <span><form:errors path="email"/></span>
		    
		    <div class="form-group">
		    		<i class="fa fa-lock prefix grey-text"></i>
		    		<form:label path="password">Password:</form:label>
		    		<form:password path="password" class="form-control form-control-sm"/>
		    </div>
		    <span><form:errors path="password"/></span>
		    
		    <div class="form-group">
		    		<i class="fa fa-eye prefix grey-text"></i>
		    		<form:label path="passwordConfirmation">Confirm Password: </form:label>
		    		<form:password path="passwordConfirmation" class="form-control form-control-sm"/>
		    </div>
		    <span><form:errors path="passwordConfirmation"/></span>
		
		        <div class="text-center">
				        <input type="submit" id="button" value="Register"/>
				</div>
		    </form:form>
		    
		    <p>Already a member? <a href="/login">Sign In.</a></p>
		    </div>


		</div>
		<div class="col-md-4">

			<div class="popup2">
				<div class="rectangle-speech-border2">
					<div></div>
					<div class="dots2"></div>
					<div class="text2"><span>Twap It!</span></div>
				</div>
			</div>

		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script src="/js/reg.js"></script>
</body>
</html>