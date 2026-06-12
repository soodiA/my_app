import 'package:flutter/material.dart';

class Friend {
  final String name;
  final int xp;
  final int streak;
  final int lessonsCompleted;
  final bool isOnline;

  const Friend({
    required this.name,
    required this.xp,
    required this.streak,
    required this.lessonsCompleted,
    this.isOnline = false,
  });
}

final List<Friend> _demoFriends = [
  const Friend(name: 'آریا', xp: 3200, streak: 12, lessonsCompleted: 22, isOnline: true),
  const Friend(name: 'نیلا', xp: 2800, streak: 8, lessonsCompleted: 18, isOnline: true),
  const Friend(name: 'کیان', xp: 1500, streak: 3, lessonsCompleted: 10, isOnline: false),
  const Friend(name: 'سارا', xp: 4100, streak: 21, lessonsCompleted: 30, isOnline: false),
];

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<Friend> friends = List.from(_demoFriends);
  final TextEditingController _controller = TextEditingController();

  void _addFriend() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    setState(() {
      friends.add(Friend(
        name: name,
        xp: 0,
        streak: 0,
        lessonsCompleted: 0,
      ));
    });
    _controller.clear();
    Navigator.pop(context);
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('افزودن دوست'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'نام دوست را وارد کنید',
          ),
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('لغو')),
          ElevatedButton(onPressed: _addFriend, child: const Text('اضافه کن')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    friends.sort((a, b) => b.xp.compareTo(a.xp));
return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('دوستان و رقابت'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: _showAddDialog,
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  final rank = index + 1;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildRank(rank),
                          const SizedBox(width: 12),
                          _buildAvatar(friend.isOnline),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  friend.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _buildMiniStat(Icons.local_fire_department, '${friend.streak}', Colors.orange),
                                    const SizedBox(width: 12),
                                    _buildMiniStat(Icons.check_circle, '${friend.lessonsCompleted}', Colors.green),
                                    const SizedBox(width: 12),
                                    _buildMiniStat(Icons.star, '${friend.xp}', Colors.amber),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRank(int rank) {
    Color color = Colors.grey;
    if (rank == 1) color = Colors.amber;
    if (rank == 2) color = Colors.blueGrey;
    if (rank == 3) color = Colors.brown;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isOnline) {
return Stack(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF4CAF50),
          child: const Icon(Icons.person, color: Colors.white, size: 28),
        ),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMiniStat(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 2),
        Text(value, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
