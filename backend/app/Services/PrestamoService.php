<?php

namespace App\Services;

class PrestamoService
{
    /**
     * Calcular el valor de la cuota mensual usando sistema francés.
     *
     * @param float $monto        Monto total del préstamo
     * @param float $interesAnual Interés anual en porcentaje (ej: 12 para 12%)
     * @param int   $numCuotas    Número de cuotas
     * @return float
     */
    public static function calcularCuota($monto, $interesAnual, $numCuotas)
    {
        $i = $interesAnual / 100 / 12; // interés mensual en decimal
        $n = $numCuotas;

        if ($i == 0) {
            return round($monto / $n, 2);
        }

        $cuota = $monto * ($i / (1 - pow(1 + $i, -$n)));
        return round($cuota, 2);
    }
}