<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PrestamoFactory extends Factory
{
    protected $model = \App\Models\Prestamo::class;

    public function definition()
    {
        $monto = $this->faker->randomFloat(2, 100000, 1000000);
        $cuotas = $this->faker->numberBetween(6, 36);
        $interes = $this->faker->randomFloat(2, 1, 20);

        return [
            'cliente_id' => \App\Models\Cliente::factory(),
            'monto' => $monto,
            'cuotas' => $cuotas,
            'interes' => $interes,
            'fecha_inicio' => $this->faker->dateTimeBetween('-1 year', 'now')->format('Y-m-d'),
        ];
    }
}