import './App.css';
import React from 'react';
import { Provider } from 'react-redux';
import store from './handlers/state_handler/store';
import HomePage from './pages/HomePage/HomePage';
import { AuthProvider } from "@asgardeo/auth-react";
import { asgardioConfig } from './handlers/auth_handler/asgardio_config';
import CustomRouter from './routes';
import { BrowserRouter } from 'react-router-dom';

function App() {
  return (
      <Provider store={store} >
        <AuthProvider config={asgardioConfig}>
          <CustomRouter />
        </AuthProvider>
      </Provider>
  );
}

export default App;
