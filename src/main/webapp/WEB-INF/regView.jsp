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
    <title>Java Project</title>
<!--  CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/mdb.min.css">
    <link rel="stylesheet" type="text/css" href="/css/reg.css"/>
<!-- JQuery -->
    <script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
    <script src="/js/reg.js"></script>
</head>
<body>
<div class="popup">
	<div class="rectangle-speech-border">
		<div></div>
		<div class="dots"></div>
		<div class="text"><span>What's goin on?</span></div>
	</div>
</div>

    <div id="regForm">

    <form:form method="POST" action="/registration" modelAttribute="userObject">
    <div id="imageBox"></div>
    <p class="h5 text-left mb-4">Register</p>

    <div class="md-form">
    		<i class="fa fa-camera-retro prefix grey-text"></i>
		<form:input id="imageUrl" path="imgUrl" class="form-control"/>
		<form:label path="imgUrl">Image: </form:label>
    </div>
    <div class="md-form">
        <i class="fa fa-user prefix grey-text"></i>
        <form:input type="text" id="name" path="name" class="form-control"/>
        <form:label path="name">Name:</form:label>
    </div>
    <span><form:errors path="name"/></span>
    <div class="md-form">
        <i class="fa fa-envelope prefix grey-text"></i>
        <form:input type="text" id="email" path="email" class="form-control"/>
        <form:label path="email">Email:</form:label>
    </div>
    <span><form:errors path="email"/></span>
    <div class="md-form">
    		<i class="fa fa-lock prefix grey-text"></i>
    		<form:password path="password" class="form-control"/>
    		<form:label path="password">Password:</form:label>
    </div>
    <span><form:errors path="password"/></span>
    <div class="md-form">
    		<i class="fa fa-eye prefix grey-text"></i>
    		<form:password path="passwordConfirmation" class="form-control"/>
    		<form:label path="passwordConfirmation">Confirm Password:</form:label>
    </div>
    <span><form:errors path="passwordConfirmation"/></span>

        <div class="text-center">
		        <input type="submit" class="btn btn-amber" value="Register"/>
		</div>
    </form:form>
    
    <p>Already a member? <a href="/login">Sign In.</a></p>
    </div>
<div class="popup2">
	<div class="rectangle-speech-border2">
		<div></div>
		<div class="dots2"></div>
		<div class="text2"><span>Twap It!</span></div>
	</div>
</div>

    <!-- SCRIPTS -->
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="/js/mdb.min.js"></script>

  
</body>
</html>