import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ClienteEditPage extends StatefulWidget {
  final Map cliente;
  ClienteEditPage({required this.cliente});

  @override
  _ClienteEditPageState createState() => _ClienteEditPageState();
}

class _ClienteEditPageState extends State<ClienteEditPage> {
  final ApiService apiService = ApiService();
  late TextEditingController nombreController;
  late TextEditingController emailController;
  late TextEditingController documentoController;
  late TextEditingController telefonoController;
  late TextEditingController direccionController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.cliente['nombre']);
    emailController = TextEditingController(text: widget.cliente['email']);
    documentoController = TextEditingController(text: widget.cliente['documento']);
    telefonoController = TextEditingController(text: widget.cliente['telefono']);
    direccionController = TextEditingController(text: widget.cliente['direccion']);
  }

  Future<void> actualizarCliente() async {
    final response = await apiService.updateData("clientes", widget.cliente['id'], {
      "nombre": nombreController.text,
      "email": emailController.text,
      "documento": documentoController.text,
      "telefono": telefonoController.text,
      "direccion": direccionController.text,
      "activo": "1",
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cliente actualizado")),
      );
      Navigator.pushReplacementNamed(context, '/clientes');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Cliente")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: documentoController, decoration: InputDecoration(labelText: "Documento")),
            TextField(controller: telefonoController, decoration: InputDecoration(labelText: "Teléfono")),
            TextField(controller: direccionController, decoration: InputDecoration(labelText: "Dirección")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: actualizarCliente, child: Text("Actualizar")),
          ],
        ),
      ),
    );
  }
}