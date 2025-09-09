import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Simulate app initialization tasks
      await Future.wait([
        _checkAuthenticationStatus(),
        _loadUserPreferences(),
        _initializeLocationServices(),
        _cachePropertyData(),
      ]);

      setState(() {
        _isInitialized = true;
      });

      // Wait for animation to complete before navigation
      await Future.delayed(const Duration(milliseconds: 3000));
      _navigateToNextScreen();
    } catch (e) {
      // Handle initialization errors
      _showRetryOption();
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    // Simulate authentication check
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _loadUserPreferences() async {
    // Simulate loading user preferences
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _initializeLocationServices() async {
    // Simulate location services initialization
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> _cachePropertyData() async {
    // Simulate property data caching
    await Future.delayed(const Duration(milliseconds: 600));
  }

  void _navigateToNextScreen() {
    // Navigation logic based on user status
    // For demo purposes, navigate to property browse screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/property-browse-screen',
      (route) => false,
    );
  }

  void _showRetryOption() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Connection Error',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Unable to initialize the app. Please check your internet connection and try again.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeApp();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.lightTheme.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.lightTheme.primaryColor,
                AppTheme.lightTheme.primaryColor.withValues(alpha: 0.8),
                AppTheme.primaryVariantLight,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildLogoSection(),
                      ),
                    );
                  },
                ),

                SizedBox(height: 8.h),

                // Loading Indicator
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: _buildLoadingSection(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        // App Logo Container
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'home_work',
              color: Colors.white,
              size: 12.w,
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // App Name
        Text(
          'PropertyConnect',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: 1.h),

        // App Tagline
        Text(
          'Connecting Properties & People',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      children: [
        // Loading Indicator
        SizedBox(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ),

        SizedBox(height: 3.h),

        // Loading Text
        Text(
          _getLoadingText(),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  String _getLoadingText() {
    if (!_isInitialized) {
      return 'Initializing...';
    }
    return 'Ready to explore properties!';
  }
}
