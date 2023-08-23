import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    string username = io:readln("Enter username: ");
    // Users can register for this simply by connecting to the server.
    websocket:Client wsClient = check new(string `ws://localhost:9090/subscribe/${username}`);
   
   // Continuously read the location updates coming from the server.
    while true {
        string shipLocation = check wsClient->readTextMessage();
        io:println(shipLocation);
    }
}