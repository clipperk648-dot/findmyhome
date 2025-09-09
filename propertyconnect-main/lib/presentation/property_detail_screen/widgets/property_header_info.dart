import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyHeaderInfo extends StatelessWidget {
  final String price;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final String squareFootage;
  final String propertyType;

  const PropertyHeaderInfo({
    super.key,
    required this.price,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFootage,
    required this.propertyType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price
          Text(
            price,
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),

          // Address
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                size: 16,
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Text(
                  address,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Property Details Row
          Row(
            children: [
              _buildDetailItem(
                icon: 'bed',
                value: bedrooms.toString(),
                label: bedrooms == 1 ? 'Bedroom' : 'Bedrooms',
              ),
              SizedBox(width: 6.w),
              _buildDetailItem(
                icon: 'bathtub',
                value: bathrooms.toString(),
                label: bathrooms == 1 ? 'Bathroom' : 'Bathrooms',
              ),
              SizedBox(width: 6.w),
              _buildDetailItem(
                icon: 'square_foot',
                value: squareFootage,
                label: 'Sq Ft',
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Property Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              propertyType,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String icon,
    required String value,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 20,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            SizedBox(width: 1.w),
            Text(
              value,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
