import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import './widgets/navigation_controls_widget.dart';
import './widgets/onboarding_slide_widget.dart';
import './widgets/page_indicator_widget.dart';
import './widgets/user_type_selection_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late PageController _pageController;
  int _currentIndex = 0;
  String? _selectedUserType;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Find Your Perfect Property",
      "description":
          "Discover thousands of properties for rent and sale. Filter by location, price, and amenities to find exactly what you're looking for.",
      "imageUrl":
          "https://images.unsplash.com/photo-1560518883-ce09059eeffa?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG91c2V8ZW58MHx8MHx8fDA%3D",
    },
    {
      "title": "List & Manage Properties",
      "description":
          "Easily create property listings with photos and detailed descriptions. Manage inquiries and connect with potential tenants or buyers.",
      "imageUrl":
          "https://images.unsplash.com/photo-1582407947304-fd86f028f716?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHx8MA%3D%3D",
    },
    {
      "title": "Connect & Communicate",
      "description":
          "Chat directly with property owners and seekers. Schedule viewings, negotiate prices, and close deals seamlessly.",
      "imageUrl":
          "https://images.unsplash.com/photo-1556761175-b413da4baf72?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cmVhbCUyMGVzdGF0ZSUyMGFnZW50fGVufDB8fDB8fHww",
    },
    {
      "title": "Save & Compare Favorites",
      "description":
          "Bookmark properties you love and compare them side by side. Never lose track of your dream home or investment opportunity.",
      "imageUrl":
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG91c2V8ZW58MHx8MHx8fDA%3D",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _onboardingData.length) {
      HapticFeedback.lightImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    HapticFeedback.lightImpact();
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_completed', true);

      if (_selectedUserType != null) {
        await prefs.setString('user_type', _selectedUserType!);
      }

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login-screen',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login-screen',
          (route) => false,
        );
      }
    }
  }

  void _onUserTypeSelected(String userType) {
    setState(() {
      _selectedUserType = userType;
    });
    HapticFeedback.selectionClick();
  }

  bool _canProceed() {
    if (_currentIndex < _onboardingData.length) {
      return true;
    }
    return _selectedUserType != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalPages = _onboardingData.length + 1; // +1 for user type selection

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  HapticFeedback.selectionClick();
                },
                children: [
                  // Onboarding slides
                  ..._onboardingData.asMap().entries.map((entry) {
                    final slideData = entry.value;
                    return OnboardingSlideWidget(
                      title: slideData["title"] as String,
                      description: slideData["description"] as String,
                      imageUrl: slideData["imageUrl"] as String,
                      isLastSlide: entry.key == _onboardingData.length - 1,
                    );
                  }),
                  // User type selection slide
                  UserTypeSelectionWidget(
                    selectedUserType: _selectedUserType,
                    onUserTypeSelected: _onUserTypeSelected,
                  ),
                ],
              ),
            ),

            // Page indicators
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: PageIndicatorWidget(
                currentIndex: _currentIndex,
                totalPages: totalPages,
              ),
            ),

            // Navigation controls
            NavigationControlsWidget(
              currentIndex: _currentIndex,
              totalPages: totalPages,
              canProceed: _canProceed(),
              onNext: _nextPage,
              onSkip: _skipOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}
