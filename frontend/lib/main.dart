import 'package:flutter/material.dart';
import 'package:prestamos_app/views/clientes/cliente_form_page.dart';
import 'package:prestamos_app/views/prestamos/prestamo_form_page.dart';
import 'views/auth/login_page.dart';
import 'views/dashboard/dashboard_page.dart';
import 'views/clientes/clientes_page.dart';
import 'views/prestamos/prestamos_page.dart';
import 'views/pagos/pagos_page.dart';

void main() {
  runApp(PrestamosApp());
}

class PrestamosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Préstamos',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/clientes': (context) => ClientesPage(),
        '/prestamos': (context) => PrestamosPage(),
        '/pagos': (context) => PagosPage(),
        '/cliente_form': (context) => ClienteFormPage(),
        '/prestamo_form': (context) => PrestamoFormPage(),
      },
    );
  }
}

