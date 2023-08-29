import * as React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { getOrdersQuery } from '../../handlers/api_handler/Constants';
import OrderItem from '../../components/OrderItem/OrderItem';
import { useQuery } from '@apollo/client';

export default function BasicTable() {
    const { loading, error, data } = useQuery(getOrdersQuery);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;
    console.log("DATA", data);

    return (
        loading ? <div>Loading...</div> :
        <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                    <TableRow>
                        <TableCell>Order Id</TableCell>
                        <TableCell align="right">Status</TableCell>
                        <TableCell align="right">ShipId</TableCell>
                        <TableCell align="right">Estimated Time Arrival</TableCell>
                        <TableCell align="right">CustomerId</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.orders.map((row) => (
                        <OrderItem row={row} />
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
    );
}
