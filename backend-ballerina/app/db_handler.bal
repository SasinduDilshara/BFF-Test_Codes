import ballerina/persist;

Client sClient = check new ();

public function submitOrder(OrderInsert|OrderInsert[] orderData) returns string[]|error {
    OrderInsert[] 'orders = [];
    if (orderData is OrderInsert) {
        'orders = [orderData];
    } else {
        'orders = orderData;
    }
    return <string[]> check sClient->/orders.post('orders);
}

public function submitCargo(CargoInsert|CargoInsert[] cargoData) returns string[]|error {
    CargoInsert[] cargos = [];
    if (cargoData is CargoInsert) {
        cargos = [cargoData];
    } else {
        cargos = cargoData;
    }
    return <string[]> check sClient->/cargos.post(cargos);
}

public function submitItem(ItemInsert|ItemInsert[] itemData) returns string[]|error {
    ItemInsert[] items = [];
    if (itemData is ItemInsert) {
        items = [itemData];
    } else {
        items = itemData;
    }
    return <string[]> check sClient->/items.post(items);
}

public function getOrders() returns stream<'Order, persist:Error?> {
     return sClient->/orders;
}

public function getCargos() returns stream<'Cargo, persist:Error?> {
     return sClient->/cargos;
}

public function getItems() returns stream<'Item, persist:Error?> {
     return sClient->/items;
}

public function getOrder(string id) returns 'Order|error {
    return check sClient->/orders/[id];
}

public function getCargo(string id) returns 'Cargo|error {
    return check sClient->/cargos/[id];
}

public function getItem(string id) returns 'Item|error {
    return check sClient->/items/[id];
}

public function getCargosByType(CargoType 'type) returns stream<Cargo, persist:Error?> {
    stream<Cargo, persist:Error?> cargos = sClient->/cargos;
    return from var cargo in cargos
        where cargo.'type == 'type
        select cargo;
}

public function assignItemToOrder(string orderId, string itemId) returns Item|error {
    return check sClient->/items/[itemId].put({
        orderOrderId: orderId
    });
}

public function assignOrderToCargo(string shipId, string orderId) returns Order|error {
    return check sClient->/orders/[orderId].put({shipId});
}

public function getItemsByOrder(string orderId) returns stream<Item, persist:Error?> {
    stream<Item, persist:Error?> items = sClient->/items;
    return from var item in items
        where item.orderOrderId == orderId
        select item;
}

public function getOrdersByCargo(string shipId) returns stream<Order, persist:Error?> {
    stream<Order, persist:Error?> orders = sClient->/orders;
    return from var 'order in orders
        where 'order.shipId == shipId
        select 'order;
}
