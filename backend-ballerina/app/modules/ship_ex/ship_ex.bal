import ballerina/log;
import ballerina/http;

listener http:Listener shipexListner = check new(9092);

service /shipex on shipexListner {
    resource function post submit() {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
