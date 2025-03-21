import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart';
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(), // Usa HomeView
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(), // Usa SettingsView
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(), // Usa ProfileView
    ),

    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
  ],
);
