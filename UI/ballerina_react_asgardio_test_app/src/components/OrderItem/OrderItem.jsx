import { Grid } from "@mui/material";

export default function OrderItem({item}) {
    return (
        <Grid container spacing={2}>
            <Grid item xs={12} sm={6}>
                <h3>Order ID: {item.orderId}</h3>
                <p>Amount: {item.amount}</p>
                <p>Ship ID: {item.shipId}</p>
                <p>ETA: {item.eta}</p>
            </Grid>
        </Grid>
    );
}