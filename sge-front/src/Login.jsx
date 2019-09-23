import React, { Component } from 'react';
import Button from 'react-bootstrap/Button';

class Login extends Component {
    render() {
        return (
        <div>
            <h1>Login</h1>
            <Button onClick={() => this.props.confirmLogin()}>Login</Button>
        </div>) ;
    }
}

export default Login;