import ballerina/websocket;

service /ws on graphqlListener {
    resource function get order\-status/[string orderId]() returns websocket:Service {
        return new OrderService(orderId);
    }

    resource function get cargo\-status/[string cargoId]() returns websocket:Service {
        return new CargoService(cargoId);
    }
}

service class OrderService {
    *websocket:Service;
    string orderId;

    public function init(string orderId) {
        self.orderId = orderId;
    }

    remote function onMessage(websocket:Caller caller, string chatMessage) returns error? {
        Order|error orderResult = getOrder(self.orderId);
        if orderResult is error {
            return caller->writeTextMessage(string `Something went wrong! - ${orderResult.toString()}`);
        }
        return caller->writeTextMessage(string `Order status is ${orderResult.status}`);
    }
}

service class CargoService {
    *websocket:Service;
    string cargoId;

    public function init(string cargoId) {
        self.cargoId = cargoId;
    }

    remote function onMessage(websocket:Caller caller, string chatMessage) returns error? {
        Cargo|error cargoResult = getCargo(self.cargoId);
        if cargoResult is error {
            return caller->writeTextMessage(string `Something went wrong! - ${cargoResult.toString()}`);
        }
        return caller->writeTextMessage(string `Order status is ${cargoResult.status}`);
    }
}
