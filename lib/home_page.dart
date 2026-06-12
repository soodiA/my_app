import 'package:flutter/material.dart';
import 'models/lesson.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E1),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFFFB74D),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, color: Color(0xFF58CC02), size: 35),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE082),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                  SizedBox(width: 4),
                  Text('0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE082),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.diamond, color: Colors.blue, size: 20),
                  SizedBox(width: 4),
                  Text('0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: const PathMap(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF58CC02),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'یادگیری'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'جایزه'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'پروفایل'),
        ],
      ),
    );
  }
}

class PathMap extends StatelessWidget {
  const PathMap({super.key});

  @override
  Widget build(BuildContext context) {
return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomPaint(
                painter: PathPainter(lessonCount: lessons.length),
                child: Column(
                  children: List.generate(lessons.length, (index) {
                    final lesson = lessons[index];
                    final isLeft = index % 2 == 0;
                    final verticalSpacing = 110.0;

                    return Container(
                      height: verticalSpacing,
                      alignment: isLeft
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      padding: EdgeInsets.only(
                        left: isLeft ? 50 : 0,
                        right: isLeft ? 0 : 50,
                      ),
                      child: LessonCircle(lesson: lesson),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade400, width: 4),
              ),
              child: const Icon(Icons.emoji_events, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final int lessonCount;

  PathPainter({required this.lessonCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF58CC02)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final greyPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final verticalStep = 110.0;
    final startX = size.width * 0.15;
    final endX = size.width * 0.85;
    final centerY = 55.0;

    for (int i = 0; i < lessonCount - 1; i++) {
      final isLeft = i % 2 == 0;
      final y1 = i * verticalStep + centerY;
      final y2 = (i + 1) * verticalStep + centerY;

      final x1 = isLeft ? startX : endX;
      final x2 = isLeft ? endX : startX;

      final isUnlocked = lessons[i].isUnlocked;
      final currentPaint = isUnlocked ? paint : greyPaint;

      final path = Path();
      path.moveTo(x1, y1);
      path.quadraticBezierTo(
        (x1 + x2) / 2,
        y1 + 20,
        x2,
        y2,
      );
      canvas.drawPath(path, currentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LessonCircle extends StatelessWidget {
  final Lesson lesson;

  const LessonCircle({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
return GestureDetector(
      onTap: lesson.isUnlocked
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('درس ${lesson.title} (${lesson.subtitle})'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lesson.isCompleted
                  ? const Color(0xFF58CC02)
                  : lesson.isUnlocked
                      ? Colors.white
                      : Colors.grey.shade300,
              border: Border.all(
                color: lesson.isUnlocked
                    ? const Color(0xFF58CC02)
                    : Colors.grey.shade400,
                width: 4,
              ),
              boxShadow: lesson.isUnlocked
                  ? [
                      BoxShadow(
                        color: const Color(0xFF58CC02).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: lesson.isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 40)
                  : lesson.isUnlocked
                      ? Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF58CC02),
                          ),
                        )
                      : const Icon(Icons.lock, color: Colors.grey, size: 30),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            lesson.subtitle,
            style: TextStyle(
              fontSize: 13,
              color: lesson.isUnlocked ? Colors.black87 : Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (lesson.isCompleted)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return Icon(
                  i < lesson.stars ? Icons.star : Icons.star_border,
                  color: Colors.orange.shade400,
                  size: 16,
                );
              }),
            ),
        ],
      ),
    );
  }
}
