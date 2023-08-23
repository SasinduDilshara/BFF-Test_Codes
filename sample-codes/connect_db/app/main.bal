import ballerina/io;
import ballerina/persist;

Client sClient = check new ();

public function main() returns error? {
    // Get entire Employee record
    stream<ShipmentEntry, persist:Error?> shipmententries = sClient->/shipmententries;
    check from var shipmentEntry in shipmententries
        do {
            io:println(shipmentEntry);
        };
}
