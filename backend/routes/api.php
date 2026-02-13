<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ClienteController;
use App\Http\Controllers\Api\CuotaController;
use App\Http\Controllers\Api\PagoController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PrestamoController;
use App\Http\Controllers\Api\DashboardController;



//publicas(login)
Route::put('cuotas/{cuota}/pagar', [CuotaController::class, 'pagar']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/dashboard', [DashboardController::class, 'index']);
Route::get('/clientes', [ClienteController::class, 'index']);
    Route::get('/prestamos', [PrestamoController::class, 'index']);
    Route::get('/pagos', [PagoController::class, 'index']);
    Route::apiResource('clientes', ClienteController::class);
     Route::apiResource('prestamos', PrestamoController::class);
     Route::apiResource('cuotas', CuotaController::class);
     Route::apiResource('pagos', PagoController::class);
     Route::apiResource('clientes.prestamos', PrestamoController::class);
Route::middleware('auth:sanctum')->group(function () {
Route::get('/user', [AuthController::class, 'user']);
Route::post('/logout', [AuthController::class, 'logout']);
     
});

// //rutas protegidas(requiere token)
// Route::middleware('auth:sanctum')->group(function () {
//     Route::post('/logout', [AuthController::class, 'logout']);
   
//     //Route::get('/dashboard', [DashboardController::class, 'index']);
// });

// //Rutas
// Route::middleware('auth:sanctum')->group(function () {
    
//     //Route::get('/dashboard', [DashboardController::class, 'index']);
// });

// Route::apiResource('prestamos', PrestamoController::class);
// Route::apiResource('clientes', ClienteController::class);
// Route::apiResource('cuotas', CuotaController::class);
// Route::apiResource('pagos', PagoController::class);
// Route::apiResource('clientes.prestamos', PrestamoController::class);

Route::middleware(['json.api'])->group(function () {
    Route::get('/user', [UserController::class, 'index']);
});
