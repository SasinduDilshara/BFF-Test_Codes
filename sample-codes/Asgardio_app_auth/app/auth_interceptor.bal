import ballerina/http;
import ballerina/jwt;
import ballerina/log;

//TODO: When no tolken, scenario, only login, register and other wanted pages.
// when there is other page, asgardio page will retrigger.


jwt:ValidatorConfig validatorConfig = {
    issuer: getIssuer(),
    audience: getAudience(),
    clockSkew: 60,
    signatureConfig: {
        jwksConfig: {
            url: getJwksUrl()
        }
    }
};

service class AuthInterceptor {
    *http:RequestInterceptor;
    resource function 'default [string... path](http:RequestContext ctx, http:Request req, @http:Header string? authorization) returns http:NextService|http:Unauthorized|error? {
        // TODO: can we replace this using ServiceConfig annotaions?
        
        string? authHeader = authorization;
        if authHeader is () && req.method.equalsIgnoreCaseAscii(http:OPTIONS) {
            return ctx.next();
        }
        if authHeader is () || !authHeader.startsWith("Bearer "){
            return <http:Unauthorized> {
                body: "Missing or invalid Authorization header."
            } ;
        }

        log:printDebug(authHeader);
        string token = authHeader.substring(7);
        jwt:Payload|error result = jwt:validate(token, validatorConfig);

        if result is error {
            log:printDebug("Unauthorized access", result);
            return <http:Unauthorized> {
                body: "You are unauthorized to access this resource."
            } ;
        }
        log:printDebug(result.toBalString());

        string userId = result.get("sub").toString();
        string scopes = result.get("scope").toString();
        log:printDebug(scopes);

        ctx.set("scopes", scopes);
        ctx.set("userId", userId);

        return ctx.next();
    }
}
