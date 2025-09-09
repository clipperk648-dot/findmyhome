import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyDetailsForm extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController bedroomsController;
  final TextEditingController bathroomsController;
  final TextEditingController areaController;
  final String? listingType;
  final Function(String) onListingTypeChanged;
  final List<String> selectedAmenities;
  final Function(List<String>) onAmenitiesChanged;

  const PropertyDetailsForm({
    super.key,
    required this.priceController,
    required this.bedroomsController,
    required this.bathroomsController,
    required this.areaController,
    required this.listingType,
    required this.onListingTypeChanged,
    required this.selectedAmenities,
    required this.onAmenitiesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final amenitiesList = [
      'Parking',
      'Swimming Pool',
      'Gym',
      'Garden',
      'Balcony',
      'Air Conditioning',
      'Heating',
      'Furnished',
      'Pet Friendly',
      'Security',
      'Elevator',
      'Laundry',
      'Internet',
      'Cable TV'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Listing Type
        Text(
          'Listing Type *',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onListingTypeChanged('For Sale'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: listingType == 'For Sale'
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    border: Border.all(
                      color: listingType == 'For Sale'
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.dividerColor,
                      width: listingType == 'For Sale' ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'sell',
                        color: listingType == 'For Sale'
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'For Sale',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: listingType == 'For Sale'
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: listingType == 'For Sale'
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: GestureDetector(
                onTap: () => onListingTypeChanged('For Rent'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: listingType == 'For Rent'
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    border: Border.all(
                      color: listingType == 'For Rent'
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.dividerColor,
                      width: listingType == 'For Rent' ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'key',
                        color: listingType == 'For Rent'
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'For Rent',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: listingType == 'For Rent'
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: listingType == 'For Rent'
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // Price
        Text(
          'Price *',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: priceController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: listingType == 'For Rent'
                ? 'Monthly rent amount'
                : 'Sale price',
            prefixText: '\$ ',
            suffixText: listingType == 'For Rent' ? '/month' : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter price';
            }
            return null;
          },
        ),

        SizedBox(height: 4.h),

        // Property Details Row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bedrooms',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextFormField(
                    controller: bedroomsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: '0',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bathrooms',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextFormField(
                    controller: bathroomsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: '0',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // Area
        Text(
          'Area (sq ft)',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: areaController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: 'Total area in square feet',
            suffixText: 'sq ft',
          ),
        ),

        SizedBox(height: 4.h),

        // Amenities
        Text(
          'Amenities',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: amenitiesList.map((amenity) {
            final isSelected = selectedAmenities.contains(amenity);
            return GestureDetector(
              onTap: () {
                List<String> updatedAmenities = List.from(selectedAmenities);
                if (isSelected) {
                  updatedAmenities.remove(amenity);
                } else {
                  updatedAmenities.add(amenity);
                }
                onAmenitiesChanged(updatedAmenities);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  amenity,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
