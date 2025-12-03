import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> _allInterests = [
    'Music', 'Travel', 'Movies', 'Tech', 'Gaming', 
    'Books', 'Fitness', 'Food', 'Art', 'Politics',
    'Science', 'History', 'Anime', 'Pets'
  ];

  final List<String> _allLanguages = [
    'English', 'Hindi', 'Spanish', 'French', 'German', 'Japanese'
  ];

  final Set<String> _selectedInterests = {'Music', 'Travel'};
  final Set<String> _selectedLanguages = {'English', 'Hindi'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Interests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "We'll match you with people who like what you like.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allInterests.map((interest) {
                final isSelected = _selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedInterests.add(interest);
                      } else {
                        _selectedInterests.remove(interest);
                      }
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  checkmarkColor: Theme.of(context).primaryColor,
                );
              }).toList(),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              "Languages",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allLanguages.map((lang) {
                final isSelected = _selectedLanguages.contains(lang);
                return FilterChip(
                  label: Text(lang),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedLanguages.add(lang);
                      } else {
                        _selectedLanguages.remove(lang);
                      }
                    });
                  },
                  selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  checkmarkColor: Theme.of(context).colorScheme.secondary,
                );
              }).toList(),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Save Preferences"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
