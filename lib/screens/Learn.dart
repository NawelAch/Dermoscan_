import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  @override
  _LearnState createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  // List of titles for each item
  // List of titles for each item
  final List<String> titles = [
    "Why should you keep an eye on your skin?",
    "Can a smartphone app diagnose melanoma skin cancer?",
    "How is melanoma skin cancer diagnosed?",
    "What skin cancer risk factors should you be aware of?",
    "How often should you keep an eye on your skin?",
    "What signs on your skin should you be aware of?",
    "Want to know more about skin changes?"
    // Add any additional titles here
  ];

  // List of contents for each item
  final List<String> contents = [
    "Monitoring your skin can help you notice any changes or abnormalities early, which is crucial for early detection of skin conditions, including cancer.",
    "While some apps claim to assess the risk of melanoma, it's important to consult with a healthcare professional for a proper diagnosis.",
    "Melanoma is typically diagnosed through a clinical exam followed by a biopsy and histopathological analysis of the suspicious lesion.",
    "Risk factors for skin cancer include excessive sun exposure, history of sunburns, family history of skin cancer, and certain types of moles.",
    "It's recommended to examine your skin once a month for any new or changing lesions that might indicate skin cancer or other skin conditions.",
    "Be aware of any new, unusual growths or changes in existing moles, including asymmetry, border irregularity, color changes, diameter over 6mm, and evolving over time.",
    "Learning about skin changes can help you understand when to seek medical advice. Changes to monitor include new growths, changes in existing moles, and skin lesions that itch, bleed, or don't heal."
    // Add any additional content here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(titles[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentScreen(contentTitle: titles[index], content: contents[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  final String contentTitle;
  final String content;

  ContentScreen({required this.contentTitle, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Learn'),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.lightBlue, // This is the color behind the question
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  contentTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(content),
            ),
          ),
        ],
      ),
    );
  }
}