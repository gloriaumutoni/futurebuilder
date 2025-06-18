import 'dart:async';
import 'dart:math';

class AnimationService {
  // Simulates loading an image with 5 seconds delay
  Future<String> loadImage() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'https://picsum.photos/200/300';
  }

  // Simulates loading puzzle data with 7 seconds delay
  Future<List<String>> loadPuzzleData() async {
    await Future.delayed(const Duration(seconds: 7));
    return List.generate(9, (index) => 'Piece ${index + 1}');
  }

  // Simulates loading progress data with 9 seconds delay
  Future<double> loadProgressData() async {
    await Future.delayed(const Duration(seconds: 9));
    return 1.0;
  }

  // Simulates loading mood data with 11 seconds delay
  Future<String> loadMoodData() async {
    await Future.delayed(const Duration(seconds: 11));
    final moods = ['😊', '😢', '😡', '😴', '🤔'];
    return moods[Random().nextInt(moods.length)];
  }
} 