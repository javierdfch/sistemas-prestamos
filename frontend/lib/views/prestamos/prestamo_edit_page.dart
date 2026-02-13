import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class PrestamoEditPage extends StatefulWidget {
  final Map prestamo;
  PrestamoEditPage({required this.prestamo});

  @override
  _PrestamoEditPageState createState() => _PrestamoEditPageState();
}

class _PrestamoEditPageState extends State<PrestamoEditPage> {
  final ApiService apiService = ApiService();

  late TextEditingController clienteIdController;
  late TextEditingController montoController;
  late TextEditingController cuotasController;
  late TextEditingController interesController;
  late TextEditingController fechaInicioController;

  @override
  void initState() {
    super.initState();
    clienteIdController = TextEditingController(text: widget.prestamo['cliente_id'].toString());
    montoController = TextEditingController(text: widget.prestamo['monto'].toString());
    cuotasController = TextEditingController(text: widget.prestamo['cuotas'].toString());
    interesController = TextEditingController(text: widget.prestamo['interes'].toString());
    fechaInicioController = TextEditingController(text: widget.prestamo['fecha_inicio']);
  }

  Future<void> actualizarPrestamo() async {
    final response = await apiService.updateData("prestamos", widget.prestamo['id'], {
      "cliente_id": clienteIdController.text,
      "monto": montoController.text,
      "cuotas": cuotasController.text,
      "interes": interesController.text,
      "fecha_inicio": fechaInicioController.text,
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Préstamo actualizado exitosamente")),
      );
      Navigator.pushReplacementNamed(context, '/prestamos');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar préstamo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Préstamo")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: clienteIdController,
                decoration: InputDecoration(labelText: "ID Cliente"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: montoController,
                decoration: InputDecoration(labelText: "Monto"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cuotasController,
                decoration: InputDecoration(labelText: "Número de cuotas"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: interesController,
                decoration: InputDecoration(labelText: "Interés (%)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: fechaInicioController,
                decoration: InputDecoration(labelText: "Fecha inicio (YYYY-MM-DD)"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: actualizarPrestamo,
                child: Text("Actualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}