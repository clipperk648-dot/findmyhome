import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/description_input.dart';
import './widgets/location_picker.dart';
import './widgets/photo_upload_section.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/property_details_form.dart';
import './widgets/property_type_selector.dart';

class PropertyListingCreation extends StatefulWidget {
  const PropertyListingCreation({super.key});

  @override
  State<PropertyListingCreation> createState() =>
      _PropertyListingCreationState();
}

class _PropertyListingCreationState extends State<PropertyListingCreation> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Form data
  String? _selectedPropertyType;
  String? _selectedAddress;
  LatLng? _selectedLocation;
  String? _listingType;
  List<String> _selectedAmenities = [];
  List<XFile> _selectedImages = [];

  int _currentStep = 0;
  final int _totalSteps = 4;
  final List<String> _stepTitles = [
    'Basic Info',
    'Location',
    'Details',
    'Photos & Description'
  ];

  bool _isDraftSaved = false;

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _areaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      if (_validateCurrentStep()) {
        setState(() => _currentStep++);
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _submitListing();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_selectedPropertyType == null) {
          _showErrorSnackBar('Please select a property type');
          return false;
        }
        if (_titleController.text.trim().isEmpty) {
          _showErrorSnackBar('Please enter a property title');
          return false;
        }
        return true;
      case 1:
        if (_selectedAddress == null || _selectedAddress!.isEmpty) {
          _showErrorSnackBar('Please select a property location');
          return false;
        }
        return true;
      case 2:
        if (_listingType == null) {
          _showErrorSnackBar(
              'Please select listing type (For Sale or For Rent)');
          return false;
        }
        if (_priceController.text.trim().isEmpty) {
          _showErrorSnackBar('Please enter a price');
          return false;
        }
        return true;
      case 3:
        if (_selectedImages.isEmpty) {
          _showErrorSnackBar('Please add at least one photo');
          return false;
        }
        if (_descriptionController.text.trim().length < 50) {
          _showErrorSnackBar('Description must be at least 50 characters');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveDraft() {
    setState(() => _isDraftSaved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Draft saved successfully'),
        backgroundColor: AppTheme.successLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _submitListing() {
    if (_formKey.currentState?.validate() ?? false) {
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.successLight.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.successLight,
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'Success!',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.successLight,
                ),
              ),
            ],
          ),
          content: Text(
            'Your property listing has been created successfully. It will be reviewed and published within 24 hours.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _createAnotherListing();
              },
              child: const Text('Create Another'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/property-browse-screen',
                  (route) => false,
                );
              },
              child: const Text('View Listings'),
            ),
          ],
        ),
      );
    }
  }

  void _createAnotherListing() {
    setState(() {
      _currentStep = 0;
      _selectedPropertyType = null;
      _selectedAddress = null;
      _selectedLocation = null;
      _listingType = null;
      _selectedAmenities.clear();
      _selectedImages.clear();
      _isDraftSaved = false;
    });

    _titleController.clear();
    _priceController.clear();
    _bedroomsController.clear();
    _bathroomsController.clear();
    _areaController.clear();
    _descriptionController.clear();

    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previewListing() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 10.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preview Listing',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedImages.isNotEmpty)
                      Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CustomImageWidget(
                            imageUrl: kIsWeb
                                ? _selectedImages.first.path
                                : 'file://${_selectedImages.first.path}',
                            width: double.infinity,
                            height: 25.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(height: 3.h),
                    Text(
                      _titleController.text.isNotEmpty
                          ? _titleController.text
                          : 'Property Title',
                      style: AppTheme.lightTheme.textTheme.headlineSmall,
                    ),
                    SizedBox(height: 1.h),
                    if (_selectedAddress != null)
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'location_on',
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Text(
                              _selectedAddress!,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 2.h),
                    if (_priceController.text.isNotEmpty)
                      Text(
                        '\$${_priceController.text}${_listingType == 'For Rent' ? '/month' : ''}',
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(height: 3.h),
                    if (_descriptionController.text.isNotEmpty) ...[
                      Text(
                        'Description',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _descriptionController.text,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back_ios',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 20,
          ),
        ),
        title: Text(
          'Create Listing',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: _isDraftSaved ? 'check' : 'save',
                  color: _isDraftSaved
                      ? AppTheme.successLight
                      : AppTheme.lightTheme.colorScheme.primary,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  _isDraftSaved ? 'Saved' : 'Save Draft',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: _isDraftSaved
                        ? AppTheme.successLight
                        : AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ProgressIndicatorWidget(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
              stepTitles: _stepTitles,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Step 1: Basic Info
                  SingleChildScrollView(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Information',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Let\'s start with the basics of your property',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        PropertyTypeSelector(
                          selectedType: _selectedPropertyType,
                          onTypeSelected: (type) =>
                              setState(() => _selectedPropertyType = type),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Property Title *',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText:
                                'e.g., Beautiful 2BR Apartment in Downtown',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a property title';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  // Step 2: Location
                  SingleChildScrollView(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Property Location',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Help buyers and renters find your property',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        LocationPicker(
                          selectedAddress: _selectedAddress,
                          selectedLocation: _selectedLocation,
                          onLocationSelected: (address, location) {
                            setState(() {
                              _selectedAddress = address;
                              _selectedLocation = location;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Step 3: Property Details
                  SingleChildScrollView(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Property Details',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Provide detailed information about your property',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        PropertyDetailsForm(
                          priceController: _priceController,
                          bedroomsController: _bedroomsController,
                          bathroomsController: _bathroomsController,
                          areaController: _areaController,
                          listingType: _listingType,
                          onListingTypeChanged: (type) =>
                              setState(() => _listingType = type),
                          selectedAmenities: _selectedAmenities,
                          onAmenitiesChanged: (amenities) =>
                              setState(() => _selectedAmenities = amenities),
                        ),
                      ],
                    ),
                  ),

                  // Step 4: Photos & Description
                  SingleChildScrollView(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Photos & Description',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Showcase your property with great photos and description',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        PhotoUploadSection(
                          selectedImages: _selectedImages,
                          onImagesChanged: (images) =>
                              setState(() => _selectedImages = images),
                        ),
                        SizedBox(height: 4.h),
                        DescriptionInput(
                          controller: _descriptionController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom navigation
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          child: const Text('Previous'),
                        ),
                      ),
                    if (_currentStep > 0) SizedBox(width: 4.w),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        child: Text(_currentStep == _totalSteps - 1
                            ? 'Create Listing'
                            : 'Next'),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    if (_currentStep == _totalSteps - 1)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previewListing,
                          child: const Text('Preview'),
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
