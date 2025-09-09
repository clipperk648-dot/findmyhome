import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PhotoUploadSection extends StatefulWidget {
  final List<XFile> selectedImages;
  final Function(List<XFile>) onImagesChanged;

  const PhotoUploadSection({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
  });

  @override
  State<PhotoUploadSection> createState() => _PhotoUploadSectionState();
}

class _PhotoUploadSectionState extends State<PhotoUploadSection> {
  final ImagePicker _picker = ImagePicker();
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _showCamera = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      if (!kIsWeb && await _requestCameraPermission()) {
        _cameras = await availableCameras();
        if (_cameras.isNotEmpty) {
          final camera = _cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
            orElse: () => _cameras.first,
          );

          _cameraController = CameraController(
            camera,
            kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
          );

          await _cameraController!.initialize();
          await _applySettings();

          if (mounted) {
            setState(() => _isCameraInitialized = true);
          }
        }
      }
    } catch (e) {
      // Handle camera initialization error silently
    }
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
      if (!kIsWeb) {
        await _cameraController!.setFlashMode(FlashMode.auto);
      }
    } catch (e) {
      // Handle settings error silently
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile photo = await _cameraController!.takePicture();
      List<XFile> updatedImages = List.from(widget.selectedImages);
      updatedImages.add(photo);
      widget.onImagesChanged(updatedImages);

      setState(() => _showCamera = false);
    } catch (e) {
      // Handle capture error silently
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        List<XFile> updatedImages = List.from(widget.selectedImages);
        updatedImages.addAll(images);

        // Limit to 20 images
        if (updatedImages.length > 20) {
          updatedImages = updatedImages.take(20).toList();
        }

        widget.onImagesChanged(updatedImages);
      }
    } catch (e) {
      // Handle gallery error silently
    }
  }

  void _removeImage(int index) {
    List<XFile> updatedImages = List.from(widget.selectedImages);
    updatedImages.removeAt(index);
    widget.onImagesChanged(updatedImages);
  }

  void _reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    List<XFile> updatedImages = List.from(widget.selectedImages);
    final XFile item = updatedImages.removeAt(oldIndex);
    updatedImages.insert(newIndex, item);
    widget.onImagesChanged(updatedImages);
  }

  Widget _buildCameraView() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
      );
    }

    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            CameraPreview(_cameraController!),
            Positioned(
              bottom: 4.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _showCamera = false),
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _capturePhoto,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: CustomIconWidget(
                        iconName: 'camera_alt',
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'photo_library',
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showCamera) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Photos *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          _buildCameraView(),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Property Photos *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${widget.selectedImages.length}/20',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),

        // Upload buttons
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _showCamera = true),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'camera_alt',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Camera',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
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
                onTap: _pickFromGallery,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'photo_library',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Gallery',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        if (widget.selectedImages.isNotEmpty) ...[
          SizedBox(height: 3.h),
          Text(
            'Selected Photos (Drag to reorder)',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 25.h,
            child: ReorderableListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.selectedImages.length,
              onReorder: _reorderImages,
              itemBuilder: (context, index) {
                final image = widget.selectedImages[index];
                return Container(
                  key: ValueKey(image.path),
                  width: 40.w,
                  margin: EdgeInsets.only(right: 3.w),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CustomImageWidget(
                          imageUrl:
                              kIsWeb ? image.path : 'file://${image.path}',
                          width: 40.w,
                          height: 25.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 1.h,
                        right: 2.w,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'close',
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      if (index == 0)
                        Positioned(
                          bottom: 1.h,
                          left: 2.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Cover',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
