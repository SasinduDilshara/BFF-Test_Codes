import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    },
    auth: [
        {
            jwtValidatorConfig: {
                issuer: getIssuer(),
                audience: getAudience(),
                signatureConfig: {
                    jwksConfig: {
                        url: getJwksUrl()
                    }
                }
            }
        }
    ]
}
service /submit on 'listener {
    resource function post 'order(OrderRecordInsert|OrderRecordInsert[] 'orders) returns SubmitSuccessResponse|SubmitConflictResponse {
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

    @http:ResourceConfig {
        cors: {
            allowOrigins: ["*"]
        },
        auth: [
            {
                jwtValidatorConfig: {
                    issuer: getIssuer(),
                    audience: getAudience(),
                    signatureConfig: {
                        jwksConfig: {
                            url: getJwksUrl()
                        }
                    }
                }
            }
        ]
    }
    resource function post cargo(CargoInsert|CargoInsert[] cargos) returns SubmitSuccessResponse|SubmitConflictResponse {
        string[]|error submitCargoResult = submitCargo(cargos);
        if submitCargoResult is error {
            return {
                body: {message: submitCargoResult.message()}
            };
        }
        if informCargoPartners(submitCargoResult) is error {
            return {
                body: {message: "Error while informing cargo partners"}
            };
        }

        return {
            body: {insertedIds: submitCargoResult}
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
        OrderRecord|error result = assignOrderToCargo(cargoId, orderId);
        if result is OrderRecord {
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

function informCargoPartners(string[] insertedCargoIds) returns error? {
    string url;
    from string id in insertedCargoIds
    do {
        Cargo cargo = check getCargo(id);
        if cargo.'type == CARGO_WAVE {
            url = cargowaveListnerUrl;
        } else if cargo.'type == SHIPEX {
            url = shipexListnerUrl;
        } else {
            url = tradelogixListnerUrl;
        }

        http:Client 'client = check new (url, auth = {
            tokenUrl: getIssuer(),
            clientId: getClientId(),
            clientSecret: getClientSecret()
        });
        // http:Client 'client = check new (url);
        http:Response|error res = 'client->post("/submit", cargo);
        if res is http:Response {
            if res.statusCode == 202 {
                return ();
            }
            return error("Error while informing cargo partners"+ res.statusCode.toBalString()+ res.reasonPhrase.toString());
        }
    };
}
