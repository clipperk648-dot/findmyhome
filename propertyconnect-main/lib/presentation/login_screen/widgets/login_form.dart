import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './custom_text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _emailError = false;
  bool _passwordError = false;
  String? _emailErrorText;
  String? _passwordErrorText;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _emailError = true;
        _emailErrorText = 'Email is required';
      });
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      setState(() {
        _emailError = true;
        _emailErrorText = 'Please enter a valid email address';
      });
      return 'Please enter a valid email address';
    }

    setState(() {
      _emailError = false;
      _emailErrorText = null;
    });
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _passwordError = true;
        _passwordErrorText = 'Password is required';
      });
      return 'Password is required';
    }

    if (value.length < 6) {
      setState(() {
        _passwordError = true;
        _passwordErrorText = 'Password must be at least 6 characters';
      });
      return 'Password must be at least 6 characters';
    }

    setState(() {
      _passwordError = false;
      _passwordErrorText = null;
    });
    return null;
  }

  bool get _isFormValid {
    return widget.emailController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty &&
        !_emailError &&
        !_passwordError;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            iconName: 'email',
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            showError: _emailError,
            errorText: _emailErrorText,
          ),
          SizedBox(height: 2.h),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            iconName: 'lock',
            controller: widget.passwordController,
            isPassword: true,
            validator: _validatePassword,
            showError: _passwordError,
            errorText: _passwordErrorText,
          ),
          SizedBox(height: 1.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: widget.onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              ),
              child: Text(
                'Forgot Password?',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed:
                  _isFormValid && !widget.isLoading ? widget.onLogin : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                disabledBackgroundColor:
                    theme.colorScheme.onSurface.withValues(alpha: 0.12),
                disabledForegroundColor:
                    theme.colorScheme.onSurface.withValues(alpha: 0.38),
                elevation: 2.0,
                shadowColor: theme.shadowColor.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w),
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      'Login',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
