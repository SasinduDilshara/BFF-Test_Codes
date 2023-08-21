import ballerina/io;
import ballerina/random;
import ballerina/lang.runtime;
import ballerina/websocket;

public function main() returns error? {
    string shipname = io:readln("Enter name of the ship: ");
    websocket:Client wsClient = check new(string `ws://localhost:9090/shipment/${shipname}`);
    string connectedMsg = check wsClient->readTextMessage();
    io:println(connectedMsg);
    check updateLocation(wsClient);
}

// This function simulates a real time gps location updates. 
// This updated location will be sent to the server every 2 seconds.
function updateLocation(websocket:Client ship) returns error? {
    while true {
        float lon = random:createDecimal() + 79.0;
        float lat = random:createDecimal() + 6.0;
        string location = "'Latitude'=" + lat.toString() + " 'Longititude'=" + lon.toString();
        check ship->writeTextMessage(location);
        runtime:sleep(2);
    }
}