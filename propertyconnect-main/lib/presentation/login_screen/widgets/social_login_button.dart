import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const SocialLoginButton({
    super.key,
    required this.iconName,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.surface,
          foregroundColor: textColor ?? theme.colorScheme.onSurface,
          side: BorderSide(
            color:
                borderColor ?? theme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: textColor ?? theme.colorScheme.onSurface,
              size: 5.w,
            ),
            SizedBox(width: 3.w),
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor ?? theme.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
