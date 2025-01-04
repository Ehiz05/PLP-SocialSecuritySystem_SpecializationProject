import 'package:flutter/material.dart';
import 'package:social_security_app/widgets/onboarding_step.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        controller: _pageController,
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
            imagePath: "assets/images/social_sec-seamless_integration.png",
          ),
          OnboardingStep(
            title: "Manage Beneficiaries",
            description:
                "Easily add and manage beneficiaries for secure fund transfers.",
            imagePath: "assets/images/social_sec-beneficiariespreference.png",
          ),
        ],
      ),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.blueAccent,
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: const Text(
            "Get Started",
            style: TextStyle(
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
