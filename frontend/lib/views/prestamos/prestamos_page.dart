import 'package:flutter/material.dart';
import 'package:prestamos_app/views/prestamos/prestamo_edit_page.dart';
import 'package:prestamos_app/views/prestamos/prestamo_detail_page.dart';
import 'package:prestamos_app/widgets/menu_drawer.dart';
import '../../services/api_service.dart';
import 'dart:convert';

class PrestamosPage extends StatefulWidget {
  @override
  _PrestamosPageState createState() => _PrestamosPageState();
}

class _PrestamosPageState extends State<PrestamosPage> {
  final ApiService apiService = ApiService();
  List prestamos = [];

  @override
  void initState() {
    super.initState();
    cargarPrestamos();
  }

  Future<void> cargarPrestamos() async {
    final response = await apiService.getData("prestamos");
    if (response.statusCode == 200) {
      setState(() {
        prestamos = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Préstamos")),
      drawer: MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/prestamo_form').then((_) {
            cargarPrestamos(); // refresca al volver
          });
        },
        child: Icon(Icons.add),
      ),
      body: prestamos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: prestamos.length,
              itemBuilder: (context, index) {
                final prestamo = prestamos[index];
                final cuotas = prestamo['cuotas'] ?? [];

                // Calcular estadísticas
                final cuotasPagadas =
                    cuotas.where((c) => c['estado'] == 'pagada').length;
                final cuotasPendientes =
                    cuotas.where((c) => c['estado'] == 'pendiente').length;
                final cuotasParciales =
                    cuotas.where((c) => c['estado'] == 'parcial').length;

                // Calcular saldo pendiente con un for para evitar errores de tipo
                double saldoPendiente = 0.0;
                for (var c in cuotas) {
                  if (c['estado'] != 'pagada') {
                    saldoPendiente += double.tryParse(c['valor'].toString()) ?? 0.0;
                  }
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      "Cliente: ${prestamo['cliente']?['nombre'] ?? 'Sin cliente'}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Monto: \$${prestamo['monto']}"),
                        Text(
                          "Saldo pendiente: \$${saldoPendiente.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text("Cuotas pagadas: $cuotasPagadas",
                            style: TextStyle(color: Colors.green)),
                        Text("Cuotas parciales: $cuotasParciales",
                            style: TextStyle(color: Colors.orange)),
                        Text("Cuotas restantes: $cuotasPendientes",
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility, color: Colors.blue),
                          onPressed: () async {
                            final response = await apiService
                                .getData("prestamos/${prestamo['id']}");
                            if (response.statusCode == 200) {
                              final data = json.decode(response.body);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PrestamoDetailPage(prestamo: data),
                                ),
                              );
                              cargarPrestamos(); // refresca al volver
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PrestamoEditPage(prestamo: prestamo),
                              ),
                            );
                            cargarPrestamos(); // refresca al volver
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final response = await apiService.deleteData(
                                "prestamos", prestamo['id']);
                            if (response.statusCode == 200 ||
                                response.statusCode == 204) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Préstamo eliminado")),
                              );
                              cargarPrestamos();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}