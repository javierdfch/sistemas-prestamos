Sistema de Préstamos

Proyecto completo con Laravel (backend) y Flutter (frontend) para la gestión de préstamos, clientes y cuotas.

🚀 Backend (Laravel)

Requisitos

PHP >= 8.1

Composer

MySQL

Instalación

cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve

Endpoints principales

GET /api/prestamos → Listar préstamos

POST /api/prestamos → Crear préstamo

GET /api/prestamos/{id} → Ver detalle de préstamo

PUT /api/prestamos/{id} → Actualizar préstamo

DELETE /api/prestamos/{id} → Eliminar préstamo

📱 Frontend (Flutter)

Requisitos

Flutter SDK >= 3.0

Android Studio o VS Code

Instalación

cd frontend
flutter pub get
flutter run

Funcionalidades

Pantalla de inicio con listado de préstamos

Detalle de préstamo con cuotas

Edición y actualización de datos

Integración con API Laravel

⚙️ Estructura del proyecto

sistema-prestamos/
├── backend/   # Proyecto Laravel
├── frontend/  # Proyecto Flutter
└── README.md

🛠️ Desarrollo

Usa ramas de trabajo (desarrollo) para nuevas funcionalidades.

Haz git pull antes de comenzar a trabajar.

Documenta cambios en commits claros.

📄 Licencia

Este proyecto es de uso libre para fines educativos y de aprendizaje.
