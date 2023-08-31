import './App.css';
import React from 'react';
import { Provider } from 'react-redux';
import store from './handlers/state_handler/store';
import { AuthProvider } from "@asgardeo/auth-react";
import { asgardioConfig } from './handlers/auth_handler/asgardio_config';
import CustomRouter from './routes';
import { ApolloProvider } from '@apollo/client';
import { ApolloClient, InMemoryCache } from '@apollo/client';
import { getGraphQlUrl } from './handlers/api_handler/Constants';

function App() {

  const apolloClient = new ApolloClient({
    uri: getGraphQlUrl,
    cache: new InMemoryCache()
  });

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
