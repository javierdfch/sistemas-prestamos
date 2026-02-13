<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('prestamo_id');
            $table->unsignedBigInteger('cuota_id')->nullable();
            $table->decimal('monto', 10, 2);
            $table->date('fecha_pago');
            $table->string('metodo')->nullable();
            $table->timestamps();

            $table->foreign('prestamo_id')
                  ->references('id')
                  ->on('prestamos')
                  ->onDelete('cascade');

            $table->foreign('cuota_id')
                  ->references('id')
                  ->on('cuotas')
                  ->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pagos');
    }
};