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

var map;

function initMap() {
       	var uluru = {lat: 42.3601, lng: -71.0589};
       	var map = new google.maps.Map(document.getElementById('map'), {
       		zoom: 15,
       		center: uluru
       	});
       	var marker = new google.maps.Marker({
       		position: uluru,
       		map: map
       	});
	var center = map.getCenter();
	get_tweets(center.lat(), center.lng());
}

function get_tweets(latitude, longitude) {
	let dd = $($("#map")[0]);
	let get_path = dd.data('path');

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
}
