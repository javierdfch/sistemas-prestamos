import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/api_service.dart';
import 'prestamo_detail_page.dart';

class PrestamoFormPage extends StatefulWidget {
  @override
  _PrestamoFormPageState createState() => _PrestamoFormPageState();
}

class _PrestamoFormPageState extends State<PrestamoFormPage> {
  final ApiService apiService = ApiService();

  // Controladores para los campos
  final montoController = TextEditingController();
  final cuotasController = TextEditingController();
  final interesController = TextEditingController();
  final fechaInicioController = TextEditingController();

  // Lista de clientes y selección
  List clientes = [];
  String? clienteSeleccionado;

  @override
  void initState() {
    super.initState();
    cargarClientes();
  }

  Future<void> cargarClientes() async {
    final response = await apiService.getData("clientes");
    if (response.statusCode == 200) {
      setState(() {
        clientes = json.decode(response.body);
      });
    }
  }

  Future<void> guardarPrestamo() async {
    final response = await apiService.createData("prestamos", {
      "cliente_id": clienteSeleccionado,
      "monto": montoController.text,
      "cuotas": cuotasController.text,
      "interes": interesController.text,
      "fecha_inicio": fechaInicioController.text,
    });

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PrestamoDetailPage(prestamo: data),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar préstamo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo Préstamo")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dropdown de clientes
              DropdownButtonFormField<String>(
                value: clienteSeleccionado,
                decoration: InputDecoration(labelText: "Cliente"),
                items: clientes.map<DropdownMenuItem<String>>((cliente) {
                  return DropdownMenuItem<String>(
                    value: cliente['id'].toString(),
                    child: Text(cliente['nombre']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    clienteSeleccionado = value;
                  });
                },
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
              // Campo de fecha con calendario
              TextField(
                controller: fechaInicioController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Fecha inicio",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    setState(() {
                      fechaInicioController.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarPrestamo,
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}