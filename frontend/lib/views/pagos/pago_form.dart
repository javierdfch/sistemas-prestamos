import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class PagoFormPage extends StatefulWidget {
  @override
  _PagoFormPageState createState() => _PagoFormPageState();
}

class _PagoFormPageState extends State<PagoFormPage> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController prestamoIdController = TextEditingController();
  final TextEditingController cuotaIdController = TextEditingController();
  final TextEditingController montoController = TextEditingController();
  final TextEditingController fechaPagoController = TextEditingController();
  final TextEditingController metodoController = TextEditingController();

  bool isLoading = false;

  Future<void> registrarPago() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final data = {
        "prestamo_id": prestamoIdController.text,
        "cuota_id": cuotaIdController.text,
        "monto": montoController.text,
        "fecha_pago": fechaPagoController.text,
        "metodo": metodoController.text,
      };

      final response = await apiService.postData("pagos", data);

      setState(() => isLoading = false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pago registrado correctamente")),
        );
        Navigator.pop(context); // Regresa al dashboard
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al registrar el pago")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Pago")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: prestamoIdController,
                decoration: InputDecoration(labelText: "ID del préstamo"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: cuotaIdController,
                decoration: InputDecoration(labelText: "ID de la cuota"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: montoController,
                decoration: InputDecoration(labelText: "Monto"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: fechaPagoController,
                decoration: InputDecoration(labelText: "Fecha de pago (YYYY-MM-DD)"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              TextFormField(
                controller: metodoController,
                decoration: InputDecoration(labelText: "Método de pago"),
                validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : registrarPago,
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Registrar Pago"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}