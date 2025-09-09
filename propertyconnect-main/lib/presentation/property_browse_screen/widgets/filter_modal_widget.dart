import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterModalWidget({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late Map<String, dynamic> _filters;
  RangeValues _priceRange = const RangeValues(0, 2000000);
  String _selectedPropertyType = 'All';
  int _selectedBedrooms = 0;
  int _selectedBathrooms = 0;
  List<String> _selectedAmenities = [];

  final List<String> _propertyTypes = [
    'All',
    'Apartment',
    'House',
    'Condo',
    'Townhouse',
    'Commercial'
  ];
  final List<String> _amenities = [
    'Parking',
    'Pool',
    'Gym',
    'Garden',
    'Balcony',
    'Elevator',
    'Security',
    'Pet Friendly',
    'Furnished',
    'Air Conditioning'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
    _initializeFilters();
  }

  void _initializeFilters() {
    _priceRange = RangeValues(
      (_filters['minPrice'] as double?) ?? 0,
      (_filters['maxPrice'] as double?) ?? 2000000,
    );
    _selectedPropertyType = (_filters['propertyType'] as String?) ?? 'All';
    _selectedBedrooms = (_filters['bedrooms'] as int?) ?? 0;
    _selectedBathrooms = (_filters['bathrooms'] as int?) ?? 0;
    _selectedAmenities =
        List<String>.from((_filters['amenities'] as List?) ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceRangeSection(context),
                  SizedBox(height: 3.h),
                  _buildPropertyTypeSection(context),
                  SizedBox(height: 3.h),
                  _buildBedroomsSection(context),
                  SizedBox(height: 3.h),
                  _buildBathroomsSection(context),
                  SizedBox(height: 3.h),
                  _buildAmenitiesSection(context),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 10.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Properties',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: _clearAllFilters,
                child: Text(
                  'Clear All',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 2000000,
          divisions: 40,
          labels: RangeLabels(
            '\$${(_priceRange.start / 1000).round()}K',
            '\$${(_priceRange.end / 1000).round()}K',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${(_priceRange.start / 1000).round()}K',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$${(_priceRange.end / 1000).round()}K',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyTypeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Type',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _propertyTypes.map((type) {
            final isSelected = _selectedPropertyType == type;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPropertyType = type;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  type,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        isSelected ? Colors.white : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBedroomsSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bedrooms',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: List.generate(6, (index) {
            final bedrooms = index;
            final isSelected = _selectedBedrooms == bedrooms;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedBedrooms = bedrooms;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < 5 ? 2.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    bedrooms == 0
                        ? 'Any'
                        : bedrooms == 5
                            ? '5+'
                            : bedrooms.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBathroomsSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bathrooms',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: List.generate(5, (index) {
            final bathrooms = index;
            final isSelected = _selectedBathrooms == bathrooms;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedBathrooms = bathrooms;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < 4 ? 2.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    bathrooms == 0
                        ? 'Any'
                        : bathrooms == 4
                            ? '4+'
                            : bathrooms.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _amenities.map((amenity) {
            final isSelected = _selectedAmenities.contains(amenity);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedAmenities.remove(amenity);
                  } else {
                    _selectedAmenities.add(amenity);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 16,
                      ),
                    if (isSelected) SizedBox(width: 1.w),
                    Text(
                      amenity,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.primaryColor
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 2000000);
      _selectedPropertyType = 'All';
      _selectedBedrooms = 0;
      _selectedBathrooms = 0;
      _selectedAmenities.clear();
    });
  }

  void _applyFilters() {
    final filters = <String, dynamic>{
      'minPrice': _priceRange.start,
      'maxPrice': _priceRange.end,
      'propertyType': _selectedPropertyType,
      'bedrooms': _selectedBedrooms,
      'bathrooms': _selectedBathrooms,
      'amenities': _selectedAmenities,
    };

    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }
}
