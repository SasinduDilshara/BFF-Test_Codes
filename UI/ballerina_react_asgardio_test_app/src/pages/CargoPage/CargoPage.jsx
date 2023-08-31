import React from 'react';
import { getCargosQuery } from '../../handlers/api_handler/Constants';
import CargoItem from '../../components/CargoItem/CargoItem';
import { useQuery } from '@apollo/client';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

export default function CargoPage() {
    const { loading, error, data } = useQuery(getCargosQuery);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;
    console.log("DATA", data);

    return (
        loading ?
            <div>Loading...</div>
            :
            <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                    <TableRow>
                        <TableCell>Cargo Id</TableCell>
                        <TableCell align="right">Estimated Time</TableCell>
                        <TableCell align="right">startFrom</TableCell>
                        <TableCell align="right">volume Time Arrival</TableCell>
                        <TableCell align="right">End From</TableCell>
                        <TableCell align="right">Location</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.cargos.map((row) => (
                        <CargoItem row={row} />
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
    );
}