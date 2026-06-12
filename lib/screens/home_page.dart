import 'package:flutter/material.dart';
import '../components/lesson_node.dart';
import '../models/lesson.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Lesson> lessons = [
    Lesson(
      id: '1',
      title: 'درس ۱',
      icon: Icons.school,
      color: const Color(0xFF58CC02),
      isUnlocked: true,
    ),
    Lesson(
      id: '2',
      title: 'درس ۲',
      icon: Icons.menu_book,
      color: const Color(0xFFFFA000),
    ),
    Lesson(
      id: '3',
      title: 'درس ۳',
      icon: Icons.spellcheck,
      color: const Color(0xFF2196F3),
    ),
    Lesson(
      id: '4',
      title: 'درس ۴',
      icon: Icons.quiz,
      color: const Color(0xFF9C27B0),
    ),
  ];

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
            const Icon(Icons.local_fire_department,
                color: Colors.orange, size: 28),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE082),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '5',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              for (int i = 0; i < lessons.length; i++)
                LessonNode(
                  lesson: lessons[i],
                  isLeft: i % 2 == 0,
                  onTap: () => _onLessonTap(i),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _onLessonTap(int index) {
    setState(() {
      // وقتی درس رو زد، بعدی رو باز کن
      if (index + 1 < lessons.length) {
        lessons[index].isCompleted = true;
        lessons[index + 1].isUnlocked = true;
      } else if (!lessons[index].isCompleted) {
        lessons[index].isCompleted = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${lessons[index].title} انتخاب شد')),
    );
  }
}
