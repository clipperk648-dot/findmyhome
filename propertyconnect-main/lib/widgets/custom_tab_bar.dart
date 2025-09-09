import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom Tab Bar widget for the real estate application
/// Provides tabbed navigation within screens for content organization
class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTap;
  final TabBarVariant variant;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.variant = TabBarVariant.standard,
    this.isScrollable = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: _getDecoration(theme),
      child: _buildTabBar(context),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    switch (variant) {
      case TabBarVariant.chips:
        return _buildChipTabs(context);
      case TabBarVariant.segmented:
        return _buildSegmentedTabs(context);
      case TabBarVariant.standard:
      default:
        return _buildStandardTabs(context);
    }
  }

  Widget _buildStandardTabs(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isSelected ? colorScheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                tab,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChipTabs(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.outline.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Text(
                tab,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSegmentedTabs(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = currentIndex == index;
          final isFirst = index == 0;
          final isLast = index == tabs.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: isFirst ? const Radius.circular(7) : Radius.zero,
                    right: isLast ? const Radius.circular(7) : Radius.zero,
                  ),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  BoxDecoration? _getDecoration(ThemeData theme) {
    switch (variant) {
      case TabBarVariant.chips:
      case TabBarVariant.segmented:
        return null;
      case TabBarVariant.standard:
      default:
        return BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        );
    }
  }
}

/// Predefined tab configurations for common real estate screens
class PropertyTabConfigs {
  static const List<String> propertyDetails = [
    'Overview',
    'Details',
    'Location',
    'Photos',
  ];

  static const List<String> propertySearch = [
    'All',
    'For Sale',
    'For Rent',
    'Commercial',
  ];

  static const List<String> propertyTypes = [
    'Apartment',
    'House',
    'Condo',
    'Townhouse',
  ];

  static const List<String> priceRanges = [
    'Under 500K',
    '500K-1M',
    '1M-2M',
    'Above 2M',
  ];

  static const List<String> landlordDashboard = [
    'Active',
    'Pending',
    'Rented',
    'Archived',
  ];
}

/// Enum defining different tab bar variants
enum TabBarVariant {
  standard,
  chips,
  segmented,
}
