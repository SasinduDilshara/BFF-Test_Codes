import { TableRow, TableCell } from "@mui/material";

export default function CargoItem({ row }) {
    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {row.cargoId}
            </TableCell>
            <TableCell align="right">{row.eta}</TableCell>
            <TableCell align="right">{row.startFrom}</TableCell>
            <TableCell align="right">{row.volume}</TableCell>
            <TableCell align="right">{row.endFrom}</TableCell>
            <TableCell align="right">{row.status}</TableCell>
        </TableRow>
    );
}