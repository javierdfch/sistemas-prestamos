<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
{
    Schema::table('prestamos', function (Blueprint $table) {
        $table->decimal('saldo_pendiente', 10, 2)->default(0);
        $table->string('estado')->default('activo');
    });
}

public function down(): void
{
    Schema::table('prestamos', function (Blueprint $table) {
        $table->dropColumn(['saldo_pendiente', 'estado']);
    });
}
};
