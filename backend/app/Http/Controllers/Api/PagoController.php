<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pago;
use App\Models\Cuota;
use App\Models\Prestamo;
use App\Models\Cliente;
use Illuminate\Http\Request;

class PagoController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->validate([
            'prestamo_id' => 'required|exists:prestamos,id',
            'cuota_id' => 'required|exists:cuotas,id',
            'monto' => 'required|numeric|min:0',
            'fecha_pago' => 'required|date',
            'metodo' => 'required|string',
        ]);

        // Registrar el pago
        $pago = Pago::create($data);

        // Actualizar estado de la cuota
        $cuota = Cuota::findOrFail($data['cuota_id']);
        if ($data['monto'] >= $cuota->valor) {
            $cuota->estado = 'pagada';
        } else {
            $cuota->estado = 'parcial';
        }
        $cuota->save();

        // Actualizar saldo pendiente del préstamo
        $prestamo = $pago->prestamo;
        $prestamo->saldo_pendiente = $prestamo->cuotas()
            ->where('estado', 'pendiente')
            ->sum('valor');

        if ($prestamo->saldo_pendiente <= 0) {
            $prestamo->estado = 'pagado';
        }
        $prestamo->save();

        // 🔹 Construir respuesta del dashboard directamente
        $clientes = Cliente::count();
        $prestamosActivos = Prestamo::where('estado', 'activo')->count();
        $pagosPendientes = Cuota::whereIn('estado', ['pendiente', 'parcial'])->sum('valor');

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
            'message' => 'Pago registrado correctamente',
            'dashboard' => [
                'clientes' => $clientes,
                'prestamos_activos' => $prestamosActivos,
                'pagos_pendientes' => $pagosPendientes,
                'ultimos_pagos' => $ultimosPagos
            ]
        ], 201);
    }
}