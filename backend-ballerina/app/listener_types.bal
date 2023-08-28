import ballerina/http;
import ballerina/graphql;
import ballerina/websocket;

listener http:Listener 'listener = check new(9090);
listener graphql:Listener graphqlListener = new('listener);
listener websocket:Listener wsListener = new('listener);

const string cargowaveListnerUrl = "http://localhost:9091";
const string shipexListnerUrl = "http://localhost:9092";
const string tradelogixListnerUrl = "http://localhost:9093";
