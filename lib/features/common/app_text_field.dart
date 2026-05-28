import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/enums.dart';
import '../../../utils/app_dimensions.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final String? helpText;
  final Function(String)? onTextChanged;
  final Function()? onFocusLoss;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final bool? isEnable;
  final bool? isRequired;
  final int? maxLength;
  final String? label;
  final bool? obscureText;
  final String? initialValue;
  final int? maxLines;
  final bool? isCurrency;
  final bool? isPercentage;
  final bool? hideTitle;
  final FocusNode? focusNode;
  final FilterType? filterType;
  final Function(String)? onSubmit;
  final TextInputFormatter? textInputFormatter;
  final GlobalKey<FormFieldState>? fieldKey;
  final bool? hasInnerShadow;
  final double? height;
  final TextAlign? textAlign;
  final String? errorText;

  AppTextField({
    this.controller,
    this.height,
    this.hint,
    this.helpText,
    this.label,
    this.isRequired = false,
    this.hideTitle = false,
    this.maxLength = 250,
    this.maxLines = 1,
    this.onTextChanged,
    this.onFocusLoss,
    this.inputType,
    this.focusNode,
    this.validator,
    this.onSubmit,
    this.initialValue,
    this.filterType,
    this.isEnable = true,
    this.obscureText = false,
    this.isCurrency = false,
    this.isPercentage = false,
    this.textInputFormatter,
    this.fieldKey,
    this.prefixIcon,
    this.suffixIcon,
    this.hasInnerShadow = false,
    this.textAlign,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  int totalCount = 0;
  TextEditingController? _controller;
  FocusNode? _focusNode;
  GlobalKey<FormFieldState>? fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      if (widget.initialValue != null) {
        widget.controller!.text = widget.initialValue!;
      }
      _controller = widget.controller;
    } else {
      if (widget.initialValue != null) {
        _controller = TextEditingController(text: widget.initialValue);
      } else {
        _controller = TextEditingController();
      }
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode;
    } else {
      _focusNode = FocusNode();
    }

    _focusNode!.addListener(() {
      if (!_focusNode!.hasFocus) {
        if (widget.onFocusLoss != null) {
          widget.onFocusLoss!();
        }
      }
    });

    if (widget.fieldKey != null) {
      fieldKey = widget.fieldKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get direction from AppDirectionProvider
    bool isRTL = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hideTitle != null && !widget.hideTitle!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: (widget.label != null ? widget.label! : ''),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimensions.kFontSize14,
                      height: AppDimensions.kLineHeight14(22),
                      letterSpacing: AppDimensions.kLetterSpacing14(0),
                      color: widget.isEnable == true
                          ? AppColors.initColors().nonChangeBlack
                          : AppColors.initColors().nonChangeBlack.withOpacity(
                              0.4,
                            ),
                    ),
                    children: [
                      TextSpan(
                        text: widget.isRequired! ? ' *' : '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: AppDimensions.kFontSize16,
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
              ),
            ],
          ),
        SizedBox(height: 4.h),
        // Container with inset shadow wrapping TextFormField
        TextFormField(
          textAlign: widget.textAlign ?? TextAlign.start,
          onChanged: (text) {
            if (widget.isCurrency!) {
              int commaCount = text.split(',').length - 1;
              int dotCount = text.split('.').length - 1;
              setState(() {
                totalCount = commaCount + dotCount;
              });
            }
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(text);
            }
          },
          key: fieldKey,
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: (value) {
            if (widget.onSubmit != null) widget.onSubmit!(value);
          },
          focusNode: _focusNode,
          controller: _controller,
          obscureText: widget.obscureText!,
          enabled: widget.isEnable,
          maxLines: widget.maxLines,
          textCapitalization: TextCapitalization.sentences,
          maxLength: widget.isCurrency!
              ? widget.maxLength != null
                    ? widget.maxLength! + totalCount
                    : null
              : widget.maxLength,
          inputFormatters: [
            if (widget.isPercentage!) _percentageFormatter(),
            if (widget.isCurrency!)
              CurrencyTextInputFormatter.currency(symbol: ''),
            if (widget.textInputFormatter != null) widget.textInputFormatter!,
            if (widget.filterType == FilterType.TYPE1)
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]*$')),
            if (widget.filterType == FilterType.TYPE2)
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            if (widget.filterType == FilterType.TYPE3)
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
            if (widget.filterType == FilterType.TYPE4)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            if (widget.filterType == FilterType.TYPE5)
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            if (widget.filterType == FilterType.TYPE6)
              FilteringTextInputFormatter.allow(RegExp(r'[^\d]')),
            if (widget.filterType == FilterType.TYPE7)
              FilteringTextInputFormatter.deny(RegExp(r'[^\w.@+-]')),
            if (widget.filterType == FilterType.TYPE8)
              _NoLeadingSpecialOrSpaceFormatter(),
            if (widget.filterType == FilterType.TYPE9)
              _NoLeadingSpacesFormatter(),
          ],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppDimensions.kFontSize14,
            height: AppDimensions.kLineHeight14(22),
            letterSpacing: AppDimensions.kLetterSpacing14(-2.5),
            color: widget.isEnable == true
                ? AppColors.initColors().nonChangeBlack
                : AppColors.initColors().nonChangeBlack.withOpacity(0.4),
          ),
          keyboardType: widget.inputType ?? TextInputType.text,
          decoration: InputDecoration(
            // RTL-friendly padding
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            isDense: true,
            counterText: "",
            errorText: widget.errorText,
            errorStyle: TextStyle(
              height: 1,
              fontSize: 12,
              color: AppColors.initColors().errorColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().errorColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().errorColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.initColors().textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: BoxConstraints(minWidth: 25.w),
            suffixIconConstraints: BoxConstraints(minWidth: 25.w),
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: AppColors.initColors().nonChangeWhite,
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppDimensions.kFontSize14,
              color: widget.isEnable == true
                  ? AppColors.initColors().nonChangeBlack.withOpacity(0.2)
                  : AppColors.initColors().nonChangeBlack.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}

class _NoLeadingSpecialOrSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    // If first character is not a letter, reject the change
    if (!RegExp(r'^[a-zA-Z]').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}

class _NoLeadingSpacesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Allow empty text
    if (text.isEmpty) return newValue;

    // If first character is a space, reject the change
    if (text.startsWith(' ')) {
      return oldValue;
    }

    return newValue;
  }
}

TextInputFormatter _percentageFormatter() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    final text = newValue.text;

    // Allow empty input
    if (text.isEmpty) return newValue;

    // Disallow multiple leading zeros (but allow '0' or '0.x')
    if (text.length > 1 && text.startsWith('0') && !text.startsWith('0.')) {
      return oldValue;
    }

    final numValue = double.tryParse(text);
    if (numValue != null && numValue > 100) {
      return oldValue; // Reject if more than 100
    }

    return newValue; // Accept
  });
}
