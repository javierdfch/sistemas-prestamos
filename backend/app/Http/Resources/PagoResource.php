<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\PrestamoResource;

class PagoResource extends JsonResource
{
   public function toArray($request)
{
    return [
        'id' => $this->id,
        'prestamo_id' => $this->prestamo_id,
        'cuota_id' => $this->cuota_id,
        'monto' => $this->monto,
        'fecha_pago' => $this->fecha_pago,
        'metodo' => $this->metodo,
        'prestamo' => [
            'id' => $this->prestamo->id,
            'saldo_pendiente' => $this->prestamo->saldo_pendiente,
            'estado' => $this->prestamo->estado,
        ],
        'cuota' => [
            'id' => $this->cuota->id,
            'numero' => $this->cuota->numero,
            'valor' => $this->cuota->valor,
            'estado' => $this->cuota->estado,
        ],
    ];
}
}