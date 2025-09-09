import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LocationPicker extends StatefulWidget {
  final String? selectedAddress;
  final LatLng? selectedLocation;
  final Function(String, LatLng) onLocationSelected;

  const LocationPicker({
    super.key,
    required this.selectedAddress,
    required this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _addressController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng _currentLocation =
      const LatLng(37.7749, -122.4194); // Default to San Francisco
  bool _isLoadingLocation = false;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.selectedAddress ?? '';
    if (widget.selectedLocation != null) {
      _currentLocation = widget.selectedLocation!;
      _updateMarker(_currentLocation);
    }
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    if (kIsWeb) {
      // For web, use a default location or browser geolocation
      return;
    }

    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _updateMarker(_currentLocation);
        _isLoadingLocation = false;
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentLocation),
        );
      }
    } catch (e) {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _updateMarker(LatLng location) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: location,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      };
    });
  }

  void _onMapTap(LatLng location) {
    _updateMarker(location);
    _currentLocation = location;

    // Simulate reverse geocoding for address
    final address =
        '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
    _addressController.text = address;

    widget.onLocationSelected(address, location);
  }

  void _showMapPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
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
                    'Select Location',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Done',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation,
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    onTap: _onMapTap,
                    markers: _markers,
                    myLocationEnabled: !kIsWeb,
                    myLocationButtonEnabled: !kIsWeb,
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Location *',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
            hintText: 'Enter property address',
            suffixIcon: GestureDetector(
              onTap: _showMapPicker,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 20,
                ),
              ),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              // Simulate geocoding for demo
              widget.onLocationSelected(value, _currentLocation);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter property address';
            }
            return null;
          },
        ),
        if (_isLoadingLocation) ...[
          SizedBox(height: 2.h),
          Row(
            children: [
              SizedBox(
                width: 4.w,
                height: 4.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'Getting current location...',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
