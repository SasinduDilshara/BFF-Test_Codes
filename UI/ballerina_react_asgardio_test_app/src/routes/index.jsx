import React from 'react';
import { BrowserRouter, Route, Routes, Router } from 'react-router-dom';
import HomePage from '../pages/HomePage/HomePage';
import CargoPage from '../pages/CargoPage/CargoPage';
import OrderPage from '../pages/OrderPage/OrderPage';
import CreateOrderPage from '../pages/OrderPage/CreateOrderPage';

export default function CustomRouter() {
    return (
        <BrowserRouter>
            <Routes>
                <Route exact path="/" element={<HomePage />} />
                <Route path="/orders" element={<OrderPage />} />
                <Route path="/create-order" element={<CreateOrderPage />} />
                <Route path="/cargos" element={<CargoPage />} />
            </Routes>
        </BrowserRouter>
    );
}