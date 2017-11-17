// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(function() {
	if (!$("#tweet-feed").length > 0) {
		return;
	}
	
	let dd = $($("#tweet-feed")[0]);
	let get_path = dd.data('path');

	let latitude = 42.3391;
	let longitude = -71.0876;

	$.ajax({
		url: get_path,
		data: {lat: latitude, long: longitude},
		contentType: "application/json",
		dataType: "json",
		method: "GET",
		success: post_tweets,
	});

	function post_tweets(resp) {
		console.log(resp);
	}
});
