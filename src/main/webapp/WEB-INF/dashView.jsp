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
	<link rel="stylesheet" type="text/css" href="/css/dash.css"/>
	<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
</head>
<style>
 #map {
   width: 800px;
   height: 500px;
   background-color: grey;
 }
</style>
<body>
	<!-- MAP -->
	<div id="map"></div>
	
	<!-- FORM TO SUBMIT A REPORT -->
	<form id="reportForm" action="/submitForm" method="POST" modelAttribute="report">
		<input name="lat" type="hidden" id="lat"/>
		<input name="lon" type="hidden" id="lon"/>
		<textarea id="content" name="content"></textarea>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="Submit"/>
	</form>
	
	<!-- LOGOUT -->
	<form id="logoutForm" method="POST" action="/logout">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input id="logoutButton" type="submit" value="Logout" />
	</form>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script src="/js/login.js"></script>
	<!-- MAP -->
	<script>
	// Note: This example requires that you consent to location sharing when
    // prompted by your` browser. If you see the error "The Geolocation service
    // failed.", it means you probably did not give permission for the browser to
    // locate you.
    var map, infoWindow, geocoder;
	
	// Initiates the map
    function initMap() {
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8
      });
      infoWindow = new google.maps.InfoWindow;
      geocoder = new google.maps.Geocoder;

      // Try HTML5 geolocation.
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          
          console.log("LAT=" + pos.lat);
          console.log("LON=" + pos.lng);

          infoWindow.setPosition(pos);
          infoWindow.setContent('You are here.');
          infoWindow.open(map);
          map.setCenter(pos);
        }, function() {
          handleLocationError(true, infoWindow, map.getCenter());
        });
      } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
      }
      
      // Creates a listener for any clicks on the map
      map.addListener('click', function(event) {
    	  	//Runs function to add a marker to the map
    	    placeMarkerAndPanTo(event.latLng, map);
       	var latLng = event.latLng.lat() + "," + event.latLng.lng();
    	    geocodeLatLng(latLng, map, infoWindow);
    	  	var lat = event.latLng.lat();
    	  	var lng = event.latLng.lng();
    	  	console.log("LAT=" + lat + " LONG=" + lng);
    	  });
    }
	
	// Function to notify geolocation failure
    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
      infoWindow.setPosition(pos);
      infoWindow.setContent(browserHasGeolocation ?
                            'Error: The Geolocation service failed.' :
                            'Error: Your browser doesn\'t support geolocation.');
      infoWindow.open(map);
    }
    
	// Instantiates a marker to be placed on the map
    var marker;
 	// Place and move marker on the map upon click
	 function placeMarkerAndPanTo(latLng, map) {
	   if (marker) {
	     marker.setPosition(latLng);
	   } else {
	     marker = new google.maps.Marker({
	       position: latLng,
	       map: map
	     });
	   }
	 };
	 
	 // Locates the address of area user is clicking
	 function geocodeLatLng(geocoder, map, infowindow) {
		 var x = new google.maps.Geocoder();
		  var latlngStr = geocoder.split(',', 2);
		  var latlng = {lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1])};
		  x.geocode({'location': latlng}, function(results, status) {
		    if (status === 'OK') {
		      if (results[0]) {
		        map.setZoom(map.zoom);
		        marker.setPosition(latlng);
		        console.log(results[0].formatted_address);
		        infowindow.setContent(results[0].formatted_address);
		        infowindow.open(map, marker);
		      } else {
		        window.alert('No results found');
		      }
		    } else {
		      window.alert('Geocoder failed due to: ' + status);
		    }
		  });
		}
	</script>
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyApmlEwj8rfIV3G51dsV5VTeO9tOOkBoX4&callback=initMap">
    </script>
</body>
</html>