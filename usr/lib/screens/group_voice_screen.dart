import 'package:flutter/material.dart';

class GroupVoiceScreen extends StatefulWidget {
  const GroupVoiceScreen({super.key});

  @override
  State<GroupVoiceScreen> createState() => _GroupVoiceScreenState();
}

class _GroupVoiceScreenState extends State<GroupVoiceScreen> {
  bool isMuted = true;
  
  // Mock data for users in the room
  final List<Map<String, dynamic>> _users = [
    {'name': 'Host', 'isSpeaking': true, 'image': 'https://via.placeholder.com/150/FF5722/FFFFFF?text=H'},
    {'name': 'Alice', 'isSpeaking': false, 'image': 'https://via.placeholder.com/150/2196F3/FFFFFF?text=A'},
    {'name': 'Bob', 'isSpeaking': false, 'image': 'https://via.placeholder.com/150/4CAF50/FFFFFF?text=B'},
    {'name': 'Charlie', 'isSpeaking': true, 'image': 'https://via.placeholder.com/150/FFC107/FFFFFF?text=C'},
    {'name': 'You', 'isSpeaking': false, 'image': 'https://via.placeholder.com/150/9C27B0/FFFFFF?text=Y'},
    {'name': 'Dave', 'isSpeaking': false, 'image': 'https://via.placeholder.com/150/607D8B/FFFFFF?text=D'},
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'] ?? "Voice Room";

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Room Info / Announcement
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white.withOpacity(0.05),
            child: Row(
              children: [
                const Icon(Icons.campaign, color: Colors.orange),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "Welcome to the room! Please be respectful to all speakers.",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          
          // User Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                final isSpeaking = user['isSpeaking'] as bool;
                
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Speaking Indicator Ring
                        if (isSpeaking)
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.greenAccent,
                                width: 3,
                              ),
                            ),
                          ),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(user['image']),
                        ),
                        // Mute Icon for others (mock)
                        if (!isSpeaking && index != 4)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.mic_off, size: 12, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),

          // Bottom Controls
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF252525),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.message_outlined),
                  color: Colors.white,
                  onPressed: () {},
                ),
                
                // Mic Toggle
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMuted = !isMuted;
                      // Update "You" status
                      _users[4]['isSpeaking'] = !isMuted;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isMuted ? Colors.white10 : Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isMuted ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
