import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> activeFilters;
  final Function(String) onRemoveFilter;

  const FilterChipsWidget({
    super.key,
    required this.activeFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 6.h,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: activeFilters.length,
        separatorBuilder: (context, index) => SizedBox(width: 2.w),
        itemBuilder: (context, index) {
          final filter = activeFilters[index];
          return _buildFilterChip(
            context,
            filter["label"] as String,
            filter["key"] as String,
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, String key) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppTheme.lightTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: () => onRemoveFilter(key),
            child: Container(
              padding: EdgeInsets.all(0.5.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.lightTheme.primaryColor,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
