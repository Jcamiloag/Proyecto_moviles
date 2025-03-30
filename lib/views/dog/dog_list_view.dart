import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/dog.dart';
import 'package:hola_mundo/services/dog_services.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

class DogService {
  final String apiUrl = dotenv.env['DOG_API_URL']!; // Cargar la URL de la API desde las variables de entorno

  Future<Dog> getRandomDog() async { //* Método para obtener una imagen aleatoria de un perro
    try {
      final response = await http.get(Uri.parse('$apiUrl/breeds/image/random')); // Llamada a la API para obtener una imagen aleatoria
      if (response.statusCode == 200) { // Verificar si la respuesta es exitosa (código 200)
        final data = json.decode(response.body); // Decodificar la respuesta JSON
        return Dog.fromJson(data, 'random'); //* Crear un objeto Dog a partir de la respuesta JSON
      } else {
        throw Exception('No se pudo obtener la imagen del perro. Intenta nuevamente.'); // Manejo de errores si la respuesta no es exitosa
      }
    } catch (e) {
      throw Exception('Error de conexión. Verifica tu internet.'); // Manejo de errores si hay un problema de conexión
    }
  }

  Future<List<Dog>> getDogsByBreed(String breed) async {//* Método para obtener una lista de imágenes de una raza específica
    try {
      final response = await http.get(Uri.parse('$apiUrl/breed/$breed/images')); // Llamada a la API para obtener imágenes de una raza específica
      if (response.statusCode == 200) { // Verificar si la respuesta es exitosa (código 200)
        final data = json.decode(response.body);
        final List images = data['message'];
        return images.map((image) => Dog.fromJson({'message': image}, breed)).toList(); // Crear una lista de objetos Dog a partir de la respuesta JSON
      } else {
        throw Exception('No se pudieron obtener imágenes de la raza $breed.'); // Manejo de errores si la respuesta no es exitosa
      }
    } catch (e) {
      throw Exception('Error de conexión. Verifica tu internet.'); // Manejo de errores si hay un problema de conexión
    }
  }

  Future<String> getRandomImageByBreed(String breed) async { //* Método para obtener una imagen aleatoria de una raza específica
    try {
      final response = await http.get(Uri.parse('$apiUrl/breed/$breed/images/random')); // Llamada a la API para obtener una imagen aleatoria de una raza específica
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        throw Exception('No se pudo obtener la imagen de la raza $breed.'); // Manejo de errores si la respuesta no es exitosa
      }
    } catch (e) {
      throw Exception('Error de conexión. Verifica tu internet.');
    }
  }

  Future<List<String>> getAllBreeds() async {
    return Future.delayed(const Duration(seconds: 5), () async { //* Simular una carga de 5 segundos antes de obtener la lista de razas
      try {
        final response = await http.get(Uri.parse('$apiUrl/breeds/list/all')); // Llamada a la API para obtener la lista de razas
        if (response.statusCode == 200) {
          final data = json.decode(response.body); // Decodificar la respuesta JSON
          final Map<String, dynamic> breedsMap = data['message']; // Obtener el mapa de razas de la respuesta JSON
          return breedsMap.keys.toList(); // Retornar solo los nombres de las razas
        } else {
          throw Exception('No se pudo obtener la lista de razas.'); // Manejo de errores si la respuesta no es exitosa
        }
      } catch (e) {
        throw Exception('Error de conexión. Verifica tu internet.');
      }
    });
  }
}

class DogListView extends StatefulWidget {
  const DogListView({super.key});

  @override
  State<DogListView> createState() => _DogListViewState(); //* Estado de la vista de lista de razas de perros
}

class _DogListViewState extends State<DogListView> { //* Estado de la vista de lista de razas de perros
  final DogService _dogService = DogService();
  late Future<List<String>> _futureBreeds; //* Variable para almacenar la lista de razas de perros

  @override
  void initState() {
    super.initState(); //* Inicializar el estado
    _futureBreeds = _dogService.getAllBreeds(); //* Inicializar la lista de razas de perros al cargar la vista
  }

  @override
  Widget build(BuildContext context) { //* Construir la vista de lista de razas de perros
    return BaseView(
      title: 'Lista de Razas de Perros', // Título de la vista
      initialIndex: 0,
      length: 1,
      body: FutureBuilder<List<String>>(
        future: _futureBreeds,
        builder: (context, snapshot) { //* Constructor de la vista de lista de razas de perros
          if (snapshot.connectionState == ConnectionState.waiting) { //* Mostrar un indicador de carga mientras se obtienen los datos
            return const Center(
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // Indicador de carga
                  SizedBox(height: 10),
                  Text('Cargando razas de perros...') // // Mensaje de carga
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No se pudo cargar la lista de razas. Verifica tu conexión.'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureBreeds = _dogService.getAllBreeds();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else {
            final breeds = snapshot.data!;
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Seleccione una raza para ver más detalles.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: breeds.length,
                    itemBuilder: (context, index) {
                      final breed = breeds[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espaciado entre las tarjetas
                        child: GestureDetector( // Detectar el toque en la tarjeta
                          onTap: () {
                            context.push('/dog/$breed');
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      breed.toUpperCase(),
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

