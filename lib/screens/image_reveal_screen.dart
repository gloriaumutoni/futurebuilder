import 'package:flutter/material.dart';
import '../services/animation_service.dart';

class ImageRevealScreen extends StatelessWidget {
  final AnimationService _service = AnimationService();

  ImageRevealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Reveal Animation'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _service.loadImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Text('Error loading image');
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                snapshot.data!,
                key: ValueKey(snapshot.data),
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
} 