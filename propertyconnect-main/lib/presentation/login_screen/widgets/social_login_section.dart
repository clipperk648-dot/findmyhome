import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './social_login_button.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;
  final VoidCallback onFacebookLogin;

  const SocialLoginSection({
    super.key,
    required this.onGoogleLogin,
    required this.onAppleLogin,
    required this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or continue with',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                thickness: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        SocialLoginButton(
          iconName: 'g_translate',
          label: 'Continue with Google',
          onPressed: onGoogleLogin,
          backgroundColor: theme.colorScheme.surface,
          textColor: theme.colorScheme.onSurface,
          borderColor: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
        SocialLoginButton(
          iconName: 'apple',
          label: 'Continue with Apple',
          onPressed: onAppleLogin,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          borderColor: Colors.black,
        ),
        SocialLoginButton(
          iconName: 'facebook',
          label: 'Continue with Facebook',
          onPressed: onFacebookLogin,
          backgroundColor: const Color(0xFF1877F2),
          textColor: Colors.white,
          borderColor: const Color(0xFF1877F2),
        ),
      ],
    );
  }
}
