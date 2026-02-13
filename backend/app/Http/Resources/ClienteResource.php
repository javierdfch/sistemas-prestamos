<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ClienteResource extends JsonResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'nombre' => $this->nombre,
            'email' => $this->email,
            'documento' => $this->documento,
            'telefono' => $this->telefono,
            'direccion' => $this->direccion,
            'activo' => (bool) $this->activo,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            // relaciones opcionales
            'prestamos' => PrestamoResource::collection($this->whenLoaded('prestamos')),
        ];
    }
}