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

$(document).ready(function(){
//	
//	$("#search_bar").on('input', function() {
//		var input = $(this).val();
//		$.get("/searchUser", {query: input}, function(response) {
//			var results = "";
//			if (input == "") {
//				results = "";
//			} else if (response.length > 5) {
//				for (var i = 0; i < 5; i++) {
//					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
//				}
//			} else {
//				for (var i = 0; i < response.length; i++) {
//					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
//				}
//			}
//			if (response) {
//				$("#results").show().html("<div id='results'>"+results+"</div>")
//			}
//
//		}, "json")
//	})
//
//	$(this).click(function() {
//		$("#results").hide();
//	})
//
//	$("#search_bar").click(function() {
//		$("#results").show();
//		var input = $(this).val();
//		$.get("/searchUser", {query: input}, function(response) {
//			var results = "";
//			if (input == "") {
//				results = "";
//			} else if (response.length > 5) {
//				for (var i = 0; i < 5; i++) {
//					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
//				}
//			} else {
//				for (var i = 0; i < response.length; i++) {
//					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
//				}
//			}
//			if (response) {
//				$("#results").show().html("<div id='results'>"+results+"</div>")
//			}
//
//		}, "json")
//	})
//
//	$(document).on({
//		mouseenter: function() {
//			$(this).css('background-color', '#cccccc')
//		},
//		mouseleave: function() {
//			$(this).css('background-color', '')
//		}
//	}, '.search_result')
//
//	$(document).mouseup(function(e)
//	{
//    var container = $("#friends_results");
//
//    // if the target of the click isn't the container nor a descendant of the container
//    if (!container.is(e.target) && container.has(e.target).length === 0)
//    {
//        container.hide();
//    }
//	});
//
//	$(document).on({
//		mouseenter: function() {
//			$(this).css('background-color', '#cccccc')
//		},
//		mouseleave: function() {
//			$(this).css('background-color', '')
//		}
//	}, '.invite')
//
//	$(document).on({
//		mouseenter: function() {
//			$(this).css('background-color', 'green')
//		},
//		mouseleave: function() {
//			$(this).css('background-color', '')
//		}
//	}, '.invite_accept')
//
//	$(document).on({
//		mouseenter: function() {
//			$(this).css('background-color', 'red')
//		},
//		mouseleave: function() {
//			$(this).css('background-color', '')
//		}
//	}, '.invite_reject')
//
//	$("#invite_count").on('click', function() {
//		$.get("/searchInvites", function(response) {
//			if (response) {
//				var invite_results ="";
//				for (var i = 0; i < response.length; i++) {
//					invite_results += "<div class='invite'>"+response[i][1]+"<br>"+response[i][2]+"<br><div class='button_div'><button class='invite_accept' href='/nav/accept/"+response[i][0]+"'>Accept</button> <button class='invite_reject' href='/nav/reject/"+response[i][0]+"'>Decline</button></div></div>";
//				}
//				$("#friends_results").show().html("<div id='invite_results'>"+invite_results+"</div>");
//			}
//		})
//	})
//
//	$(document).on('click', '.invite_accept', function(e) {
//		e.preventDefault();
//		$(this).parent().html("Accepted");
// 		$.ajax($(this).attr('href')).done(function() {
//			$.get("/searchInvites", function(response) {
//				if (response.length == 0) {
//					$("#invite_number").html("0");
//				} else {
//					$("#invite_number").html(response.length);
//				}
//			})
//		})
//	})
//
//	$(document).on('click', '.invite_reject', function(e) {
//		e.preventDefault();
//		$(this).parent().html("Rejected");
//		$.ajax($(this).attr('href')).done(function() {
//			$.get("/searchInvites", function(response) {
//				if (response.length == 0) {
//					$("#invite_number").html("0");
//				} else {
//					$("#invite_number").html(response.length);
//				}
//			})
//		})
//	})
//	Filtering System & Swapping out Twap/User Tables	
//	Sets up the page with Users table hidden and Twaps button selected
	$("#users_display").hide();
	$("#twaps_button").addClass('selected');

//	Changes the view to twaps table
	$("#twaps_button").click(function(e){
		e.preventDefault();
		$("#users_display").fadeOut(function(){
			$("#twap_list").fadeIn();
		});
		$("#twaps_button").addClass("selected");
		$("#users_button").removeClass("selected");
	});
	
	
//	Changes the view to users table
	$("#users_button").click(function(e){
		e.preventDefault(); 
		$("#twap_list").fadeOut(function(){
			$("#users_display").fadeIn();
		});
		$("#users_button").addClass("selected");
		$("#twap_list").removeClass("selected");
	});
	
});

//Filters twaps table by checking either twapper name or twap content
function twapsSearch(){
	var input, data, table, rows;
	input = document.getElementById("twaps_search");
	data = input.value.toUpperCase().split(" ");
	table_body = document.getElementById("twaps_table_body"); //grabs table to sort through
	rows = table_body.getElementsByTagName("tr"); //creates array of rows in the above table.
	
	if(data == ""){ 			//if search is empty but function is triggered, keep all rows showing and exit function.
		$(rows).show();
		return;
	}
	
	$(rows).hide();  //start all rows as hidden
	
	$(rows).filter(function(index){  //iterate through rows using .filter - if row contains search item then return true, else return false.
		for(var d = 0; d < data.length; d++){
			if(data[d] == ""){
				continue;
			}
			else if(rows[index].innerText.toUpperCase().indexOf(data[d]) != -1){
				return true;
			}
		}
		return false;
	}).show();  //if returned true, show that row.
}	

//Filters users table by checking either user's name or email, identical functionality as above function. 
function usersSearch(){
	var input, data, table, rows;
	input = document.getElementById("users_search");
	data = input.value.toUpperCase().split(" ");
	table_body = document.getElementById("users_table_body");
	rows = table_body.getElementsByTagName("tr");

	if(data == ""){
		$(rows).show();
		return;
	}
	
	$(rows).hide();
	
	$(rows).filter(function(index){
		for(var d = 0; d < data.length; d++){
			if(data[d] == ""){
				continue;
			}
			else if(rows[index].innerText.toUpperCase().indexOf(data[d]) != -1){
				return true;
			}
		}
		return false;
	}).show();
}

