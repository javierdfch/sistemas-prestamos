<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\ClienteResource;

class PrestamoResource extends JsonResource
{
    public function toArray($request): array
    {
       return [
    'id' => $this->id,
    'cliente' => new ClienteResource($this->whenLoaded('cliente')),
    'monto' => $this->monto,
    'cuotas' => $this->cuotas, // este es el número de cuotas
    'interes' => $this->interes,
    'fecha_inicio' => $this->fecha_inicio,
    'created_at' => $this->created_at,
    'updated_at' => $this->updated_at,

    // relación con las cuotas generadas
    'cuotas_detalle' => CuotaResource::collection($this->whenLoaded('cuotas')),
];
    }
}