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
    <link rel="stylesheet" type="text/css" href="/css/login.css"/>
<!-- JQuery -->
    <script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
    <script src="/js/login.js"></script>
</head>

<body>
<div class="popup">
	<div class="rectangle-speech-border">
		<div></div>
		<div class="dots"></div>
		<div class="text"><span>What's goin on?</span></div>
	</div>
</div>

    <!-- Start your project here-->
	    
	    <div id="loginForm">
	    <form method="POST" action="/login">
	    
	        <p class="h5 text-left mb-4">Sign in</p>
			
			<div class="container-fluid" id="messageContainer">
				<c:if test="${logoutMessage != null}">
					<div class="alert alert-success alert-dismissable">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong><c:out value="${logoutMessage}"></c:out></strong>
					</div>
			    </c:if>
			    <c:if test="${errorMessage != null}">
				    <div class="alert alert-danger alert-dismissable">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong><c:out value="${errorMessage}"></c:out></strong>
					</div>
			    </c:if>
			</div>
		    <div class="md-form">
		        <i class="fa fa-envelope prefix grey-text"></i>
		        <input type="text" id="email" name="username" class="form-control">
		        <label for="email">Your email</label>
		    </div>

		    <div class="md-form">
		        <i class="fa fa-lock prefix grey-text"></i>
		        <input type="password" id="password" name="password" class="form-control">
		        <label for="password">Your password</label>
		    </div>
		    
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

		    <div class="text-center">
		        <input type="submit" id="button" value="Login"/>
		    </div>
	        
	    </form>
	    
	    <p>Not a member? <a href="/register">Sign Up!</a></p>
		</div>
<div class="popup2">
	<div class="rectangle-speech-border2">
		<div></div>
		<div class="dots2"></div>
		<div class="text2"><span>Twap It!</span></div>
	</div>
</div>

    <!-- /Start your project here-->

    <!-- SCRIPTS -->
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="/js/mdb.min.js"></script>
    
</body>
</html>