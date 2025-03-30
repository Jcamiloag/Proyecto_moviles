import 'package:flutter/material.dart';
import 'package:hola_mundo/models/dog.dart';
import 'package:hola_mundo/services/dog_services.dart';

class DogDetailView extends StatefulWidget {
  final String breed;

  const DogDetailView({super.key, required this.breed});

  @override
  State<DogDetailView> createState() => _DogDetailViewState();
}

class _DogDetailViewState extends State<DogDetailView> {
  final DogService _dogService = DogService();
  late Future<List<Dog>> _futureDogs;

  @override
  void initState() {
    super.initState();
    _futureDogs = _dogService.getDogsByBreed(widget.breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de ${widget.breed.toUpperCase()}'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Dog>>(
        future: _futureDogs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dogs = snapshot.data!;
            return ListView.builder(
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                final dog = dogs[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          dog.image,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          dog.breed.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
