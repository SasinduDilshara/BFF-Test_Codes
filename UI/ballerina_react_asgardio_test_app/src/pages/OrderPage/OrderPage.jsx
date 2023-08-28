import React from 'react';
import { getAPI, getGraphQLAPI } from '../../handlers/api_handler/ApiHandler';
import { getOrdersUrl, getOrdersQuery } from '../../handlers/api_handler/Constants';
import OrderItem from '../../components/OrderItem/OrderItem';

export default function OrderPage() {
    const [data, setData] = useState([]);
    const [loading, isLoading] = useState(false);

    useEffect(() => {
        isLoading(true);
        async function fetchData() {
            try {
                const response = await getGraphQLAPI(getOrdersUrl, getOrdersQuery);
                setData(response.data);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        }
        fetchData();
        isLoading(false);
    }, []);

    return (
        loading ?
            <div>Loading...</div>
            :
            <div>
                <h1>Data from API</h1>
                <ul>
                    {data.map(item => (
                        <OrderItem item={item} />
                    ))}
                </ul>
            </div>
    );
}