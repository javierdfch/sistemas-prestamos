import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ClienteFormPage extends StatefulWidget {
  @override
  _ClienteFormPageState createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends State<ClienteFormPage> {
  final ApiService apiService = ApiService();
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final documentoController = TextEditingController();
  final telefonoController = TextEditingController();
  final direccionController = TextEditingController();

  Future<void> guardarCliente() async {
    final response = await apiService.createData("clientes", {
      "nombre": nombreController.text,
      "email": emailController.text,
      "telefono": telefonoController.text,
      "documento": documentoController.text,
      "direccion": direccionController.text,
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cliente creado exitosamente")),
      );
      Navigator.pushReplacementNamed(context, '/clientes');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al crear cliente")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo Cliente")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
             TextField(
              controller: documentoController,
              decoration: InputDecoration(labelText: "Documento"),
            ),
            TextField(
              controller: telefonoController,
              decoration: InputDecoration(labelText: "Teléfono"),
            ),
             TextField(
              controller: direccionController,
              decoration: InputDecoration(labelText: "Dirección"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardarCliente,
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}