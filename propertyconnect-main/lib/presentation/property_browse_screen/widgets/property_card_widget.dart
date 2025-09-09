import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyCardWidget extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const PropertyCardWidget({
    super.key,
    required this.property,
    this.onTap,
    this.onFavorite,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            _buildContentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: CustomImageWidget(
            imageUrl: (property["images"] as List).isNotEmpty
                ? (property["images"] as List)[0] as String
                : "https://images.unsplash.com/photo-1560518883-ce09059eeffa?fm=jpg&q=60&w=3000",
            width: double.infinity,
            height: 25.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: onFavorite,
              icon: CustomIconWidget(
                iconName: (property["isFavorite"] as bool)
                    ? 'favorite'
                    : 'favorite_border',
                color: (property["isFavorite"] as bool)
                    ? Colors.red
                    : colorScheme.onSurface.withValues(alpha: 0.7),
                size: 20,
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              property["status"] as String,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  property["price"] as String,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onShare,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: CustomIconWidget(
                    iconName: 'share',
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            property["title"] as String,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 16,
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Text(
                  property["location"] as String,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              _buildFeatureChip(context, 'bed', '${property["bedrooms"]} Beds'),
              SizedBox(width: 2.w),
              _buildFeatureChip(
                  context, 'bathtub', '${property["bathrooms"]} Baths'),
              SizedBox(width: 2.w),
              _buildFeatureChip(
                  context, 'square_foot', '${property["area"]} sqft'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(
      BuildContext context, String iconName, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            size: 14,
          ),
          SizedBox(width: 1.w),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
