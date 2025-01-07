import 'package:flutter/material.dart';
import 'package:social_security_app/widgets/onboarding_step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // Track the current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 212, 237),
      body: Column(
        children: [
          // PageView for onboarding slides
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                OnboardingStep(
                  title: "Welcome to Social Security App",
                  description:
                      "Manage your funds, receive payments, and keep track of your financial activities.",
                  imagePath: "assets/images/social_sec-fintech-africa.png",
                ),
                OnboardingStep(
                  title: "Seamless Wallet Integration",
                  description:
                      "Access your wallet instantly with secure and fast transactions.",
                  imagePath:
                      "assets/images/social_sec-seamless_integration.png",
                ),
                OnboardingStep(
                  title: "Manage Beneficiaries",
                  description:
                      "Easily add and manage beneficiaries for secure fund transfers.",
                  imagePath:
                      "assets/images/social_sec-beneficiariespreference.png",
                ),
              ],
            ),
          ),
          // Dots indicator for the current page
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Number of pages
                (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  // Build each dot for the indicator
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blueAccent : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // Bottom sheet with Get Started/Next button
  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: TextButton(
          onPressed: () {
            if (_currentPage == 2) {
              // If on the last page, navigate to the home screen
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              // Otherwise, navigate to the next page
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text(
            _currentPage == 2 ? "Get Started" : "Next",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
