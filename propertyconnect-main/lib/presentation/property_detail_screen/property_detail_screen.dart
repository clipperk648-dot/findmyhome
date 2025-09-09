import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/fullscreen_image_gallery.dart';
import './widgets/landlord_contact_section.dart';
import './widgets/property_action_bar.dart';
import './widgets/property_amenities_section.dart';
import './widgets/property_description_section.dart';
import './widgets/property_header_info.dart';
import './widgets/property_image_gallery.dart';
import './widgets/property_location_section.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({super.key});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  bool _isFavorite = false;
  bool _isLoading = false;
  late ScrollController _scrollController;

  // Mock property data
  final Map<String, dynamic> _propertyData = {
    "id": 1,
    "title": "Modern Downtown Apartment",
    "price": "\$2,500/month",
    "address": "123 Main Street, Downtown, New York, NY 10001",
    "bedrooms": 2,
    "bathrooms": 2,
    "squareFootage": "1,200",
    "propertyType": "Apartment",
    "description":
        """This stunning modern apartment offers the perfect blend of luxury and convenience in the heart of downtown. Featuring floor-to-ceiling windows with breathtaking city views, the open-concept living space is bathed in natural light throughout the day.

The gourmet kitchen boasts stainless steel appliances, granite countertops, and custom cabinetry. The master bedroom includes a walk-in closet and en-suite bathroom with premium fixtures. Additional amenities include in-unit laundry, central air conditioning, and a private balcony overlooking the city skyline.

Located just steps away from public transportation, fine dining, shopping, and entertainment venues. This is urban living at its finest, perfect for professionals seeking a sophisticated lifestyle in the city center.""",
    "images": [
      "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80",
      "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&q=80",
      "https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&q=80",
      "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&q=80",
      "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800&q=80",
    ],
    "amenities": [
      {"icon": "wifi", "name": "High-Speed WiFi", "available": true},
      {"icon": "local_parking", "name": "Parking Space", "available": true},
      {"icon": "fitness_center", "name": "Fitness Center", "available": true},
      {"icon": "pool", "name": "Swimming Pool", "available": true},
      {"icon": "security", "name": "24/7 Security", "available": true},
      {"icon": "elevator", "name": "Elevator Access", "available": true},
      {"icon": "pets", "name": "Pet Friendly", "available": false},
      {
        "icon": "local_laundry_service",
        "name": "Laundry Service",
        "available": true
      },
    ],
    "latitude": 40.7589,
    "longitude": -73.9851,
    "nearbyPlaces": [
      {
        "icon": "train",
        "name": "Metro Station",
        "distance": "0.2 mi",
        "type": "Transportation"
      },
      {
        "icon": "local_grocery_store",
        "name": "Whole Foods Market",
        "distance": "0.3 mi",
        "type": "Grocery"
      },
      {
        "icon": "school",
        "name": "NYU Campus",
        "distance": "0.5 mi",
        "type": "Education"
      },
      {
        "icon": "local_hospital",
        "name": "Mount Sinai Hospital",
        "distance": "0.8 mi",
        "type": "Healthcare"
      },
      {
        "icon": "restaurant",
        "name": "The Plaza Restaurant",
        "distance": "0.4 mi",
        "type": "Dining"
      },
    ],
    "landlord": {
      "name": "Sarah Johnson",
      "profileImage":
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400&q=80",
      "rating": 4.8,
      "reviewCount": 127,
      "isVerified": true,
      "memberSince": "2019",
      "phone": "+1 (555) 123-4567",
    },
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = (_propertyData['images'] as List).cast<String>();
    final amenities =
        (_propertyData['amenities'] as List).cast<Map<String, dynamic>>();
    final nearbyPlaces =
        (_propertyData['nearbyPlaces'] as List).cast<Map<String, dynamic>>();
    final landlordInfo = _propertyData['landlord'] as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Custom App Bar with Image Gallery
              SliverAppBar(
                expandedHeight: 30.h,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: CustomIconWidget(
                      iconName: 'arrow_back_ios',
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName: 'share',
                        size: 20,
                        color: Colors.white,
                      ),
                      onPressed: _shareProperty,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName: _isFavorite ? 'favorite' : 'favorite_border',
                        size: 20,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: PropertyImageGallery(
                    images: images,
                    onFullscreenTap: () => _showFullscreenGallery(images),
                  ),
                ),
              ),

              // Property Content
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Property Header Info
                    PropertyHeaderInfo(
                      price: _propertyData['price'] as String,
                      address: _propertyData['address'] as String,
                      bedrooms: _propertyData['bedrooms'] as int,
                      bathrooms: _propertyData['bathrooms'] as int,
                      squareFootage: _propertyData['squareFootage'] as String,
                      propertyType: _propertyData['propertyType'] as String,
                    ),

                    Divider(
                      color: AppTheme.lightTheme.dividerColor
                          .withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),

                    // Property Description
                    PropertyDescriptionSection(
                      description: _propertyData['description'] as String,
                    ),

                    Divider(
                      color: AppTheme.lightTheme.dividerColor
                          .withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),

                    // Amenities Section
                    PropertyAmenitiesSection(
                      amenities: amenities,
                    ),

                    Divider(
                      color: AppTheme.lightTheme.dividerColor
                          .withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),

                    // Location Section
                    PropertyLocationSection(
                      latitude: _propertyData['latitude'] as double,
                      longitude: _propertyData['longitude'] as double,
                      address: _propertyData['address'] as String,
                      nearbyPlaces: nearbyPlaces,
                    ),

                    Divider(
                      color: AppTheme.lightTheme.dividerColor
                          .withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),

                    // Landlord Contact Section
                    LandlordContactSection(
                      landlordInfo: landlordInfo,
                      onContactTap: _contactLandlord,
                      onCallTap: _callLandlord,
                    ),

                    // Bottom padding for action bar
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),

          // Sticky Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PropertyActionBar(
              onContactLandlord: _contactLandlord,
              onScheduleViewing: _scheduleViewing,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    HapticFeedback.lightImpact();

    Fluttertoast.showToast(
      msg: _isFavorite ? 'Added to favorites' : 'Removed from favorites',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      textColor: AppTheme.lightTheme.colorScheme.onSurface,
    );
  }

  void _shareProperty() {
    HapticFeedback.lightImpact();

    Fluttertoast.showToast(
      msg: 'Property link copied to clipboard',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      textColor: AppTheme.lightTheme.colorScheme.onSurface,
    );

    Clipboard.setData(const ClipboardData(
      text:
          'Check out this amazing property: Modern Downtown Apartment - \$2,500/month',
    ));
  }

  void _showFullscreenGallery(List<String> images) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullscreenImageGallery(
          images: images,
          initialIndex: 0,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _contactLandlord() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Fluttertoast.showToast(
          msg: 'Message sent to landlord successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.successLight,
          textColor: Colors.white,
        );
      }
    });
  }

  void _callLandlord() {
    HapticFeedback.lightImpact();

    final phone = _propertyData['landlord']['phone'] as String;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Call Landlord',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Would you like to call ${_propertyData['landlord']['name']} at $phone?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Calling $phone...',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                textColor: AppTheme.lightTheme.colorScheme.onSurface,
              );
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void _scheduleViewing() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Schedule Viewing',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your viewing request has been sent to the landlord. They will contact you within 24 hours to confirm the appointment.',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.successLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.successLight.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        size: 20,
                        color: AppTheme.successLight,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'Viewing request submitted successfully',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.successLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Got it'),
              ),
            ],
          ),
        );
      }
    });
  }
}
