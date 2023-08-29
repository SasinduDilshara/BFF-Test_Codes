import { TableRow, TableCell } from "@mui/material";
import React, { useState, useEffect } from "react";
import { wsConnectionUrl } from "../../handlers/api_handler/Constants";

export default function OrderItem({ row }) {
    const [message, setMessage] = useState("");
    const socket = new WebSocket(wsConnectionUrl + "?id=" + row.orderId.toString() + "&type=ORDER_TYPE");
  
    useEffect(() => {
      socket.addEventListener('message', event => {
        setMessage(event.data);
      });
    //   return () => {
    //     socket.close();
    //   };
    }, []);

    return (
        <TableRow
            key={row.orderId}
            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
        >
            <TableCell component="th" scope="row">
                {row.orderId}
            </TableCell>
            <TableCell align="right">{message == "" ? "---" : message}</TableCell>
            <TableCell align="right">{row.shipId == null ? "Not Assigned": row.shipId}</TableCell>
            <TableCell align="right">{row.eta}</TableCell>
            <TableCell align="right">{row.customerId}</TableCell>
        </TableRow>
    );
}