<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PagoFactory extends Factory
{
    protected $model = \App\Models\Pago::class;

    public function definition()
    {
        return [
            'prestamo_id' => \App\Models\Prestamo::factory(),
            'cuota_id' => null,
            'monto' => $this->faker->randomFloat(2, 100, 50000),
            'fecha_pago' => $this->faker->dateTimeBetween('-6 months', 'now')->format('Y-m-d'),
            'metodo' => $this->faker->randomElement(['efectivo', 'transferencia', 'tarjeta']),
        ];
    }
}