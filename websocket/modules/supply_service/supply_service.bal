import ballerina/http;
import ballerina/io;
import ballerina/websocket;

string nameValue = "";
string ship = "";
listener websocket:Listener shipmentMgtListener = new websocket:Listener(9090);
map<string> shipDeliveryMap = {};
map<websocket:Caller> clientsMap = {};
map<websocket:Caller[]> shipClients = {};

// This service is for shipDelivery to register and send locations.
service /shipment on shipmentMgtListener {
    resource function get [string name]() returns websocket:Service|websocket:UpgradeError {
        nameValue = name;
        return service object websocket:Service {
            remote function onOpen(websocket:Caller caller) returns websocket:Error? {
                string welcomeMsg = "Hi " + nameValue + "! Your location will be shared with the clients";
                check caller->writeTextMessage(welcomeMsg);
                shipDeliveryMap[caller.getConnectionId()] = nameValue;
            }
            
            // 'onTextMessage' remote function will receive the location updates from shipDelivery.
            remote function onTextMessage(websocket:Caller caller, string location) returns websocket:Error? {
                @strand {
                    thread:"any"
                }
                worker broadcast returns error? {
                    string? shipName = shipDeliveryMap[caller.getConnectionId()];
                    if (shipName is string) {
                        string locationUpdateMsg = shipName + " updated the location: " + location;
                        // Broadcast the live locations to registered clients.
                        broadcast(locationUpdateMsg, nameValue);
                    }
                }
            }

            remote function onClose(websocket:Caller caller, int statusCode, string reason) {
                _ = shipDeliveryMap.remove(caller.getConnectionId());
            } 
        };
    }
}

// This service is for clients to get registered. Once registered, clients will get notified about the live locations
// of the ship deliveries.
service /subscribe on shipmentMgtListener {
    resource function get [string name]/[string shipName](http:Request req) returns websocket:Service|websocket:UpgradeError {
        nameValue = name;
        ship = shipName;
        return service object websocket:Service {
            remote function onOpen(websocket:Caller caller) returns websocket:Error? {
                string welcomeMsg = "Hi " + nameValue + "! You have successfully connected.";
                check caller->writeTextMessage(welcomeMsg);
                clientsMap[caller.getConnectionId()] = caller;
                if shipClients.hasKey(ship) {
                    (<websocket:Caller[]> (shipClients[ship])).push(caller);
                } else {
                    shipClients[ship] = [caller];
                }
            }
            remote function onClose(websocket:Caller caller, int statusCode, string reason) {
                _ = clientsMap.remove(caller.getConnectionId());
            } 
        };
    }
}

// Function to perform the broadcasting of text messages.
function broadcast(string msg, string shipname) {
    foreach websocket:Caller con in clientsMap {
        if shipClients.hasKey(shipname){
            websocket:Caller[]? clients = shipClients[shipname];
            if clients is websocket:Caller[] && clients.some('client => 'client === con) {
                websocket:Error? err = con->writeTextMessage(msg);         
                if (err is websocket:Error) {
                    io:println("Error sending message:" + err.message());
                }
            }
        }
    }    
}
