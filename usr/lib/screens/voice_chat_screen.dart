import 'dart:async';
import 'package:flutter/material.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({super.key});

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isLiked = false;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String get _formattedTime {
    final minutes = (_seconds / 60).floor().toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report User"),
        content: const Text("Select a reason for reporting this user. This helps keep our community safe."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User reported. Thank you for helping us.")),
              );
            },
            child: const Text("Report", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context), // Minimize functionality mock
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shield_outlined),
            onPressed: _showReportDialog,
            tooltip: "Report/Block",
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Section: Connection Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text("Connection Stable", style: TextStyle(color: Colors.green)),
              ],
            ),
          ),

          // Middle Section: Profiles
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Other User
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.deepPurple,
                  child: Text("S", style: TextStyle(fontSize: 40, color: Colors.white)),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Sarah",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Matches: Travel, Music",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Text(
                  _formattedTime,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Section: Controls
          Container(
            padding: const EdgeInsets.only(bottom: 40, top: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF252525),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute
                IconButton(
                  icon: Icon(isMuted ? Icons.mic_off : Icons.mic),
                  color: isMuted ? Colors.red : Colors.white,
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      isMuted = !isMuted;
                    });
                  },
                ),
                
                // End Call
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.call_end, color: Colors.white, size: 32),
                  ),
                ),

                // Speaker
                IconButton(
                  icon: Icon(isSpeakerOn ? Icons.volume_up : Icons.volume_down),
                  color: isSpeakerOn ? Colors.blue : Colors.white,
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: isLiked ? Colors.pink : Colors.grey[800],
        onPressed: () {
          setState(() {
            isLiked = !isLiked;
          });
          if (isLiked) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("You liked this conversation! Added to Reconnect.")),
            );
          }
        },
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
