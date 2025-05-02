import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/auth/login_page.dart';
import 'package:hola_mundo/views/auth/register_page.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_list_view.dart';

// Vistas generales
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/provider/change_theme_view.dart';
import 'package:hola_mundo/views/settings_view.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart';
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:hola_mundo/views/future/future_view.dart';
import 'package:hola_mundo/views/timer/timer_view.dart';
import 'package:hola_mundo/views/isolate/isolate_view.dart';

// Vistas de perros
import 'package:hola_mundo/views/dog/dog_list_view.dart';
import 'package:hola_mundo/views/dog/dog_detail_view.dart' as dogDetail;

// Vistas de establecimientos
import 'package:hola_mundo/views/establecimientos/establecimiento_edit_view.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_create_views.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Home y generales
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(),
    ),

    // Paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    GoRoute(
      path: '/detalle/:parametro/:metodo',
      builder: (context, state) {
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),

    // Otros ejemplos
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    GoRoute(
      path: '/timer',
      name: 'timerView',
      builder: (context, state) => const TimerView(),
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),

    // Perros
    GoRoute(
      name: 'dogListView',
      path: '/dogs',
      builder: (context, state) => const DogListView(),
    ),
    GoRoute(
      name: 'dogDetailView',
      path: '/dog/:breed',
      builder: (context, state) {
        final breed = state.pathParameters['breed']!;
        return dogDetail.DogDetailView(breed: breed);
      },
    ),

    // Establecimientos
    GoRoute(
      path: '/establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    GoRoute(
      path: '/establecimientos',
      name: 'establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    //!Ruta para editar de un establecimiento
    GoRoute(
      path: '/establecimientos/edit/:id',
      builder: (context, state) {
        //*se captura el id del establecimiento
        final id = int.parse(state.pathParameters['id']!);
        return EstablecimientoEditView(id: id);
      },
    ),
    GoRoute(
      path: '/establecimientos/create',
      builder: (context, state) => const EstablecimientoCreateView(),
),
    //!Ruta para autenticacion
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
     //!Ruta para el demo de Provider
    GoRoute(
      path: '/cambiar-tema',
      name: 'cambiar-tema',
      builder: (context, state) => const ChangeThemeView(),
    ),
  ],
);
