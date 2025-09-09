import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class NavigationControlsWidget extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final bool canProceed;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const NavigationControlsWidget({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.canProceed,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastSlide = currentIndex == totalPages - 1;

    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            ),
            child: Text(
              'Skip',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Next/Get Started button
          ElevatedButton(
            onPressed: canProceed ? onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primary.withValues(alpha: 0.5),
              foregroundColor: theme.colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.w),
              ),
              elevation: canProceed ? 2 : 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLastSlide ? 'Get Started' : 'Next',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!isLastSlide) ...[
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    color: theme.colorScheme.onPrimary,
                    size: 4.w,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
