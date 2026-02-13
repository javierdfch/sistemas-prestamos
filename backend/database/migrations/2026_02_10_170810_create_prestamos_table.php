<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('prestamos', function (Blueprint $table) {
            $table->id(); // bigint unsigned
            $table->unsignedBigInteger('cliente_id');
            $table->decimal('monto', 10, 2);
            $table->integer('cuotas');
            $table->decimal('interes', 5, 2);
            $table->date('fecha_inicio');
            $table->timestamps();

            $table->foreign('cliente_id')
                  ->references('id')
                  ->on('clientes')
                  ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('prestamos');
    }
};