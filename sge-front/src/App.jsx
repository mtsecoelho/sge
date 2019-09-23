import React, { Component } from 'react';
import Container from 'react-bootstrap/Container';
import { Route } from 'react-router-dom';
import Home from './Home';
import Login from './Login';

class App extends Component {
    constructor(props) {
        super(props)

        this.state = {
            logado: false
        }
    }

    confirmLogin() {
        this.setState({logado:true})
    }

    render() {
        return (
            this.state.logado ?
            <div>
                {/* Navbar with Links */}
                <Container fluid className="mt-3">
                    <Route path="/" exact component={Home} />
                </Container>
            </div>
            :
            <Login confirmLogin={() => this.confirmLogin()}/>
        );
    }
}

export default App;
