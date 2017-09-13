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
	<link rel="stylesheet" type="text/css" href="/css/dash.css"/>
	<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
</head>
<style>

	 #map-container {
	   width: 100%;
	   height: 75vh;
	  }

	 #map {
	   width: 100%;
	   height: 75vh;
	   background-color: grey;
	 }
	 
	 #loading {
		width: 100%;
		height: 75vh;
	 	background: transparent url(img/loadguy.gif) no-repeat center center;
	 	background-size: cover;
	 }
	 
	 
	 #infowindow-content .title {
	   font-weight: bold;
	 }
	 
	 #infowindow-content {
	   display: none;
	 }
	 
	 #map #infowindow-content {
       display: inline;
     }

	.pac-card {
		margin: 10px 10px 0 0;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        background-color: #fff;
        font-family: Roboto;
	}
	
	input {
		display: none;
	}

	#pac-container {
        padding-bottom: 12px;
        margin-right: 12px;
	}

	.pac-controls {
        display: inline-block;
        padding: 5px 11px;
	}

	.pac-controls label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
	}

	#pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        margin-top: 10px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 400px;
	}

	#pac-input:focus {
        border-color: #4d90fe;
	}

	#title {
        color: #fff;
        background-color: #4d90fe;
        font-size: 25px;
        font-weight: 500;
        padding: 6px 12px;
	}
	
	#target {
        width: 345px;
	}
	
	#logoutForm {
		display: none;
	}
</style>
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
			<a class="nav-item nav-link active" href="/dashboard">Home <span class="sr-only">(current)</span></a>
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

<div class="container-fluid container">
	<div class="row">
		<div class="col-md-8">
			<div id="twapIt">
				<span>What's goin on?</span>
				<!-- MODAL BUTTON --> <button id="twapButton" data-toggle="modal" data-target="#formModal">TWAP IT!</button>
				<p id="note">Note: You can also choose another location to Twap!</p>
			</div>
			
			<!-- MAP -->
			<div id="map-container">
				<div id="loading"></div>
				<div id="map"></div>
			</div>
			<input id="pac-input" placeholder="Search location..."></input>
		</div>
		<div class="col-md-4">

			<!-- TWAP FEED -->
			<div id="twapFeed">
			</div>
			<a href="/dashboard" id="resetFeed">RESET</a>
		</div>
	</div>
</div>

<!-- LOGOUT -->
	<form id="logoutForm" method="POST" action="/logout">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="" />
	</form>

	
	<!-- ---------- MODAL 1 ---------- -->
	<div class="modal fade" id="formModal" tabindex="s-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			    <div class="modal-header">
			    		<h5 class="modal-title" id="formModalLabel">Twap-It</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
			    </div>
				<div class="modal-body">
					<form id="modalForm" action="/dashboard" method="POST" modelAttribute="twap">
						<textarea id="content" name="content" class="form-control" maxlength="200" rows="3" placeholder="What do you want to Twap™?"></textarea>
						<input name="lat" type="hidden" id="lat" />
						<input name="lon" type="hidden" id="lon" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="button" onclick="submitForm()" class="btn btn-success">Twap-It!</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ---------- MODAL 2 ---------- -->
	<div class="modal fade" id="radioModal" tabindex="s-1" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			    <div class="modal-header">
			    		<h5 class="modal-title" id="formModalLabel">Twap-It</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>
			    </div>
				<div class="modal-body">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-outline-secondary active">
							<input type="radio" name="options" id="option1" value="geo" checked>My Location
						</label>
						<label class="btn btn-outline-success">
							<input type="radio" name="options" id="option2" value="marker">Marked Location
						</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="button" onclick="submitRadio()" class="btn btn-success">Twap-It!</button>
				</div>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<!-- 	<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script> -->
	
<script>

<!-- PARSE TWAP CONTENT FOR HASHTAGS AND CREATE LINKS -->

var content = "";

