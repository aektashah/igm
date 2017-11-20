import React from 'react';
import Map from './Map';

export default class Home extends React.Component {
	render() {
		let { channel } = this.props;
		return (
			<div className="home row">
				<Map channel={channel} />
			</div>
		);
	}
}
