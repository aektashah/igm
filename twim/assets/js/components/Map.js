import React from 'react';

function getLabel(screen_name) {
	for (var i = 0; i < screen_name.length; i++) {
		let char = screen_name[i];
		if (char.match(/[a-z]/i)) {
			return char;
		}
	}
	return "@";
}

export default class Map extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			map: null,
			markerClusterer: null,
			infowindow: null,
			channel: props.channel
		};
	}
	
	componentDidMount() {
		var uluru = {lat: 33.43144133557529, lng: 4};
		this.setState({
			map: new google.maps.Map(this.mapElem, { zoom: 2, center: uluru }),
			infowindow: new google.maps.InfoWindow()
		}, this.addClusters);
	}

	addClusters() {
		this.setState({
			markerClusterer: new MarkerClusterer(this.state.map, [], {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'})
		}, this.joinChannel);
	}

	joinChannel() {
		this.state.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully", resp)
				this.state.channel.push("start", {})
			})
			.receive("error", resp => { console.log("Unable to join", resp);
		});
		let { infowindow, map, markerClusterer } = this.state;
		this.state.channel.on("tweet", tweet => {
			console.log(tweet);
			var coords = tweet.geo.coordinates;
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(coords[0], coords[1]),
				label: getLabel(tweet.screen_name.toUpperCase())
			});

			var content = '<blockquote class="twitter-tweet" data-lang="en">'
				+ '<p lang="' + tweet.lang + '" dir="ltr">' + tweet.text + '</p>'
				+ '&mdash; ' + tweet.name + ' (@' + tweet.screen_name + ') '
				+ '<a href="https://twitter.com/' + tweet.screen_name + '/status/' + tweet.id + '">' + tweet.date + '</a>'
				+ '</blockquote>';

			google.maps.event.addListener(marker, 'click', function() {
				infowindow.close();
				infowindow.setContent(content);
				infowindow.open(map, marker);
				twttr.widgets.load();
			});

			var markers = [];
			markers.push(marker);
			markerClusterer.addMarkers(markers);
		});
	}

	render() {
		return (
			<div className="col-md-12" ref={(m) => this.mapElem = m}></div>
		);
	}
}
