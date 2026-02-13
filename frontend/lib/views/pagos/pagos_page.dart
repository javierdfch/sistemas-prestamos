import 'package:flutter/material.dart';
import 'package:prestamos_app/widgets/menu_drawer.dart';
import '../../services/api_service.dart';
import 'dart:convert';

class PagosPage extends StatefulWidget {
  @override
  _PagosPageState createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final ApiService apiService = ApiService();
  List pagos = [];

  @override
  void initState() {
    super.initState();
    cargarPagos();
  }

  Future<void> cargarPagos() async {
    final response = await apiService.getData("pagos");
    if (response.statusCode == 200) {
      setState(() {
        pagos = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagos")),
      drawer: MenuDrawer(),
      body: pagos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pagos.length,
              itemBuilder: (context, index) {
                final pago = pagos[index];
                return ListTile(
                  title: Text(pago['monto'].toString()),
                  subtitle: Text(pago['fecha_pago']),
                );
              },
            ),
    );
  }
}