import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/api_service.dart';

class PrestamoDetailPage extends StatefulWidget {
  final Map prestamo;
  PrestamoDetailPage({required this.prestamo});

  @override
  _PrestamoDetailPageState createState() => _PrestamoDetailPageState();
}

class _PrestamoDetailPageState extends State<PrestamoDetailPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final cuotas = widget.prestamo['cuotas'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Detalle Préstamo")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cliente: ${widget.prestamo['cliente']['nombre']}"),
            Text("Monto: \$${widget.prestamo['monto']}"),
            Text("Interés: ${widget.prestamo['interes']}%"),
            Text("Fecha inicio: ${widget.prestamo['fecha_inicio']}"),
            SizedBox(height: 20),
            Text("Cuotas generadas:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: cuotas.length,
                itemBuilder: (context, index) {
                  final cuota = cuotas[index];
                  return ListTile(
                    title: Text("Cuota #${cuota['numero']} - \$${cuota['valor']}"),
                    subtitle: Text("Vence: ${cuota['fecha_vencimiento']}"),
                    trailing: cuota['estado'] == 'pendiente'
                        ? ElevatedButton(
                            onPressed: () async {
                              final response = await apiService.updateData(
                                "cuotas/${cuota['id']}/pagar",
                                {},
                                {},
                              );
                              if (response.statusCode == 200) {
                                setState(() {
                                  cuota['estado'] = 'pagada';
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Cuota marcada como pagada")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error al marcar cuota")),
                                );
                              }
                            },
                            child: Text("Pagar"),
                          )
                        : Text("Pagada", style: TextStyle(color: Colors.green)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}