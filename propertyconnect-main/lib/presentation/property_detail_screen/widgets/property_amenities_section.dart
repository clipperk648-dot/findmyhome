import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyAmenitiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> amenities;

  const PropertyAmenitiesSection({
    super.key,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    if (amenities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amenities',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: amenities.length,
            itemBuilder: (context, index) {
              final amenity = amenities[index];
              return _buildAmenityItem(
                icon: amenity['icon'] as String,
                name: amenity['name'] as String,
                isAvailable: amenity['available'] as bool? ?? true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem({
    required String icon,
    required String name,
    required bool isAvailable,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppTheme.lightTheme.colorScheme.surface
            : AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAvailable
              ? AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3)
              : AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            size: 20,
            color: isAvailable
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.4),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              name,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: isAvailable
                    ? AppTheme.lightTheme.colorScheme.onSurface
                    : AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.4),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
