import { ApolloClient, InMemoryCache } from '@apollo/client';
import { getGraphQlUrl } from './Constants';

export const apolloClient = new ApolloClient({
  uri: getGraphQlUrl,
  cache: new InMemoryCache(),
});
