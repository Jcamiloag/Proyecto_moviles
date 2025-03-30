import 'dart:convert';
import 'package:hola_mundo/models/dog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DogService {
  final String apiUrl = dotenv.env['DOG_API_URL']!;

  // Método para obtener una imagen aleatoria de un perro
  Future<Dog> getRandomDog() async {
    final response = await http.get(Uri.parse('$apiUrl/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Dog.fromJson(data, 'random'); // Se pasa 'random' como raza genérica
    } else {
      throw Exception('Error al obtener la imagen del perro.');
    }
  }

  // Método para obtener una lista de imágenes de una raza específica
  Future<List<Dog>> getDogsByBreed(String breed) async {
    final response = await http.get(Uri.parse('$apiUrl/breed/$breed/images'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List images = data['message'];
      return images.map((image) => Dog.fromJson({'message': image}, breed)).toList();
    } else {
      throw Exception('Error al obtener imágenes de la raza $breed.');
    }
  }

  // Método para obtener todas las razas disponibles
  Future<List<String>> getAllBreeds() async {
    final response = await http.get(Uri.parse('$apiUrl/breeds/list/all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final Map<String, dynamic> breedsMap = data['message'];
      return breedsMap.keys.toList(); // Retorna solo los nombres de las razas
    } else {
      throw Exception('Error al obtener la lista de razas.');
    }
  }
}
