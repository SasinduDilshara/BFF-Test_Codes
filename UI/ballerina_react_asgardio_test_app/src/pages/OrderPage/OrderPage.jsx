import React from 'react';
import { getOrdersQuery } from '../../handlers/api_handler/Constants';
import OrderItem from '../../components/OrderItem/OrderItem';
import { useQuery } from '@apollo/client';

export default function OrderPage() {
    const { loading, error, data } = useQuery(getOrdersQuery);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;
    console.log("DATA", data);

    return (
        loading ?
            <div>Loading...</div>
            :
            <div>
                <h1>Orders</h1>
                <ul>
                    {data.orders.map(item => (
                        <OrderItem item={item} />
                    ))}
                </ul>
            </div>
    );
}