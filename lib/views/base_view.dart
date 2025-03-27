import 'package:flutter/material.dart';
import 'custom_drawer.dart'; // Importa el Drawer personalizado

class BaseView extends StatelessWidget {
  final String title;
  final Widget body; // Cuerpo de la vista
  final int initialIndex; // Índice inicial para el BottomNavigationBar
  final int length; // Longitud de la lista de rutas

  const BaseView({super.key, required this.title, required this.body, required this.initialIndex, required this.length});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.red,),
      drawer: const CustomDrawer(), // Drawer persistente para todas las vistas
      body: body,
    );
  }
}
