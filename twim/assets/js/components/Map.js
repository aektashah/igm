import React from 'react';

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
	
	initMap() {
		/*map.addListener('dragend', function() {
			var center = map.getCenter();
		});*/
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
		this.state.channel.on("tweet", payload => {
			console.log(payload);
			var coords = payload.geo.coordinates;
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(coords[0], coords[1]),
				label: payload.screen_name[0].toUpperCase()
			});

			var content = '<blockquote class="twitter-tweet" data-lang="en">'
				+ '<p lang="' + payload.lang + '" dir="ltr">' + payload.text + '</p>'
				+ '&mdash; ' + payload.name + ' (@' + payload.screen_name + ') '
				+ '<a href="https://twitter.com/' + payload.screen_name + '/status/' + payload.id + '">' + payload.date + '</a>'
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
