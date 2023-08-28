export default function OrderItem({item}) {
    return (
        <li key={item.orderId}>{item.orderId},{item.amount},{item.shipId},{item.eta}</li>
    );
}