import React from 'react';
import Nav from './Nav';
import Home from './Home';

export default class Container extends React.Component {
	render() {
		let { channel } = this.props;
		return (
			<div className="container col-12">
				<Nav />
				<Home channel={channel} />
			</div>
		);
	}
}
