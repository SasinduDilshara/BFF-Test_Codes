import ballerina/log;
import ballerina/http;

listener http:Listener cargowaveListner = check new(9091);

service /cargowave on cargowaveListner {
    resource function post submit() {
        log:printInfo("New cargo was successfully register to the megaport");
    }
}
