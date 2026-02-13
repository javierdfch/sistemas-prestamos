<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class CuotaResource extends JsonResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'prestamo_id' => $this->prestamo_id,
            'numero' => $this->numero,
            'fecha_vencimiento' => $this->fecha_vencimiento,
            'valor' => $this->valor,
            'estado' => $this->estado,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}