import ballerina/log;
import ballerina/http;

listener http:Listener tradelogixListner = check new(9093);

service /tradelogix on tradelogixListner {
    resource function post submit() {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
