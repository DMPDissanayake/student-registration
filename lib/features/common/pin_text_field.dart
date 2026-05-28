import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../../../../../utils/app_colors.dart';

class PinTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;
  final Function(String)? onTextChanged;
  final Function()? onFocusLoss;
  final String? Function(String?)? validator;
  final String? label;
  final bool isRequired; // Kept
  final String? error;
  final bool isEnable;
  final bool hideTitle;
  final FocusNode? focusNode;
  final String? helpText;
  final GlobalKey<FormFieldState>? fieldKey;
  final double? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final Color? fillColor;

  const PinTextField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onTextChanged,
    this.onFocusLoss,
    this.validator,
    this.label,
    this.isRequired = false,
    this.error,
    this.isEnable = true,
    this.hideTitle = false,
    this.focusNode,
    this.helpText,
    this.fieldKey,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.fillColor,
  });

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    widget.controller.addListener(_onControllerChange);
    _focusNode.addListener(_onFocusChange);
  }

  void _onControllerChange() {
    if (mounted) setState(() {});
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
    if (!_focusNode.hasFocus) {
      widget.onFocusLoss?.call();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildEyeIcon() {
    return GestureDetector(
      onTap: _toggleObscureText,
      child: Container(
        padding: EdgeInsets.all(12.w),
        child: Image.asset(
          !_obscureText ? AppImages.icVisible : AppImages.icVisibilityOff,
          color: AppColors.initColors().nonChangeBlack,
          height: 24.h,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: widget.fieldKey,
      validator: widget.validator,
      initialValue: widget.controller.text,
      builder: (FormFieldState<String> state) {
        final bool hasError = state.hasError || widget.error != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null && !widget.hideTitle) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.label!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimensions.kFontSize14,
                        color: AppColors.initColors().nonChangeBlack,
                      ),
                      children: [
                        TextSpan(
                          text: widget.isRequired ? ' *' : '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: AppDimensions.kFontSize14,
                            height: 1.0,
                            letterSpacing: -0.36,
                            color: widget.isEnable == true
                                ? AppColors.initColors().nonChangeBlack
                                : AppColors.initColors().nonChangeBlack
                                      .withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],
            TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.isEnable,
              obscureText: _obscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                isDense: true,
                counterText: "",
                errorText: null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: hasError
                        ? AppColors.initColors().errorColor
                        : AppColors.initColors().textFildeColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: hasError
                        ? AppColors.initColors().errorColor
                        : AppColors.initColors().textFildeColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.initColors().errorColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.initColors().errorColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.initColors().textFildeColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.initColors().textFildeColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 8.r,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(minWidth: 25.w),
                suffixIconConstraints: BoxConstraints(minWidth: 25.w),
                suffixIcon: widget.suffixIcon == null
                    ? _buildEyeIcon()
                    : widget.suffixIcon,
                filled: true,
                fillColor:
                    widget.fillColor ?? AppColors.initColors().nonChangeWhite,
                hintText: widget.hint ?? 'Enter your pin',
                errorStyle: TextStyle(
                  color: AppColors.initColors().errorColor,
                  fontSize: AppDimensions.kFontSize12,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppDimensions.kFontSize14,
                  height: 1.0,
                  letterSpacing: -0.2,
                  color: AppColors.initColors().nonChangeBlack.withOpacity(0.4),
                ),
              ),
              style: TextStyle(
                fontSize: AppDimensions.kFontSize16,
                fontWeight: FontWeight.w500,
                letterSpacing: 3,
                color: AppColors.initColors().nonChangeBlack,
              ),
              onChanged: (value) {
                state.didChange(value); // Update FormField state
                widget.onTextChanged?.call(value);
              },
            ),
            if (hasError && (state.errorText != null || widget.error != null))
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      state.errorText ?? widget.error!,
                      style: TextStyle(
                        color: AppColors.initColors().errorColor,
                        fontSize: AppDimensions.kFontSize12,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
