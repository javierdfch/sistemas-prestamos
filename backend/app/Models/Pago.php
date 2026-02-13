<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    use HasFactory;

    protected $fillable = [
        'prestamo_id',
        'cuota_id',
        'monto',
        'fecha_pago',
        'metodo',
    ];

    protected $casts = [
        'fecha_pago' => 'date',
        'monto' => 'decimal:2',
    ];

    public function prestamo()
{
    return $this->belongsTo(Prestamo::class);
}

public function cuota()
{
    return $this->belongsTo(Cuota::class);
}
}