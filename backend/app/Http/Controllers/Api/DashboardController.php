<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cliente;
use App\Models\Prestamo;
use App\Models\Pago;
use App\Models\Cuota;

class DashboardController extends Controller
{
    public function index()
    {
        // Total de clientes
        $clientes = Cliente::count();

        // Préstamos activos
        $prestamosActivos = Prestamo::where('estado', 'activo')->count();

        // Pagos pendientes: sumar todas las cuotas con estado pendiente o parcial
        $pagosPendientes = Cuota::whereIn('estado', ['pendiente', 'parcial'])
            ->sum('valor');

        // Últimos pagos con cliente incluido
        $ultimosPagos = Pago::with('prestamo.cliente')
            ->orderBy('fecha_pago', 'desc')
            ->take(5)
            ->get()
            ->map(function ($pago) {
                return [
                    'monto' => $pago->monto,
                    'fecha_pago' => $pago->fecha_pago,
                    'cliente' => [
                        'id' => $pago->prestamo->cliente->id ?? null,
                        'nombre' => $pago->prestamo->cliente->nombre ?? 'Sin nombre'
                    ]
                ];
            });

        return response()->json([
            'clientes' => $clientes,
            'prestamos_activos' => $prestamosActivos,
            'pagos_pendientes' => $pagosPendientes,
            'ultimos_pagos' => $ultimosPagos
        ]);
    }
}