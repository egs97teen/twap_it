$(document).ready(function(){
	
	$("#search_bar").on('input', function() {
		var input = $(this).val();
		$.get("/searchUser", {query: input}, function(response) {
			var results = "";
			if (input == "") {
				results = "";
			} else if (response.length > 5) {
				for (var i = 0; i < 5; i++) {
					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
				}
			} else {
				for (var i = 0; i < response.length; i++) {
					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
				}
			}
			if (response) {
				$("#results").show().html("<div id='results'>"+results+"</div>")
			}

		}, "json")
	})

	$(this).click(function() {
		$("#results").hide();
	})

	$("#search_bar").click(function() {
		$("#results").show();
		var input = $(this).val();
		$.get("/searchUser", {query: input}, function(response) {
			var results = "";
			if (input == "") {
				results = "";
			} else if (response.length > 5) {
				for (var i = 0; i < 5; i++) {
					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
				}
			} else {
				for (var i = 0; i < response.length; i++) {
					results += "<a href='/user/"+response[i][2]+"'><div class='search_result'>"+response[i][0]+"<br>"+response[i][1]+"</div></a>";
				}
			}
			if (response) {
				$("#results").show().html("<div id='results'>"+results+"</div>")
			}

		}, "json")
	})

	$(document).on({
		mouseenter: function() {
			$(this).css('background-color', '#cccccc')
		},
		mouseleave: function() {
			$(this).css('background-color', '')
		}
	}, '.search_result')

	$(document).mouseup(function(e)
	{
    var container = $("#friends_results");

    // if the target of the click isn't the container nor a descendant of the container
    if (!container.is(e.target) && container.has(e.target).length === 0)
    {
        container.hide();
    }
	});

	$(document).on({
		mouseenter: function() {
			$(this).css('background-color', '#cccccc')
		},
		mouseleave: function() {
			$(this).css('background-color', '')
		}
	}, '.invite')

	$(document).on({
		mouseenter: function() {
			$(this).css('background-color', 'green')
		},
		mouseleave: function() {
			$(this).css('background-color', '')
		}
	}, '.invite_accept')

	$(document).on({
		mouseenter: function() {
			$(this).css('background-color', 'red')
		},
		mouseleave: function() {
			$(this).css('background-color', '')
		}
	}, '.invite_reject')

	$("#invite_count").on('click', function() {
		$.get("/searchInvites", function(response) {
			if (response) {
				var invite_results ="";
				for (var i = 0; i < response.length; i++) {
					invite_results += "<div class='invite'>"+response[i][1]+"<br>"+response[i][2]+"<br><div class='button_div'><button class='invite_accept' href='/nav/accept/"+response[i][0]+"'>Accept</button> <button class='invite_reject' href='/nav/reject/"+response[i][0]+"'>Decline</button></div></div>";
				}
				$("#friends_results").show().html("<div id='invite_results'>"+invite_results+"</div>");
			}
		})
	})

	$(document).on('click', '.invite_accept', function(e) {
		e.preventDefault();
		$(this).parent().html("Accepted");
 		$.ajax($(this).attr('href')).done(function() {
			$.get("/searchInvites", function(response) {
				if (response.length == 0) {
					$("#invite_number").html("0");
				} else {
					$("#invite_number").html(response.length);
				}
			})
		})
	})

	$(document).on('click', '.invite_reject', function(e) {
		e.preventDefault();
		$(this).parent().html("Rejected");
		$.ajax($(this).attr('href')).done(function() {
			$.get("/searchInvites", function(response) {
				if (response.length == 0) {
					$("#invite_number").html("0");
				} else {
					$("#invite_number").html(response.length);
				}
			})
		})
	})
	
//	Sets up the page with Users table hidden and Twaps button selected
	$("#users_display").hide();
	$("#twaps_button").addClass('selected');

//	Changes the view to users table
	$("#users_button").click(function(e){
		e.preventDefault();
		$("#users_display").fadeIn();
		$("#twap_list").fadeOut();
		$("#users_button").addClass("selected");
		$("#twap_list").removeClass("selected");
	});
	
//	Changes the view to twaps table
	$("#twaps_button").click(function(e){
		e.preventDefault();
		$("#twap_list").fadeIn();
		$("#users_display").fadeOut();
		$("#twaps_button").addClass("selected");
		$("#users_button").removeClass("selected");
	});
})

//Filters twaps table by checking either twapper name or twap content
function twapsSearch(){
	var input, filter, table, tr, content, user, i;
	input = document.getElementById("twaps_search");
	filter = input.value.toUpperCase()
	table = document.getElementById("twaps_table");
	tr = table.getElementsByTagName("tr");

	for(i = 0; i < tr.length; i++){
		content = tr[i].getElementsByTagName("td")[0];
		user = tr[i].getElementsByTagName("td")[1];
		if(content || user){
			if(content.innerHTML.toUpperCase().indexOf(filter) > -1 || user.innerHTML.toUpperCase().indexOf(filter) > -1 ){
				tr[i].style.display="";
			}else{
				tr[i].style.display="none";
			}
		}
	}
}

//Filters users table by checking user name or user email.
function usersSearch(){
	var input, filter, table, tr, userName, userEmail, i;
	input = document.getElementById("users_search");
	filter = input.value.toUpperCase();
	table = document.getElementById("users_table");
	tr = table.getElementsByTagName("tr");

	for(i = 0; i < tr.length; i++){
		userName = tr[i].getElementsByTagName("td")[0];
		userEmail = tr[i].getElementsByTagName("td")[1];
		if(userName || userEmail){
			if(userName.innerHTML.toUpperCase().indexOf(filter) > -1 || userEmail.innerHTML.toUpperCase().indexOf(filter) > -1 ){
				tr[i].style.display="";
			}else{
				tr[i].style.display="none";
			}
		}
	}
}