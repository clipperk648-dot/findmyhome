import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchHeaderWidget extends StatelessWidget {
  final String searchQuery;
  final int filterCount;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onLocationTap;

  const SearchHeaderWidget({
    super.key,
    required this.searchQuery,
    required this.filterCount,
    this.onSearchTap,
    this.onFilterTap,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'search',
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          searchQuery.isEmpty
                              ? 'Search properties...'
                              : searchQuery,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: searchQuery.isEmpty
                                ? colorScheme.onSurface.withValues(alpha: 0.5)
                                : colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: onLocationTap,
                        child: Container(
                          padding: EdgeInsets.all(1.w),
                          child: CustomIconWidget(
                            iconName: 'my_location',
                            color: AppTheme.lightTheme.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                padding: EdgeInsets.all(1.5.h),
                decoration: BoxDecoration(
                  color: filterCount > 0
                      ? AppTheme.lightTheme.primaryColor
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: filterCount > 0
                        ? AppTheme.lightTheme.primaryColor
                        : colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Stack(
                  children: [
                    CustomIconWidget(
                      iconName: 'tune',
                      color: filterCount > 0
                          ? Colors.white
                          : colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                    if (filterCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: EdgeInsets.all(0.5.w),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 4.w,
                            minHeight: 4.w,
                          ),
                          child: Text(
                            filterCount.toString(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}