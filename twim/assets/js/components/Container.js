import React from 'react';
import Home from './Home';

export default class Container extends React.Component {
	render() {
		return (
			<div className="container col-12">
				<nav className="nav">
					<a class="nav-link active" href="#">Twim</a>
				</nav>
				<Home />
			</div>
		);
	}
}
