import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/routes/app_router.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  await dotenv.load(); // Cargar variables de entorno antes de correr la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      title: 'Academia Farfala',
      routerConfig: appRouter,
    );
  }
}

