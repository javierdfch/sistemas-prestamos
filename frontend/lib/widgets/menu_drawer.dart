import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Clientes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/clientes');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Préstamos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/prestamos');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pagos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pagos');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Salir'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}