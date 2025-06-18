import 'package:flutter/material.dart';
import '../services/animation_service.dart';

class MoodAnimationScreen extends StatelessWidget {
  final AnimationService _service = AnimationService();

  MoodAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Animation'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _service.loadMoodData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: const Text(
                      '😐',
                      style: TextStyle(fontSize: 64),
                    ),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              return const Text('Error loading mood');
            }

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.5 + (value * 0.5),
                  child: Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 64),
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