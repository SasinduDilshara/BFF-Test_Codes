import ballerina/http;

public type SubmitConflictResponse record {|
    *http:Conflict;
    record {
        string message;
    } body;
|};

public type SubmitSuccessResponse record {|
    *http:Ok;
    record {
        string[] insertedIds;
    } body;
|};

public type AssignConflictResponse record {|
    *http:Conflict;
    record {
        string message;
    } body;
|};

public type OrderAssignSuccessResponse record {|
    *http:Ok;
    record {
        Order 'order;
    } body;
|};

public type ItemAssignSuccessResponse record {|
    *http:Ok;
    record {
        Item item;
    } body;
|};

public type QueryConflictResponse record {|
    *http:Conflict;
    record {
        string message;
    } body;
|};

public type QueryOrdersSuccessResponse record {|
    *http:Ok;
    record {
        Order[] orders;
    } body;
|};

public type QueryCargosSuccessResponse record {|
    *http:Ok;
    record {
        Cargo[] cargos;
    } body;
|};

public type QueryItemsSuccessResponse record {|
    *http:Ok;
    record {
        Item[] items;
    } body;
|};
