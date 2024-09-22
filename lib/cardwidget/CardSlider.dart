import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../home/homepage.dart';

class CardSlider extends StatefulWidget {
  const CardSlider({Key? key}) : super(key: key);

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of card data with Lottie animations
  final List<Map<String, String>> _cardData = [
    {
      'animation': 'assets/animations/track_vehical.json',
      'title': 'Track Your Vehicle',
      'description': 'Easily track your vehicle\'s real-time location.',
    },
    {
      'animation': 'assets/animations/safety.json',
      'title': 'Ensure Safety',
      'description': 'Get instant notifications in case of theft or accidents.',
    },
    {
      'animation': 'assets/animations/boring.json',
      'title': 'Seamless Experience',
      'description': 'A simple interface to monitor all your vehicles.',
    },
  ];

  // Function to navigate to the HomePage after the last card
  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _cardData.isEmpty // Check if _cardData is not empty
                ? Center(child: Text('No cards available'))
                : PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _cardData.length,
              itemBuilder: (context, index) {
                if (index >= 0 && index < _cardData.length) {
                  return _buildCard(
                    _cardData[index]['title']!,
                    _cardData[index]['description']!,
                    _cardData[index]['animation']!,
                  );
                } else {
                  return Center(child: Text('Invalid card index'));
                }
              },
            ),
          ),
          _buildNextButton(),
        ],
      ),
    );
  }

  // Widget to build each card with Lottie animation
  Widget _buildCard(String title, String description, String animation) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(animation, width: 200, height: 200), // Lottie Animation
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the Next button
  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _currentPage == _cardData.length - 1
            ? _navigateToHomePage
            : () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(_currentPage == _cardData.length - 1 ? 'Go to Home' : 'Next'),
      ),
    );
  }
}
