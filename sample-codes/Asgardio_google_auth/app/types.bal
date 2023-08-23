import ballerina/time;

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