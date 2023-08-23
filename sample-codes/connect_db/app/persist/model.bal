import ballerina/persist as _;
import ballerina/time;

type ShipmentEntry record {|
    readonly string shipmentId;
    string status;
    string origin;
    string destination;
    string eta;
|};

public type Order record {|
    readonly int orderId;
    string destination;
    OrderItems[] items;
    string? shipmentId;
|};

public type OrderItems record {|
    readonly string name;
    Order orderId;
    int quantity;
    float? estimatedPrice;
    string country;
    time:Date manufacturedDate;
    time:Date? expiredDate;
|};