<c:forEach var="twap" items="${twaps}">
	var twapContent = "${twap.content}";
	twapContent = twapContent.replace(/(^|\s)(#[a-z\d-]+)/ig, "$1<a href='' class='hash_tag'>$2</a>");
	<c:choose>
	<c:when test="${twap.user.imgUrl.equals('')}">
		var imgUrl = '/img/cat_profile-512.png'
	</c:when>
	<c:otherwise>
		var imgUrl = "${twap.user.imgUrl}"
	</c:otherwise>
	</c:choose>
	<c:choose>
	<c:when test="${twap.user.id == currentUser.id}">
		content += "<div class='twap'> <img class='user_pic' src=" + imgUrl + "> <div class='twapStuff'> <a class='user_name' href='/user/${twap.user.id}'>${twap.user.name}</a> <p class='time'><fmt:formatDate type='date' dateStyle='short' value='${twap.createdAt}'/></p> <p class='twapText'>" + twapContent + "</p> <a class='twapDel' href='/delete/${twap.id}'>delete</a> </div></div>"
	</c:when>
	<c:otherwise>
		content += "<div class='twap'> <img class='user_pic' src=" + imgUrl + "> <div class='twapStuff'> <a class='user_name' href='/user/${twap.user.id}'>${twap.user.name}</a> <p class='time'><fmt:formatDate type='date' dateStyle='short' value='${twap.createdAt}'/></p> <p class='twapText'>" + twapContent + "</p> </div></div>"
	</c:otherwise>
	</c:choose>

</c:forEach>

$('#twapFeed').html(content);

$('#resetFeed').hide();

<!-- WHEN CLICKING ON HASHTAGS -->
$('.hash_tag').click(function(event) {
	event.preventDefault();

	var feed, twaps, twapText;
	feed = document.getElementById("twapFeed");
	twaps = feed.getElementsByClassName("twap");

		for(var i = 0; i < twaps.length; i++){
			twapText = twaps[i].getElementsByClassName("twapText")[0].innerText.replace(/[^\w#]/g, " ").toUpperCase().split(" ");
			
 			if (twapText.includes($(this)[0].innerText.toUpperCase())) {
				twaps[i].style.display="";
			} else {
				twaps[i].style.display="none";
			} 
		}
	
	$('#resetFeed').show();
})


<!-- WHEN CLICKING ON NOTIFICATIONS -->
$('#invites').hide();
$(document).ready(function() {
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

	<!-- MAP -->
	<script>
	// Note: This example requires that you consent to location sharing when
    // prompted by your` browser. If you see the error "The Geolocation service
    // failed.", it means you probably did not give permission for the browser to
    // locate you.
    var map, infoWindow, geocoder;
	var lastOpenedWindow;
	
	// Initiates the map
	function initMap() {
	
	// Create a map style
    var styledMapType = new google.maps.StyledMapType(
            [
              {elementType: 'geometry', stylers: [{color: '#ebe3cd'}]},
              {elementType: 'labels.text.fill', stylers: [{color: '#523735'}]},
              {elementType: 'labels.text.stroke', stylers: [{color: '#f5f1e6'}]},
              {
                featureType: 'administrative',
                elementType: 'geometry.stroke',
                stylers: [{color: '#c9b2a6'}]
              },
              {
                featureType: 'administrative.land_parcel',
                elementType: 'geometry.stroke',
                stylers: [{color: '#dcd2be'}]
              },
              {
                featureType: 'administrative.land_parcel',
                elementType: 'labels.text.fill',
                stylers: [{color: '#ae9e90'}]
              },
              {
                featureType: 'landscape.natural',
                elementType: 'geometry',
                stylers: [{color: '#dfd2ae'}]
              },
              {
                featureType: 'poi',
                elementType: 'geometry',
                stylers: [{color: '#dfd2ae'}]
              },
              {
                featureType: 'poi',
                elementType: 'labels.text.fill',
                stylers: [{color: '#93817c'}]
              },
              {
                featureType: 'poi.park',
                elementType: 'geometry.fill',
                stylers: [{color: '#a5b076'}]
              },
              {
                featureType: 'poi.park',
                elementType: 'labels.text.fill',
                stylers: [{color: '#447530'}]
              },
              {
                featureType: 'road',
                elementType: 'geometry',
                stylers: [{color: '#f5f1e6'}]
              },
              {
                featureType: 'road.arterial',
                elementType: 'geometry',
                stylers: [{color: '#fdfcf8'}]
              },
              {
                featureType: 'road.highway',
                elementType: 'geometry',
                stylers: [{color: '#f8c967'}]
              },
              {
                featureType: 'road.highway',
                elementType: 'geometry.stroke',
                stylers: [{color: '#e9bc62'}]
              },
              {
                featureType: 'road.highway.controlled_access',
                elementType: 'geometry',
                stylers: [{color: '#e98d58'}]
              },
              {
                featureType: 'road.highway.controlled_access',
                elementType: 'geometry.stroke',
                stylers: [{color: '#db8555'}]
              },
              {
                featureType: 'road.local',
                elementType: 'labels.text.fill',
                stylers: [{color: '#806b63'}]
              },
              {
                featureType: 'transit.line',
                elementType: 'geometry',
                stylers: [{color: '#dfd2ae'}]
              },
              {
                featureType: 'transit.line',
                elementType: 'labels.text.fill',
                stylers: [{color: '#8f7d77'}]
              },
              {
                featureType: 'transit.line',
                elementType: 'labels.text.stroke',
                stylers: [{color: '#ebe3cd'}]
              },
              {
                featureType: 'transit.station',
                elementType: 'geometry',
                stylers: [{color: '#dfd2ae'}]
              },
              {
                featureType: 'water',
                elementType: 'geometry.fill',
                stylers: [{color: '#b9d3c2'}]
              },
              {
                featureType: 'water',
                elementType: 'labels.text.fill',
                stylers: [{color: '#92998d'}]
              },
              {
                  featureType: "administrative.country",
                  elementType: "geometry.stroke",
                  stylers: [{color: '#800000'}]
               }
            ],
            {name: 'Map'});

	  map = new google.maps.Map(document.getElementById('map'), {
			zoom: 10,
			draggableCursor:'crosshair',
			draggingCursor:'move',
			mapTypeControlOptions: {
				mapTypeIds: ['satellite','styled_map']
			}
		});
	  // Tells API to display map with custom style
	  map.mapTypes.set('styled_map', styledMapType);
	  map.setMapTypeId('styled_map');
      infoWindow = new google.maps.InfoWindow;
      geocoder = new google.maps.Geocoder;
	
      $('#map').css('opacity','0');
      // Try HTML5 geolocation.
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
        	// stop the gif here and load the page normally
        	$('input').show();
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          
          document.getElementById("lat").value = pos.lat;
          document.getElementById("lon").value = pos.lng;

          infoWindow.setPosition(pos);
          infoWindow.setContent('You are here.');
          infoWindow.open(map);
          lastOpenedWindow = infoWindow;
          map.setCenter(pos);
          $('#loading').hide();
          $('#map').css('opacity', '1');
        }, function() {
          	handleLocationError(true, infoWindow, map.getCenter());
        });
      } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, infoWindow, map.getCenter());
      }
      
      // Creates a listener for any clicks on the map
      map.addListener('click', function(event) {
    	  console.log(map);
    	  	//Runs function to add a marker to the map
    	    placeMarkerAndPanTo(event.latLng, map);
       	var latLng = event.latLng.lat() + "," + event.latLng.lng();
    	    geocodeLatLng(latLng, map, infoWindow);
    	  	var lat = event.latLng.lat();
    	  	var lng = event.latLng.lng();
    	  	if (lastOpenedWindow) {
    	  		lastOpenedWindow.close();
    	  	}
    	  });
      
   // Create the search box and link it to the UI element.
      var input = document.getElementById('pac-input');
      var searchBox = new google.maps.places.SearchBox(input);
      map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

      // Bias the SearchBox results towards current map's viewport.
      map.addListener('bounds_changed', function() {
        searchBox.setBounds(map.getBounds());
      });

      var markers = [];
      // Listen for the event fired when the user selects a prediction and retrieve
      // more details for that place.
      searchBox.addListener('places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
          return;
        }

        // Clear out the old markers.
        markers.forEach(function(marker) {
          marker.setMap(null);
        });
        markers = [];

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function(place) {
          if (!place.geometry) {
            console.log("Returned place contains no geometry");
            return;
          }
          var icon = {
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(25, 25)
          };

          // Create a marker for each place after relocating the map.
          markers.push(new google.maps.Marker({
            map: map,
            icon: icon,
            title: place.name,
            position: place.geometry.location,
            clickable: true
          }));

          if (place.geometry.viewport) {
            // Only geocodes have viewport.
            bounds.union(place.geometry.viewport);
          } else {
            bounds.extend(place.geometry.location);
          }
        });
        map.fitBounds(bounds);
      }); 
      
      // Create an array of alphabetical characters used to label the markers.
      var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      
      var locations = [];
  	
  	  <c:forEach items="${ twaps }" var="location">
  		var latLng = new google.maps.LatLng(${ location.lat }, ${ location.lon });
  		locations.push(latLng);
  	  </c:forEach>
   	  
   	  // Add some twap markers to the map.
      // Note: The code uses the JavaScript Array.prototype.map() method to
      // create an array of twap markers based on a given "locations" array.
      // The map() method here has nothing to do with the Google Maps API.

      twaps = locations.map(function(location, i) {
    	  	var newMarker = new google.maps.Marker({
          position: location,
          label: labels[i % labels.length],
          clickable: true,
          animation: google.maps.Animation.DROP
        });

    	  	newMarker.addListener('click', function(location) {
    	  		var markerLat = location.latLng.lat();
    	  		var markerLng = location.latLng.lng();
    	  		$.get("/searchMarker", {lat: markerLat, lng: markerLng}, function(response) {
    	  			var geocoder = new google.maps.Geocoder();
    	  			var latlng = {lat: markerLat, lng: markerLng};
    	  		  	
    	  		  	geocoder.geocode({'location': latlng}, function(results, status) {
    	  		    		if (status === 'OK') {
    	  		      		if (results[0]) {
    	  		  				address = results[0].formatted_address;
    	  		  				
    	  		  				var twapContent = response[0][3];
    	  		  				twapContent = twapContent.replace(/(^|\s)(#[a-z\d-]+)/ig, "$1<a href='' class='hash_tag'>$2</a>");
    	  		  				
    	  		  				var utcSeconds = response[0][0];
    	  		  				var date = new Date(utcSeconds);
    	  		  				
    	  		  				var infoContent = '<img class="user_pic" src="'+response[0][4]+'"><div id="twapInfo"><a href="/user/' + response[0][1] + '">' + response[0][2] + '</a><br>' + twapContent + '<br>' + date + '<br>'+ address + '</div>';
    	  		  				
    	  		  				var newWindow = new google.maps.InfoWindow({
    	    	  						content: infoContent
    	    	  					});
    	    	  			
		    	    	  			if (lastOpenedWindow) {
		    	    	  				lastOpenedWindow.close();
		    	    	  			}
    	    	  			
    	    	  					newWindow.open(map, newMarker);
    	    	  					lastOpenedWindow = newWindow;
    	  		      		}
    	  		    		}
    	  		  	});
    	  		  	
    	  		}, "json")
    	  	})
    	  	return newMarker;
      });

      // Add a twap marker clusterer to manage the markers.
      var markerCluster = new MarkerClusterer(map, twaps,
          {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      
   		  $(document).on("click", ".hash_tag", function(event) {
	  	  	event.preventDefault();
	  	  	twaps.forEach(function(marker) {
	  	  		marker.setMap(null);
	  	  	})
	  	  	
	  	  	markerCluster.clearMarkers();
	  	  	newLocations = [];
	  	  	
	  	  	<c:forEach items="${ twaps }" var="twap">
	  	  		var twapContent = "${twap.content}";
	  	  		twapContent = twapContent.toUpperCase();
	  	  		
	  	  		if (twapContent.includes($(this)[0].innerText.toUpperCase())) {
  					var latLng = new google.maps.LatLng("${ twap.lat }", "${ twap.lon }");
  					newLocations.push(latLng);
  	  			}
	  	  	</c:forEach>
	  	  	
	  	  twaps = newLocations.map(function(location, i) {
	    	  	var newMarker = new google.maps.Marker({
	          position: location,
	          label: labels[i % labels.length],
	          clickable: true,
	          animation: google.maps.Animation.DROP,
	          map: map
	        });

	    	  	newMarker.addListener('click', function(location) {
	    	  		var markerLat = location.latLng.lat();
	    	  		var markerLng = location.latLng.lng();
	    	  		$.get("/searchMarker", {lat: markerLat, lng: markerLng}, function(response) {
	    	  			var geocoder = new google.maps.Geocoder();
	    	  			var latlng = {lat: markerLat, lng: markerLng};
	    	  		  	
	    	  		  	geocoder.geocode({'location': latlng}, function(results, status) {
	    	  		    		if (status === 'OK') {
	    	  		      		if (results[0]) {
	    	  		  				address = results[0].formatted_address;
	    	  		  				
		    	  		  			var twapContent = response[0][3];
	    	  		  				console.log(twapContent);
	    	  		  				twapContent = twapContent.replace(/(^|\s)(#[a-z\d-]+)/ig, "$1<a href='' class='hash_tag'>$2</a>");
	    	  		  				
	    	  		  				var infoContent = '<img class="user_pic" src="'+response[0][4]+'"><div id="twapInfo"><a href="/user/' + response[0][1] + '">' + response[0][2] + '</a><br>' + twapContent + '<br>' + address + '</div>';
	    	  		  				
	    	  		  				var newWindow = new google.maps.InfoWindow({
	    	    	  						content: infoContent
	    	    	  					});
	    	    	  			
			    	    	  			if (lastOpenedWindow) {
			    	    	  				lastOpenedWindow.close();
			    	    	  			}
	    	    	  			
	    	    	  					newWindow.open(map, newMarker);
	    	    	  					lastOpenedWindow = newWindow;
	    	  		      		}
	    	  		    		}
	    	  		  	});
	    	  		  	
	    	  		}, "json")
	    	  	})
	    	  	return newMarker;
	      });
	  		markerCluster = new MarkerClusterer(map, twaps,
	            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
  		})
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
	 
	 function submitForm() {
		if ($('#content')[0].value == '') {
			return false;
		}
		if (marker != undefined) {
			$('#formModal').modal('hide');
			$('#radioModal').modal('show');
		} else {
			$('#modalForm').submit();
		}
	}

	 function submitRadio() {
		if (!$('#option1')[0].checked) {
			document.getElementById("lat").value = marker.getPosition().lat();
			document.getElementById("lon").value = marker.getPosition().lng();
		}
		$('#modalForm').submit();
	 }

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
		        infowindow.setContent(results[0].formatted_address);
		        infowindow.open(map, marker);
		        lastOpenedWindow = infoWindow;
		      } else {
		        window.alert('No results found');
		      }
		    } else {
		      window.alert('Geocoder failed due to: ' + status);
		    }
		  });
		}
	</script>
	<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAFthhs_n2Gt51e-a1WWNZfspjTiSQY-aI&libraries=places&callback=initMap">
    </script>
</body>
</html>