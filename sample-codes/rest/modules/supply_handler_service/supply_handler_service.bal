import ballerina/http;
import ballerina/log;
import ballerina/time;

service /cargowave on new http:Listener(9000) {

    resource function get shipment/[string shipmentId]() returns ShipmentEntry[] {
        return shipmentTable.toArray();
    }

    resource function post shipment/submit(ShipmentEntry shipmentEntry)
            returns http:Created|InvalidShipmentIdError {
        if shipmentTable.hasKey(shipmentEntry.shipmentId) {
            log:printDebug(string `Id: ${shipmentEntry.shipmentId} is already exists!`);
            return {
                errorMessage: string `Id: ${shipmentEntry.shipmentId} is already exists!`
            };
        }

        shipmentTable.add(shipmentEntry);
        return http:CREATED;
    }

    resource function post shipment/assign(string shipmentId, Order 'order, time:Civil assignDate) 
            returns Order|InvalidShipmentIdError|OrderAlreadyShippedError {
        if !shipmentTable.hasKey(shipmentId) {
            log:printDebug(string `Id: ${shipmentId} cannot be found!`);
            return {
                errorMessage: string `Id: ${shipmentId} cannot be found!`
            };
        }

        if 'order.shipmentId !is () {
            return {
                errMessage: string `The order already shipped under shipment id : ${shipmentId}`
            };
        }

        'order.shipmentId = shipmentId;
        return 'order;
    }
}

type ShipmentEntry record {|
    readonly string shipmentId;
    string status;
    string origin;
    string destination;
    string eta;
|};

public type Order record {
    int orderId;
    string destination;
    OrderItems[] items;
    string? shipmentId = ();
};

type OrderItems record {|
    string name;
    int quantity = 0;
    float? estimatedPrice;
    string country;
    time:Date manufacturedDate;
    time:Date? expiredDate;
|};

public final table<ShipmentEntry> key(shipmentId) shipmentTable = table [
    {shipmentId: "CW123", status: "In Transit", origin: "Port A", destination: "Port B", eta: "2023-08-15 12:00"},
    {shipmentId: "CW124", status: "Idle", origin: "Port B", destination: "Port C", eta: "2023-08-17 14:00"},
    {shipmentId: "CW125", status: "Finished", origin: "Port B", destination: "Port A", eta: "2023-08-13 11:00"}
];

public type InvalidShipmentIdError record {|
    *http:Conflict;
    string errorMessage;
|};

public type OrderAlreadyShippedError record {|
    *http:BadRequest;
    string errMessage;
|};
