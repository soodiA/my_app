import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonNode extends StatelessWidget {
  final Lesson lesson;
  final bool isLeft;
  final VoidCallback? onTap;

  const LessonNode({
    super.key,
    required this.lesson,
    required this.isLeft,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: Row(
        mainAxisAlignment: isLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: lesson.isUnlocked ? onTap : null,
            child: Column(
              children: [
                // دایره اصلی
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lesson.isUnlocked
                        ? lesson.color
                        : Colors.grey.shade300,
                    border: Border.all(
                      color: lesson.isCompleted
                          ? const Color(0xFF58CC02)
                          : Colors.transparent,
                      width: 4,
                    ),
                    boxShadow: lesson.isUnlocked
                        ? [
                            BoxShadow(
                              color: lesson.color.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: _buildIcon(),
                  ),
                ),
                const SizedBox(height: 8),
                // لیبل زیر دایره
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: lesson.isUnlocked
                        ? Colors.white
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: lesson.isUnlocked
                          ? Colors.black87
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (lesson.isCompleted) {
      return const Icon(Icons.check, color: Colors.white, size: 40);
    }
    if (lesson.isUnlocked) {
      return Icon(lesson.icon, color: Colors.white, size: 40);
    }
    return const Icon(Icons.lock, color: Colors.grey, size: 30);
  }
}
