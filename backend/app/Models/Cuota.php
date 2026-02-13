<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cuota extends Model
{
    // Campos que se pueden asignar masivamente
    protected $fillable = [
        'prestamo_id',
        'numero',
        'fecha_vencimiento',
        'valor',
        'estado',
    ];

    // Relación: una cuota pertenece a un préstamo
    public function prestamo()
    {
        return $this->belongsTo(Prestamo::class);
    }

    // Relación: una cuota puede tener muchos pagos
    public function pagos()
    {
        return $this->hasMany(Pago::class);
    }
}