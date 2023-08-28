export default function CargoItem({item}) {
    return (
        <li key={item.orderId}>{item.orderId},{item.amount},{item.shipId},{item.eta}</li>
    );
}