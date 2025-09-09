import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PropertyImageGallery extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onFullscreenTap;

  const PropertyImageGallery({
    super.key,
    required this.images,
    this.onFullscreenTap,
  });

  @override
  State<PropertyImageGallery> createState() => _PropertyImageGalleryState();
}

class _PropertyImageGalleryState extends State<PropertyImageGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 30.h,
        width: double.infinity,
        color: AppTheme.lightTheme.colorScheme.surface,
        child: Center(
          child: CustomIconWidget(
            iconName: 'image',
            size: 48,
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.3),
          ),
        ),
      );
    }

    return Container(
      height: 30.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: widget.onFullscreenTap,
                child: Hero(
                  tag: 'property_image_$index',
                  child: CustomImageWidget(
                    imageUrl: widget.images[index],
                    width: double.infinity,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Page Indicators
          if (widget.images.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

          // Image Counter
          if (widget.images.length > 1)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${_currentIndex + 1}/${widget.images.length}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
