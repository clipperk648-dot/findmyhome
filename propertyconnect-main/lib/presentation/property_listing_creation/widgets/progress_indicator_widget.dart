import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress bar
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;

              return Expanded(
                child: Container(
                  height: 0.5.h,
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 2.h),

          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;

              return Column(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.lightTheme.colorScheme.primary
                          : isCurrent
                              ? AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.2)
                              : AppTheme.lightTheme.dividerColor,
                      shape: BoxShape.circle,
                      border: isCurrent
                          ? Border.all(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: isCompleted
                          ? CustomIconWidget(
                              iconName: 'check',
                              color: Colors.white,
                              size: 16,
                            )
                          : Text(
                              '${index + 1}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: isCurrent
                                    ? AppTheme.lightTheme.colorScheme.primary
                                    : AppTheme.lightTheme.colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    width: 20.w,
                    child: Text(
                      stepTitles[index],
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: isCurrent
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                        fontWeight:
                            isCurrent ? FontWeight.w600 : FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
