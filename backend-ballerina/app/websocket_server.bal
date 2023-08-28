import ballerina/websocket;

enum wsType {
    ORDER_TYPE,
    CARGO_TYPE
}

service /ws on wsListener {
    resource function get .(string id, wsType 'type) returns websocket:Service {
        if 'type == ORDER_TYPE {
            return new OrderService(id);
        } else {
            return new CargoService(id);
        }
    }
}

distinct service class OrderService {
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

distinct service class CargoService {
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
