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

import socket from "./socket"

let channel = socket.channel("tweets:lobby", {});
var map;
var markerClusterer = null;
var infowindow = new google.maps.InfoWindow(); 

// reference: sitepoint.com/comparing-rails-exploring-websockets-in-phoenix
function joinChannel() {
	if (channel != null) {
		channel.join()
			.receive("ok", resp => { 
				console.log("Joined successfully", resp)
				channel.push("start_stream", {})
			})
			.receive("error", resp => { console.log("Unable to join", resp) })
	}
	channel.on("new_tweet", payload => {
		console.log(payload);
		var coords = payload.geo.coordinates;
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(coords[0], coords[1]),
			label: payload.screen_name[0]			
		});

		/*var content = payload.text;*/

		var content = '<blockquote class="twitter-tweet" data-lang="en"><p lang="' + payload.lang + '" dir="ltr">' + payload.text + '</p>&mdash; ' + payload.name + ' (@' + payload.screen_name + ') <a href="https://twitter.com/' + payload.screen_name + '/status/' + payload.id + '">' + payload.date + '</a></blockquote>';
			
		google.maps.event.addListener(marker,'click', function() { 
		infowindow.close();	
		infowindow.setContent(content);
	        infowindow.open(map,marker);
		twttr.widgets.load();
		});  

		var markers = [];
		markers.push(marker);
		markerClusterer.addMarkers(markers);
		
	});
}


$(function() {
	initMap();
	joinChannel();
});


function initMap() {
	var uluru = {lat: 33.43144133557529, lng: 4};
       	map = new google.maps.Map(document.getElementById('map'), {
       		zoom: 2,
       		center: uluru
       	});
	map.addListener('dragend', function() {
		var center = map.getCenter();
		console.log("CENTER=" + center.lat() + "," + center.lng());
		
	});

	markerClusterer = new MarkerClusterer(map, [],
    {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
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
}

function post_tweets(resp) {
	console.log(resp);
}
