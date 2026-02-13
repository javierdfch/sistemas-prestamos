<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cuota;
use Illuminate\Http\Request;

class CuotaController extends Controller
{
    public function index()
    {
        return Cuota::all();
        // return response()->json(Cuota::with('prestamo')->paginate(20));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'prestamo_id' => 'required|exists:prestamos,id',
            'numero' => 'required|integer|min:1',
            'fecha_vencimiento' => 'required|date',
            'valor' => 'required|numeric|min:0',
            'estado' => 'sometimes|string',
        ]);

        $cuota = Cuota::create($data);

        return response()->json($cuota->load('prestamo'), 201);
    }

    public function show(Cuota $cuota)
    {
        return response()->json($cuota->load('pagos','prestamo'));
    }

    public function update(Request $request, Cuota $cuota)
    {
        $data = $request->validate([
            'numero' => 'sometimes|required|integer|min:1',
            'fecha_vencimiento' => 'sometimes|required|date',
            'valor' => 'sometimes|required|numeric|min:0',
            'estado' => 'sometimes|string',
        ]);

        $cuota->update($data);

        return response()->json($cuota);
    }

    public function destroy(Cuota $cuota)
    {
        $cuota->delete();
        return response()->json(null, 204);
    }
    public function pagar(Cuota $cuota)
    {
    $cuota->estado = 'pagada';
    $cuota->save();

    return response()->json([
        'message' => 'Cuota marcada como pagada',
        'cuota' => $cuota
    ], 200);
}
}