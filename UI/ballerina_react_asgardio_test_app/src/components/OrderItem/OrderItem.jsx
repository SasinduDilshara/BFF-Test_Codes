import { TableRow, TableCell } from "@mui/material";

export default function OrderItem({ row }) {
    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {row.orderId}
            </TableCell>
            <TableCell align="right">{row.status}</TableCell>
            <TableCell align="right">{row.shipId}</TableCell>
            <TableCell align="right">{row.eta}</TableCell>
            <TableCell align="right">{row.customerId}</TableCell>
        </TableRow>
    );
}