import ballerina/graphql;

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /get on graphqlListener {
    resource function get orders() returns OrderRecord[]|error {
        OrderRecord[]|error 'orders = from var 'order in getOrders()
            select 'order;

        return 'orders;
    }

    resource function get cargos() returns Cargo[]|error {
        Cargo[]|error 'cargos = from var 'cargo in getCargos()
            select 'cargo;

        return 'cargos;
    }

    resource function get items() returns Item[]|error {
        Item[]|error 'items = from var 'item in getItems()
            select 'item;

        return 'items;
    }

    resource function get cargosByType(CargoType 'type) returns Cargo[]|error {
        Cargo[]|error 'cargos = from var 'cargo in getCargosByType('type)
            select 'cargo;
        return 'cargos;
    }

    resource function get ordersById(string orderId) returns OrderRecord[]|error {
        OrderRecord[]|error 'orders = from var 'order in getOrdersByCargo(orderId)
            select 'order;

        return 'orders;
    }

    resource function get itemsById(string itemId) returns Item[]|error {
        Item[]|error 'items = from var 'item in getItemsByOrder(itemId)
            select 'item;

        return 'items;
    }
}
