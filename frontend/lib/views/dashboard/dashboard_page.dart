import 'package:flutter/material.dart';
import 'package:prestamos_app/widgets/menu_drawer.dart';
import '../../services/api_service.dart';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiService apiService = ApiService();
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    cargarDashboard();
  }

  Future<void> cargarDashboard() async {
    final response = await apiService.getData("dashboard");
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      drawer: MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pago_form').then((_) {
            cargarDashboard(); // refresca al volver
          });
        },
        child: Icon(Icons.add),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetricCard(Icons.people, "Clientes",
                          data['clientes'].toString(), Colors.blue),
                      _buildMetricCard(Icons.assignment, "Préstamos activos",
                          data['prestamos_activos'].toString(), Colors.green),
                      _buildMetricCard(Icons.pending_actions, "Pagos pendientes",
                          "\$${data['pagos_pendientes']}", Colors.red),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Últimos pagos",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data['ultimos_pagos'].length,
                      itemBuilder: (context, index) {
                        final pago = data['ultimos_pagos'][index];
                        final clienteNombre = pago['cliente'] != null
                            ? pago['cliente']['nombre']
                            : 'Cliente desconocido';

                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.payment, color: Colors.orange),
                            title: Text("Cliente: $clienteNombre",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Monto: \$${pago['monto']}"),
                                Text("Fecha: ${pago['fecha_pago']}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMetricCard(
      IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 16, color: color)),
          ],
        ),
      ),
    );
  }
}