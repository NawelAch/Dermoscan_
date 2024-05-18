import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            WelcomeSection(),
            /*HowItWorksSection(),
            SuccessStoriesSection(),
            LatestUpdatesSection(),
            HealthTipsSection(),
            NewsFeedSection(),*/
          ],
        ),
      ),
    );
  }
}
/*class HowItWorksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'How It Works',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '1. Take or select a photo of the affected skin area.\n'
                '2. Let the app analyze the photo for signs of skin cancer.\n'
                '3. Receive instant feedback and recommendations.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
class SuccessStoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'Success Stories',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Read inspiring stories of individuals who have successfully monitored their skin health using our app.',
            style: TextStyle(fontSize: 16),
          ),
          // Add more content or widgets for success stories here
        ],
      ),
    );
  }
}

class LatestUpdatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'Latest Updates',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Stay up-to-date with the latest enhancements and features added to our app.',
            style: TextStyle(fontSize: 16),
          ),
          // Add widgets for displaying the latest updates here
        ],
      ),
    );
  }
}

class HealthTipsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'Health Tips',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Daily tips to keep your skin healthy and prevent skin conditions.',
            style: TextStyle(fontSize: 16),
          ),
          // Add widgets for health tips here
        ],
      ),
    );
  }
}

class NewsFeedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            'News Feed',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Read the latest news about skin health and advancements in dermatology.',
            style: TextStyle(fontSize: 16),
          ),
          // Add widgets for the news feed here
        ],
      ),
    );
  }
}
*/
class WelcomeSection extends StatefulWidget {
  @override
  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome to Dermoskan!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'At Dermoskan, we\'re committed to your skin health. Our app uses advanced technology to scan and analyze your skin, providing insights that matter. Whether you\'re monitoring moles, checking for changes, or seeking peace of mind, Dermoskan is here for you.\n\nRemember: Early detection saves lives. Let\'s keep your skin safe together! 🌟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// Example of an animated widget
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}