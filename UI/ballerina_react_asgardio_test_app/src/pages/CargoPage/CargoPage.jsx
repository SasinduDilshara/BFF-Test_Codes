import React from 'react';
import { getCargosQuery } from '../../handlers/api_handler/Constants';
import CargoItem from '../../components/CargoItem/CargoItem';
import { useQuery } from '@apollo/client';

export default function CargoPage() {
    const { loading, error, data } = useQuery(getCargosQuery);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;
    console.log("DATA", data);

    return (
        loading ?
            <div>Loading...</div>
            :
            <div>
                <h1>Cargos</h1>
                <ul>
                    {data.cargos.map(item => (
                        <CargoItem item={item} />
                    ))}
                </ul>
            </div>
    );
}