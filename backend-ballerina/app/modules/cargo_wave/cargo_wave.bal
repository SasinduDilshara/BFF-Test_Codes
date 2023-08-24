import ballerina/log;
import ballerina/http;

listener http:Listener cargowaveListner = check new(9091);

service / on cargowaveListner {
    resource function post submit() returns error? {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
