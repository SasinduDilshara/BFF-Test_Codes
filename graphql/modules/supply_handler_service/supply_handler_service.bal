import ballerina/graphql;
import ballerina/time;

service /cargowave on new graphql:Listener(9000) {
    resource function get shipment/all() returns Order[] {
        return orderEntries;
    }

    resource function get orderItemNames() returns Order[] {
        return orderEntries;
    }
}

public type Order record {
    int orderId;
    string destination;
    OrderItems[] items;
    string? shipmentId = ();
};

public type OrderItems record {|
    string name;
    int quantity = 0;
    float? estimatedPrice;
    string country;
    time:Date manufacturedDate;
    time:Date? expiredDate;
|};

Order[] orderEntries = [
    {
        orderId: 101,
        destination: "New York",
        items: [
            {name: "Laptop", quantity: 5, estimatedPrice: 1200.50, country: "USA", manufacturedDate: "2023-08-10", expiredDate: "2024-08-10"},
            {name: "Smartphone", quantity: 10, estimatedPrice: 800.75, country: "Germany", manufacturedDate: "2023-08-15", expiredDate: "2024-08-15"}
        ],
        shipmentId: "SH12345"
    },
    {
        orderId: 102,
        destination: "London",
        items: [
            {name: "Headphones", quantity: 20, estimatedPrice: 50.0, country: "Japan", manufacturedDate: "2023-08-05", expiredDate: ()}
        ],
        shipmentId: "SH67890"
    }
];
