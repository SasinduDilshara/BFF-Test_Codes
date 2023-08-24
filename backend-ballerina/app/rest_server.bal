service /submit on 'listener {
    resource function post 'order(OrderInsert|OrderInsert[] 'orders) returns SubmitSuccessResponse|SubmitConflictResponse {
        string[]|error submitOrderResult = submitOrder('orders);
        if submitOrderResult is string[] {
            return {
                body: {insertedIds: submitOrderResult}
            };
        }
        return {
            body: {message: submitOrderResult.message()}
        };
    }

    resource function post cargo(CargoInsert|CargoInsert[] cargos) returns SubmitSuccessResponse|SubmitConflictResponse {
        string[]|error submitCargoResult = submitCargo(cargos);
        if submitCargoResult is string[] {
            return {
                body: {insertedIds: submitCargoResult}
            };
        }
        return {
            body: {message: submitCargoResult.message()}
        };
    }

    resource function post item(ItemInsert|ItemInsert[] items) returns SubmitSuccessResponse|SubmitConflictResponse {
        string[]|error submitItemResult = submitItem(items);
        if submitItemResult is string[] {
            return {
                body: {insertedIds: submitItemResult}
            };
        }
        return {
            body: {message: submitItemResult.message()}
        };
    }

    resource function post 'assign\-order(string cargoId, string orderId) returns OrderAssignSuccessResponse|AssignConflictResponse {
        Order|error result = assignOrderToCargo(cargoId, orderId);
        if result is Order {
            return {
                body: {'order: result}
            };
        }
        return {
            body: {message: result.message()}
        };
    }

    resource function post 'assign\-item(string itemId, string orderId) returns ItemAssignSuccessResponse|AssignConflictResponse {
        Item|error result = assignItemToOrder(orderId, itemId);
        if result is Item {
            return {
                body: {item: result}
            };
        }
        return {
            body: {message: result.message()}
        };
    }
}
