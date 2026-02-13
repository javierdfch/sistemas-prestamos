<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Prestamo;
use Illuminate\Http\Request;
use App\Services\PrestamoService;
use App\Http\Resources\ClienteResource;
use App\Http\Resources\CuotaResource;
use App\Http\Resources\PrestamoResource;

class PrestamoController extends Controller
{
    public function index()
    {
        //return Prestamo::all();
        return Prestamo::with('cliente','cuotas')->get();
    }

   public function store(Request $request)
    {   
    $data = $request->validate([
        'cliente_id' => 'required|exists:clientes,id',
        'monto' => 'required|numeric|min:0',
        'cuotas' => 'required|integer|min:1',
        'interes' => 'required|numeric|min:0',
        'fecha_inicio' => 'required|date',
    ]);

    $prestamo = Prestamo::create($data);

    // calcular valor de cada cuota
    $valorCuota = PrestamoService::calcularCuota(
        $data['monto'],
        $data['interes'],
        $data['cuotas']
    );

    // generar cuotas automáticamente
    for ($i = 1; $i <= $data['cuotas']; $i++) {
        $fecha = \Carbon\Carbon::parse($data['fecha_inicio'])->addMonths($i);
        $prestamo->cuotas()->create([
            'numero' => $i,
            'fecha_vencimiento' => $fecha,
            'valor' => $valorCuota,
            'estado' => 'pendiente',
        ]);
    }
     return response()->json($prestamo->load('cuotas','cliente'));
   // return new PrestamoResource($prestamo->load('cuotas','cliente'));
    }

    public function show(Prestamo $prestamo)
{
    return response()->json($prestamo->load('cliente','cuotas'));
}

    // public function update(Request $request, $id)
    // {
    //     $prestamo = Prestamo::findOrFail($id);

    //     $data = $request->validate([
    //         'cliente_id'   => 'required|exists:clientes,id',
    //         'monto'        => 'required|numeric|min:1',
    //         'cuotas'       => 'required|integer|min:1',
    //         'interes'      => 'required|numeric|min:0',
    //         'fecha_inicio' => 'required|date',
    //     ]);

    //     $prestamo->update($data);

    //     return $prestamo;
    // }

    public function update(Request $request, $id)
{
    $prestamo = Prestamo::findOrFail($id);

    $data = $request->validate([
        'cliente_id'   => 'required|exists:clientes,id',
        'monto'        => 'required|numeric|min:1',
        'cuotas'       => 'required|integer|min:1',
        'interes'      => 'required|numeric|min:0',
        'fecha_inicio' => 'required|date',
    ]);

    $prestamo->update($data);

    return $this->formatPrestamoResponse($prestamo->load('cliente','cuotas'));
}
private function formatPrestamoResponse($prestamo)
{
    return response()->json([
        'id' => $prestamo->id,
        'cliente_id' => $prestamo->cliente_id,
        'monto' => $prestamo->monto,
        'numero_cuotas' => $prestamo->cuotas()->count(),
        'interes' => $prestamo->interes,
        'fecha_inicio' => $prestamo->fecha_inicio,
        'estado' => $prestamo->estado,
        'saldo_pendiente' => $prestamo->saldo_pendiente,
        'cliente' => [
            'id' => $prestamo->cliente->id,
            'nombre' => $prestamo->cliente->nombre,
        ],
        'cuotas' => $prestamo->cuotas->map(function($cuota){
            return [
                'id' => $cuota->id,
                'numero' => $cuota->numero,
                'fecha_vencimiento' => $cuota->fecha_vencimiento,
                'valor' => $cuota->valor,
                'estado' => $cuota->estado,
            ];
        }),
    ]);
}



    public function destroy($id)
    {
        $prestamo = Prestamo::findOrFail($id);
        $prestamo->delete();

        return response()->json([
            'message' => 'Préstamo eliminado correctamente'
        ]);
    }
}