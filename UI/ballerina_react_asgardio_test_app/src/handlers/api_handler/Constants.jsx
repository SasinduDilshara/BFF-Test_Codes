export const serverUrl = "http://localhost:3000";

// POST requests
export const submitCargoUrl = "/submit/cargo";
export const submitOrderUrl = "/submit/order";
export const submitItemUrl = "/submit/item";
export const submitAssignItemUrl = "/submit/assign-item";
export const submitAssignOrderUrl = "/submit/assign-order";

// GET requests
export const getCargosUrl = "/get/cargos";
export const getOrdersUrl = "/get/orders";
export const getItemsUrl = "/get/items";
export const getCargoStatusUrl = "/ws/cargo-status";
export const getOrderStatusUrl = "/ws/order-status";

// GraphQL queries

export const getOrdersQuery =  {
    orders() {
        orderId
        amount
        shipId
        eta
    }
};

export const getItemsQuery =  {
    orders() {
        price
        name
        order: {
            orderId
            amount
            shipId
            eta
        }
    }
};

export const getCargosQuery =  {
    cargos() {
        cargoId
        startFrtom
        endfrom
        eta
        type
    }
};
