import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class AppMobileNumberController extends ChangeNotifier {
  String? countryCode;

  onChangeCountryCode(String countryCode) {
    this.countryCode = countryCode;
    notifyListeners();
  }
}

class AppMobileNumberField extends StatefulWidget {
  String? initialCountryCode;
  Function(PhoneNumber, int) onChange;
  Function(String)? onCountryChange;
  FocusNode? focusNode;
  bool? isRequired;
  bool isDisabled;
  String? error;
  String? label;
  bool? hideTitle;
  String? helpText;
  final double? borderRadius;
  final String? hint;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  TextEditingController controller;
  AppMobileNumberController? appMobileNumberController;

  AppMobileNumberField({
    this.initialCountryCode,
    required this.onChange,
    this.error,
    this.onCountryChange,
    this.focusNode,
    this.isRequired = false,
    this.isDisabled = false,
    this.label,
    this.hideTitle = false,
    this.helpText,
    this.borderRadius,
    this.hint,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.controller,
    required this.appMobileNumberController,
  });

  @override
  State<AppMobileNumberField> createState() => _AppMobileNumberFieldState();
}

class _AppMobileNumberFieldState extends State<AppMobileNumberField> {
  var _countryCode = CountryCode(
    name: 'Sri Lanka',
    code: 'LK',
    dialCode: '+94',
  );
  int maxLength = 10;
  late Country _selectedCountry;
  FocusNode? _focusNode;
  bool _isFocused = false;

  getDialCode(String countryCode) {
    Country country = countries.firstWhere(
      (element) => element.code == countryCode.toUpperCase(),
    );
    maxLength = country.maxLength;
    _selectedCountry = country;
    try {
      widget.controller.text = widget.controller.text.substring(0, maxLength);
    } catch (e) {}
    _countryCode = CountryCode(
      name: country.name,
      dialCode: country.dialCode,
      code: country.code,
    );
  }

  void _handleCountryControllerChange() {
    if (!mounted) return;
    if (widget.appMobileNumberController?.countryCode == null) return;
    setState(() {
      Country country = countries.firstWhere(
        (element) =>
            element.code ==
            widget.appMobileNumberController!.countryCode!.toUpperCase(),
        orElse: () => countries.first,
      );
      maxLength = country.maxLength;
      _selectedCountry = country;
      try {
        widget.controller.text = widget.controller.text.substring(0, maxLength);
      } catch (e) {}
      _countryCode = CountryCode(
        name: country.name,
        dialCode: country.dialCode,
        code: country.code,
      );
    });
  }

  void _handleFocusChange() {
    if (!mounted) return;
    setState(() {
      _isFocused = _focusNode!.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      getDialCode(widget.initialCountryCode!);
    } else {
      _selectedCountry = countries.firstWhere(
        (element) => element.code == 'LK',
      );
      maxLength = _selectedCountry.maxLength;
    }

    if (widget.appMobileNumberController != null) {
      widget.appMobileNumberController!.addListener(
        _handleCountryControllerChange,
      );
    }
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode;
    } else {
      _focusNode = FocusNode();
    }
    _focusNode!.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant AppMobileNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appMobileNumberController !=
        oldWidget.appMobileNumberController) {
      oldWidget.appMobileNumberController?.removeListener(
        _handleCountryControllerChange,
      );
      widget.appMobileNumberController?.addListener(
        _handleCountryControllerChange,
      );
    }
  }

  @override
  void dispose() {
    widget.appMobileNumberController?.removeListener(
      _handleCountryControllerChange,
    );
    _focusNode?.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.initColors();
    bool isEnable = !widget.isDisabled;
    bool hasError = widget.error != null && widget.error!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hideTitle != null && !widget.hideTitle!)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
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
                        color: isEnable == true
                            ? appColors.nonChangeBlack
                            : appColors.nonChangeBlack.withOpacity(0.4),
                      ),
                      children: [
                        TextSpan(
                          text: widget.isRequired! ? ' *' : '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AppDimensions.kFontSize14,
                            color: isEnable == true
                                ? appColors.nonChangeBlack
                                : appColors.nonChangeBlack.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        TextFormField(
          onChanged: (number) {
            final phone = PhoneNumber(
              countryISOCode: _countryCode.code ?? '',
              countryCode:
                  '+${_countryCode.dialCode?.replaceAll('+', '') ?? ''}',
              number: widget.controller.text,
            );
            widget.onChange(phone, _selectedCountry.minLength);
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          enabled: !widget.isDisabled,
          focusNode: widget.focusNode,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: maxLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppDimensions.kFontSize16,
            height: AppDimensions.kLineHeight14(18),
            letterSpacing: AppDimensions.kLetterSpacing14(-2.5),
            color: appColors.nonChangeBlack,
          ),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            isDense: true,
            counterText: "",
            errorText: widget.error,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColors.textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColors.textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.errorColor, width: 1.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors.errorColor, width: 1.w),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColors.textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColors.textFildeColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            ),
            prefixIcon:
                widget.prefixIcon ??
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+94',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.kFontSize16,
                          height: AppDimensions.kLineHeight14(18),
                          letterSpacing: AppDimensions.kLetterSpacing14(-2.5),
                          color: appColors.nonChangeBlack,
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
            prefixIconConstraints: BoxConstraints(minWidth: 25.w),
            suffixIconConstraints: BoxConstraints(minWidth: 25.w),
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: widget.fillColor ?? appColors.nonChangeWhite,
            hintText: widget.hint ?? 'Enter your mobile number',
            errorStyle: TextStyle(
              color: appColors.errorColor,
              fontSize: AppDimensions.kFontSize12,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: AppDimensions.kFontSize16,
              height: 1.0,
              letterSpacing: -0.2,
              color: appColors.textFildeColor.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}
