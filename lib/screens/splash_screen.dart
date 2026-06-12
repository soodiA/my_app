import 'package:flutter/material.dart';
import 'screens/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFE4E1),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 30,
              child: _buildCloud(),
            ),
            Positioned(
              top: 100,
              right: 40,
              child: _buildCloud(size: 70),
            ),
            Positioned(
              top: 180,
              left: 80,
              child: _buildCloud(size: 50),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'بازی یادگیری فارسی',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB8860B),
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/teddy.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF69B4),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'شروع',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomDecoration(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloud({double size = 60}) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }

  Widget _buildBottomDecoration() {
return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFlower(color: Colors.pink),
          _buildFlower(color: Colors.purple),
          _buildFlower(color: Colors.pinkAccent),
          _buildFlower(color: Colors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildFlower({required Color color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_florist, color: color, size: 24),
        Container(
          width: 2,
          height: 15,
          color: Colors.green,
        ),
      ],
    );
  }
} 
