import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyTypeSelector extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTypeSelected;

  const PropertyTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final propertyTypes = [
      {'type': 'Apartment', 'icon': 'apartment'},
      {'type': 'House', 'icon': 'home'},
      {'type': 'Condo', 'icon': 'business'},
      {'type': 'Townhouse', 'icon': 'location_city'},
      {'type': 'Commercial', 'icon': 'store'},
      {'type': 'Land', 'icon': 'landscape'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Type *',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 2.5,
          ),
          itemCount: propertyTypes.length,
          itemBuilder: (context, index) {
            final type = propertyTypes[index];
            final isSelected = selectedType == type['type'];

            return GestureDetector(
              onTap: () => onTypeSelected(type['type']!),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: type['icon']!,
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      type['type']!,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
