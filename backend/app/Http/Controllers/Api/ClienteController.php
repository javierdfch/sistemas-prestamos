<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cliente;
use Illuminate\Http\Request;
use App\Http\Resources\ClienteResource;


class ClienteController extends Controller
{
    public function index()
{
    return Cliente::all();
    //return ClienteResource::collection(Cliente::paginate(15));
}


    public function store(Request $request)
    {
        $data = $request->validate([
            'nombre' => 'required|string|max:255',
            'email' => 'required|email|unique:clientes,email',
            'documento' => 'required|string|unique:clientes,documento',
            'telefono' => 'nullable|string',
            'direccion' => 'nullable|string',
            'activo' => 'sometimes|boolean',
        ]);

        $cliente = Cliente::create($data);

        return response()->json($cliente, 201);
    }

    public function show(Cliente $cliente)
{
    return new ClienteResource($cliente->load('prestamos'));
}


    public function update(Request $request, Cliente $cliente)
    {
        $data = $request->validate([
            'nombre' => 'sometimes|required|string|max:255',
            'email' => 'sometimes|required|email|unique:clientes,email,' . $cliente->id,
            'documento' => 'sometimes|required|string|unique:clientes,documento,' . $cliente->id,
            'telefono' => 'nullable|string',
            'direccion' => 'nullable|string',
            'activo' => 'sometimes|boolean',
        ]);

        $cliente->update($data);

        return response()->json($cliente);
    }

    public function destroy(Cliente $cliente)
    {
        $cliente->delete();
        return response()->json(null, 204);
    }
}