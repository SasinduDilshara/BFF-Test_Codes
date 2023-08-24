import ballerina/graphql;
import ballerina/websocket;
import ballerina/http;

listener http:Listener 'listener = check new(9090);
listener graphql:Listener 'graphqlListener = new('listener);
listener websocket:Listener 'wsListener = new('listener);
