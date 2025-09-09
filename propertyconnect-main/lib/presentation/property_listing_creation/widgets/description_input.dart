import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DescriptionInput extends StatefulWidget {
  final TextEditingController controller;

  const DescriptionInput({
    super.key,
    required this.controller,
  });

  @override
  State<DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  final int maxLength = 1000;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCharacterCount);
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentLength = widget.controller.text.length;
    final remainingChars = maxLength - currentLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Description *',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),

        // Tips container
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'lightbulb_outline',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Tips for a great description:',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                '• Highlight unique features and recent upgrades\n'
                '• Mention nearby amenities and transportation\n'
                '• Describe the neighborhood and lifestyle\n'
                '• Include move-in details and requirements',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 3.h),

        // Description input
        TextFormField(
          controller: widget.controller,
          maxLines: 8,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText:
                'Describe your property in detail. Include features, location benefits, and what makes it special...',
            counterText: '',
            contentPadding: EdgeInsets.all(4.w),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please provide a property description';
            }
            if (value.trim().length < 50) {
              return 'Description should be at least 50 characters';
            }
            return null;
          },
        ),

        SizedBox(height: 1.h),

        // Character count
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum 50 characters required',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: currentLength < 50
                    ? AppTheme.errorLight
                    : AppTheme.successLight,
              ),
            ),
            Text(
              '$remainingChars characters remaining',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: remainingChars < 100
                    ? AppTheme.warningLight
                    : AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
