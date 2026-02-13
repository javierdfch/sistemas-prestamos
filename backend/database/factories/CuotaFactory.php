<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class CuotaFactory extends Factory
{
    protected $model = \App\Models\Cuota::class;

    public function definition()
    {
        return [
            'prestamo_id' => \App\Models\Prestamo::factory(),
            'numero' => 1,
            'fecha_vencimiento' => $this->faker->dateTimeBetween('+1 month', '+12 months')->format('Y-m-d'),
            'valor' => $this->faker->randomFloat(2, 1000, 50000),
            'estado' => 'pendiente',
        ];
    }
}