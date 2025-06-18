import 'package:flutter/material.dart';
import '../services/animation_service.dart';

class PuzzleAnimationScreen extends StatelessWidget {
  final AnimationService _service = AnimationService();

  PuzzleAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Animation'),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _service.loadPuzzleData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading puzzle pieces...'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              );
            }

            if (snapshot.hasError) {
              return const Text('Error loading puzzle');
            }

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.blue[100 * (index % 3 + 1)],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      snapshot.data![index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 