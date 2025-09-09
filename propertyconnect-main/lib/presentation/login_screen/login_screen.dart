import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/login_form.dart';
import './widgets/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'landlord@propertyconnect.com': 'landlord123',
    'tenant@propertyconnect.com': 'tenant123',
    'admin@propertyconnect.com': 'admin123',
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successful! Welcome to PropertyConnect'),
            backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
        );

        // Navigate to Property Browse screen
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/property-browse-screen',
          (route) => false,
        );
      }
    } else {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              email.isEmpty || password.isEmpty
                  ? 'Please fill in all fields'
                  : 'Invalid credentials. Please check your email and password.',
            ),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Password reset link sent to your email'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider login will be available soon'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sign up feature coming soon'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),

                  // App Logo
                  Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'home',
                        color: theme.colorScheme.onPrimary,
                        size: 12.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Sign in to your PropertyConnect account',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4.h),

                  // Login Form
                  LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    formKey: _formKey,
                    isLoading: _isLoading,
                    onLogin: _handleLogin,
                    onForgotPassword: _handleForgotPassword,
                  ),

                  SizedBox(height: 4.h),

                  // Social Login Section
                  SocialLoginSection(
                    onGoogleLogin: () => _handleSocialLogin('Google'),
                    onAppleLogin: () => _handleSocialLogin('Apple'),
                    onFacebookLogin: () => _handleSocialLogin('Facebook'),
                  ),

                  const Spacer(),

                  // Sign Up Link
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New user? ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToSignUp,
                          child: Text(
                            'Sign Up',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
