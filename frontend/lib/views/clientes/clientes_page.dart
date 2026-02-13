import 'package:flutter/material.dart';
import 'package:prestamos_app/widgets/menu_drawer.dart';
import '../../services/api_service.dart';
import 'dart:convert';
import 'cliente_edit_page.dart';

class ClientesPage extends StatefulWidget {
  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final ApiService apiService = ApiService();
  List clientes = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clientes")),
      drawer: MenuDrawer(),
      body: clientes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                return ListTile(
                  title: Text(cliente['nombre']),
                  subtitle: Text(cliente['email']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final response = await apiService.deleteData("clientes", cliente['id']);
                      if (response.statusCode == 204) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Cliente eliminado")),
                        );
                        cargarClientes(); // refresca la lista
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClienteEditPage(cliente: cliente),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cliente_form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}