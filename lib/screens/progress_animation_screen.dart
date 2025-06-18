import 'package:flutter/material.dart';
import '../services/animation_service.dart';

class ProgressAnimationScreen extends StatefulWidget {
  const ProgressAnimationScreen({super.key});

  @override
  State<ProgressAnimationScreen> createState() => _ProgressAnimationScreenState();
}

class _ProgressAnimationScreenState extends State<ProgressAnimationScreen> {
  final AnimationService _service = AnimationService();
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgressAnimation();
  }

  void _startProgressAnimation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (_progress < 0.9) {
        setState(() {
          _progress += 0.1;
        });
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Animation'),
      ),
      body: Center(
        child: FutureBuilder<double>(
          future: _service.loadProgressData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Loading...'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('${(_progress * 100).toInt()}%'),
                ],
              );
            }

            if (snapshot.hasError) {
              return const Text('Error loading progress');
            }

            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 48,
                ),
                SizedBox(height: 16),
                Text(
                  'Complete! 🎉',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 