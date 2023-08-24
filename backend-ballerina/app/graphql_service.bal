// import ballerina/persist;

service /get on 'graphqlListener {
    resource function get orders() returns QueryOrdersSuccessResponse|QueryConflictResponse {
        Order[]|error 'orders = from var 'order in getOrders()
            select 'order;

        if ('orders is error) {
            return {
                body: {
                    message: 'orders.message()
                }
            };
        }
        return {
            body: {
                orders: 'orders
            }
        };
    }

    resource function get cargos() returns QueryCargosSuccessResponse|QueryConflictResponse {
        Cargo[]|error 'cargos = from var 'cargo in getCargos()
            select 'cargo;

        if ('cargos is error) {
            return {
                body: {
                    message: 'cargos.message()
                }
            };
        }
        return {
            body: {
                cargos: 'cargos
            }
        };
    }

    resource function get items() returns QueryItemsSuccessResponse|QueryConflictResponse {
        Item[]|error 'items = from var 'item in getItems()
            select 'item;

        if ('items is error) {
            return {
                body: {
                    message: 'items.message()
                }
            };
        }
        return {
            body: {
                items: 'items
            }
        };
    }

    resource function get cargos/[CargoType 'type]() returns QueryCargosSuccessResponse|QueryConflictResponse {
        Cargo[]|error 'cargos = from var 'cargo in getCargosByType('type)
            select 'cargo;

        if ('cargos is error) {
            return {
                body: {
                    message: 'cargos.message()
                }
            };
        }
        return {
            body: {
                cargos: 'cargos
            }
        };
    }

    resource function get orders/[string cargoId]() returns QueryOrdersSuccessResponse|QueryConflictResponse {
        Order[]|error 'orders = from var 'order in getOrdersByCargo(cargoId)
            select 'order;

        if ('orders is error) {
            return {
                body: {
                    message: 'orders.message()
                }
            };
        }
        return {
            body: {
                orders: 'orders
            }
        };
    }

    resource function get items/[string orderId]() returns QueryItemsSuccessResponse|QueryConflictResponse {
        Item[]|error 'items = from var 'item in getItemsByOrder(orderId)
            select 'item;

        if ('items is error) {
            return {
                body: {
                    message: 'items.message()
                }
            };
        }
        return {
            body: {
                items: 'items
            }
        };
    }
}
