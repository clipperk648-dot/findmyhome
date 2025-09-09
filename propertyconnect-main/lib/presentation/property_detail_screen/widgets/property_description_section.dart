import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PropertyDescriptionSection extends StatefulWidget {
  final String description;
  final int maxLines;

  const PropertyDescriptionSection({
    super.key,
    required this.description,
    this.maxLines = 3,
  });

  @override
  State<PropertyDescriptionSection> createState() =>
      _PropertyDescriptionSectionState();
}

class _PropertyDescriptionSectionState
    extends State<PropertyDescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.8),
                  ),
                  maxLines: widget.maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                if (_shouldShowReadMore())
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      child: Text(
                        'Read More',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.8),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = false;
                      });
                    },
                    child: Text(
                      'Read Less',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  bool _shouldShowReadMore() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.description,
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          height: 1.5,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: 92.w - (4.w * 2));
    return textPainter.didExceedMaxLines;
  }
}
