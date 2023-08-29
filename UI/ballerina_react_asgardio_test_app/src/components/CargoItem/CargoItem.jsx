export default function CargoItem({item}) {
    return (
        <li key={item.cargoId}>{item.cargoId},{item.etaa},{item.startFrom},{item.volume},{item.endFrom}</li>
    );
}