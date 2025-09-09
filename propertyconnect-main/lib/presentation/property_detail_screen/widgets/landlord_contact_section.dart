import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LandlordContactSection extends StatelessWidget {
  final Map<String, dynamic> landlordInfo;
  final VoidCallback? onContactTap;
  final VoidCallback? onCallTap;

  const LandlordContactSection({
    super.key,
    required this.landlordInfo,
    this.onContactTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Landlord',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: CustomImageWidget(
                          imageUrl: landlordInfo['profileImage'] as String,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  landlordInfo['name'] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (landlordInfo['isVerified'] as bool? ?? false)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'verified',
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        'Verified',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),

                          // Rating
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  final rating =
                                      landlordInfo['rating'] as double? ?? 0.0;
                                  return CustomIconWidget(
                                    iconName: index < rating.floor()
                                        ? 'star'
                                        : 'star_border',
                                    size: 16,
                                    color: AppTheme.warningLight,
                                  );
                                }),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${landlordInfo['rating'] ?? 0.0} (${landlordInfo['reviewCount'] ?? 0} reviews)',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),

                          Text(
                            'Landlord since ${landlordInfo['memberSince'] ?? 'N/A'}',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Contact Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onCallTap,
                        icon: CustomIconWidget(
                          iconName: 'phone',
                          size: 18,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                        label: Text('Call'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onContactTap,
                        icon: CustomIconWidget(
                          iconName: 'message',
                          size: 18,
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                        ),
                        label: Text('Message'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
