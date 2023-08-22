import ballerina/http;
import ballerina/jwt;
import ballerina/log;

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
    resource function 'default [string... path](http:RequestContext ctx, http:Request req, @http:Header ServiceHeader? 'client) returns http:NextService|http:Unauthorized|http:BadRequest|error? {
        string|http:BadRequest|http:ClientError token = validateAndGetTheToken(req, 'client);
        if token is http:BadRequest|http:ClientError {
            return token;
        }
        [jwt:Header, jwt:Payload]|jwt:Error decode = jwt:decode(token);

        if decode is jwt:Error {
            log:printDebug("Unauthorized access", decode);
            return <http:Unauthorized> {
                body: "You are unauthorized to access this resource."
            } ;
        }
        jwt:Payload payload = decode[1];
        log:printDebug(payload.toBalString());

        string userId = payload.get("sub").toString();
        string scopes = payload.get("scope").toString();
        log:printDebug(scopes);

        ctx.set("scopes", scopes);
        ctx.set("userId", userId);
        return ctx.next();
    }
}

function validateAndGetTheToken(http:Request req, @http:Header ServiceHeader? 'client) 
        returns string|http:BadRequest|http:ClientError {
    string clientSecret = "";
    string clientID = "";
    
    if 'client is ServiceHeader {
        clientID = <string>'client.get("client_id"); // Create a constant for this names.
        clientSecret = <string>'client.get("client_secret");
    }

    http:Client|http:Error asgardioClient = new ("https://api.asgardeo.io/t/orgsd/oauth2", auth = {
        username: clientID,
        password: clientSecret
    });
    if asgardioClient is http:Error {
        log:printDebug("Unauthorized access", asgardioClient);
        return <http:BadRequest> {
            body: "You are unauthorized to access this resource."
        } ;
    } else {
        TokenResponse tokenResponse = check asgardioClient->/token.post({
            "grant_type": "client_credentials",
            "scope": "write_data"
        });

       return tokenResponse.access_token; 
    }
}
