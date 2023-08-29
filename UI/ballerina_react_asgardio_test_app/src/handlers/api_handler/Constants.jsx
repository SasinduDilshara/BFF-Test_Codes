import gql from 'graphql-tag';

export const serverUrl = "http://localhost:9090";
export const serverSocketUrl = "ws://localhost:9090";

// POST requests
export const submitCargoUrl = serverUrl + "/submit/cargo";
export const submitOrderUrl = serverUrl + "/submit/order";
export const submitItemUrl = serverUrl + "/submit/item";
export const submitAssignItemUrl = serverUrl + "/submit/assign-item";
export const submitAssignOrderUrl = serverUrl + "/submit/assign-order";

// GET requests
export const getGraphQlUrl = serverUrl + "/get";
export const wsConnectionUrl = serverSocketUrl + "/ws";

// GraphQL queries

export const getOrdersQuery =
    gql`query {
            orders {
            orderId
            totalAmount
            shipId
            eta
            customerId
        }
    }`;

export const getCargosQuery =
    gql`query {
        cargos {
            cargoId
            startFrom
            endFrom
            eta
            type
            volume
            eta
        }
    }`;

export const getItemsQuery =
    gql`query {
        items {
            itemId
            name
            price
        }
    }`;
