<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class ClienteFactory extends Factory
{
    protected $model = \App\Models\Cliente::class;

    public function definition()
    {
        return [
            'nombre' => $this->faker->name(),
            'email' => $this->faker->unique()->safeEmail(),
            'documento' => $this->faker->unique()->bothify('#########'),
            'telefono' => $this->faker->optional()->phoneNumber(),
            'direccion' => $this->faker->optional()->address(),
            'activo' => $this->faker->boolean(85),
        ];
    }
}