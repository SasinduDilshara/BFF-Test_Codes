import ballerina/persist as _;
import ballerina/time;

public enum OrderStatus {
    PENDING,
    SHIPPED,
    DELIVERED,
    CANCELED,
    RETURNED
};

public enum ShipStatus {
    DOCKED,
    DEPARTED,
    IN_TRANSIT,
    COMPLETED,
    CANCELED
};

public enum CargoType {
    SHIPEX,
    CARGO_WAVE,
    TRADDE_LOGIX
};

public type Item record {|
    readonly string itemId;
    string name;
    float price;
	Order 'order;
|};

public type Order record {|
    readonly string orderId;
    string customerId;
    Item[] items;
    float totalAmount;
    string shipId;
    time:Date date;
    time:Civil eta;
    OrderStatus status;
|};

public type Cargo record {|
    readonly string cargoId;
    time:Civil eta;
    ShipStatus status;
    CargoType 'type;
    string startFrom;
    string endFrom;
    float volume;
|};