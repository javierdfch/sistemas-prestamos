<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cuotas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('prestamo_id');
            $table->integer('numero');
            $table->date('fecha_vencimiento');
            $table->decimal('valor', 10, 2);
            $table->string('estado')->default('pendiente');
            $table->timestamps();

            $table->foreign('prestamo_id')
                  ->references('id')
                  ->on('prestamos')
                  ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cuotas');
    }
};