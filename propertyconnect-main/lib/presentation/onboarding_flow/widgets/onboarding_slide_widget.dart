import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_widget.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final bool isLastSlide;

  const OnboardingSlideWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isLastSlide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 100.w,
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: 80.w,
              constraints: BoxConstraints(
                maxHeight: 40.h,
                minHeight: 25.h,
              ),
              child: CustomImageWidget(
                imageUrl: imageUrl,
                width: 80.w,
                height: 40.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
