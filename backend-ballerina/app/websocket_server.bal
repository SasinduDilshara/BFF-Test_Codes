import ballerina/lang.runtime;
import ballerina/log;
import ballerina/websocket;

enum wsType {
    ORDER_TYPE,
    CARGO_TYPE
}

service /ws on wsListener {
    resource function get .(string id, string 'type) returns websocket:Service {
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

    remote function onOpen(websocket:Caller caller) {
        while true {
            OrderRecord|error orderResult = getOrder(self.orderId);
            if orderResult is error {
                error? e = caller->writeTextMessage(string `Something went wrong! - ${orderResult.toString()}`);
                if e is error {
                    log:printError("Error", e);
                }            
            } else {
                error? e = caller->writeTextMessage(orderResult.status);
                if e is error {
                    log:printError("Error", e);
                }            
            }
            runtime:sleep(100);
        }
    }
}

distinct service class CargoService {
    *websocket:Service;
    string cargoId;

    public function init(string cargoId) {
        self.cargoId = cargoId;
    }

    remote function onOpen(websocket:Caller caller) {
        while true {
            Cargo|error cargoResult = getCargo(self.cargoId);
            if cargoResult is error {
                error? e = caller->writeTextMessage(string `Something went wrong! - ${cargoResult.toString()}`);
                if e is error {
                    log:printError("Error", e);
                }            
            } else {
                error? e = caller->writeTextMessage(string `${cargoResult.lon}, ${cargoResult.lat}`);
                if e is error {
                    log:printError("Error", e);
                }            
            }
            runtime:sleep(100);
        }
    }
}
