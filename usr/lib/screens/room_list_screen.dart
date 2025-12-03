import 'package:flutter/material.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rooms = [
      {
        "title": "Chill Vibes Only 🎵",
        "users": 128,
        "tags": ["Music", "Relax"],
        "image": "https://via.placeholder.com/100/FF6584/FFFFFF?text=Music"
      },
      {
        "title": "English Practice 🇺🇸",
        "users": 45,
        "tags": ["Language", "Study"],
        "image": "https://via.placeholder.com/100/6C63FF/FFFFFF?text=Eng"
      },
      {
        "title": "Late Night Talks 🌙",
        "users": 312,
        "tags": ["Dating", "Chat"],
        "image": "https://via.placeholder.com/100/4CAF50/FFFFFF?text=Night"
      },
      {
        "title": "Gaming Squad 🎮",
        "users": 89,
        "tags": ["Gaming", "Team"],
        "image": "https://via.placeholder.com/100/FFC107/FFFFFF?text=Game"
      },
      {
        "title": "Singing Battle 🎤",
        "users": 204,
        "tags": ["Talent", "Fun"],
        "image": "https://via.placeholder.com/100/9C27B0/FFFFFF?text=Sing"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Voice Rooms"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Create Room feature coming soon!")),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: const Color(0xFF252525),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/group_room', arguments: room);
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(room['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              for (var tag in room['tags'])
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.headset, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                "${room['users']} listening",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
