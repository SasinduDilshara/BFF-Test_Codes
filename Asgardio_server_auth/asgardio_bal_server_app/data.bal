public final table<ShipmentEntry> key(shipmentId) shipmentTable = table [
    {shipmentId: "CW123", status: "In Transit", origin: "Port A", destination: "Port B", eta: "2023-08-15 12:00"},
    {shipmentId: "CW124", status: "Idle", origin: "Port B", destination: "Port C", eta: "2023-08-17 14:00"},
    {shipmentId: "CW125", status: "Finished", origin: "Port B", destination: "Port A", eta: "2023-08-13 11:00"}
];