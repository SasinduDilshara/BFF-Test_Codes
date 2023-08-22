import ballerina/http;
import ballerina/log;

public listener http:Listener megaportAPI = new (getPort(),
    interceptors = [new AuthInterceptor()]
);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"],
        allowCredentials: true,
        maxAge: 84900
    }
}
service / on megaportAPI {
    resource function get ships(http:RequestContext ctx) returns ShipmentEntry[]|error {
        //TODO:When calling the other API, get the  token
        boolean isAuthorized = authorize(ctx, getScopes().get("view"));
        if !isAuthorized {
            return error("User is not authorized to view ships");
        } else {
            ShipmentEntry[] response = [];
            foreach var deliveryShip in shipmentTable {
                response.push(deliveryShip);
            }
            return response;
        }
    }

    resource function post ships(http:RequestContext ctx, @http:Payload ShipmentEntry shipDeials)
        returns ShipmentEntry|error {
        boolean isAuthorized = authorize(ctx, getScopes().get("create"));

        if !isAuthorized {
            log:printDebug("error");
            return error("User is not authorized to view ships");
        } else {
            shipmentTable.add(shipDeials);
            log:printDebug("New ship created successfully!");
            return shipDeials;
        }
    }
}
