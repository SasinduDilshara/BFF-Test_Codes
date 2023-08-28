import './App.css';
import React from 'react';
import { Provider } from 'react-redux';
import store from './handlers/state_handler/store';
import { AuthProvider } from "@asgardeo/auth-react";
import { asgardioConfig } from './handlers/auth_handler/asgardio_config';
import CustomRouter from './routes';
import { ApolloProvider } from '@apollo/client';
import { apolloClient } from './handlers/api_handler/config';

function App() {
  return (
    <ApolloProvider client={apolloClient}>
      <Provider store={store} >
        <AuthProvider config={asgardioConfig}>
          <CustomRouter />
        </AuthProvider>
      </Provider>
    </ApolloProvider>
  );
}

export default App;
