<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Prestamo extends Model
{
    protected $fillable = [
        'cliente_id',
        'monto',
        'cuotas',
        'interes',
        'fecha_inicio',
        'saldo_pendiente',
        'estado',
    ];

    // Relación: un préstamo pertenece a un cliente
    public function cliente()
    {
        return $this->belongsTo(Cliente::class);
    }

    // Relación: un préstamo tiene muchas cuotas
    public function cuotas()
    {
        return $this->hasMany(Cuota::class);
    }

    // Relación: un préstamo tiene muchos pagos
    public function pagos()
    {
        return $this->hasMany(Pago::class);
    }
}