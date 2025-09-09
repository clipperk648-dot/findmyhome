import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyLocationSection extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;
  final List<Map<String, dynamic>> nearbyPlaces;

  const PropertyLocationSection({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.nearbyPlaces,
  });

  @override
  State<PropertyLocationSection> createState() =>
      _PropertyLocationSectionState();
}

class _PropertyLocationSectionState extends State<PropertyLocationSection> {
  GoogleMapController? _mapController;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: const MarkerId('property'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: InfoWindow(
          title: 'Property Location',
          snippet: widget.address,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Address
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                size: 20,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  widget.address,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Map Container
          Container(
            height: 25.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude, widget.longitude),
                  zoom: 15.0,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
            ),
          ),

          if (widget.nearbyPlaces.isNotEmpty) ...[
            SizedBox(height: 3.h),
            Text(
              'Nearby Places',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),

            // Nearby Places List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.nearbyPlaces.length > 5
                  ? 5
                  : widget.nearbyPlaces.length,
              separatorBuilder: (context, index) => SizedBox(height: 1.h),
              itemBuilder: (context, index) {
                final place = widget.nearbyPlaces[index];
                return _buildNearbyPlaceItem(
                  icon: place['icon'] as String,
                  name: place['name'] as String,
                  distance: place['distance'] as String,
                  type: place['type'] as String,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNearbyPlaceItem({
    required String icon,
    required String name,
    required String distance,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: icon,
              size: 20,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  type,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
