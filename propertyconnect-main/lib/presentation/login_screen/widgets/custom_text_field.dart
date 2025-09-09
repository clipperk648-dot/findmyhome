import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String iconName;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showError;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.iconName,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.showError = false,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? _obscureText : false,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: widget.iconName,
                    color: _isFocused
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 5.w,
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: CustomIconWidget(
                          iconName:
                              _obscureText ? 'visibility' : 'visibility_off',
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          size: 5.w,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 2.h,
                ),
              ),
            ),
          ),
        ),
        if (widget.showError && widget.errorText != null) ...[
          SizedBox(height: 0.5.h),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}
