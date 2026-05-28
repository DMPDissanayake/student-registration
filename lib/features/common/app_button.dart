import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';

class AppButtonController extends ChangeNotifier {
  static final List<AppButtonController> _controllers = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Timer? _timer;
  int _secondsRemaining = 0;
  int get secondsRemaining => _secondsRemaining;

  bool get isDisabledByTimer => _secondsRemaining > 0;

  AppButtonController() {
    _controllers.add(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controllers.remove(this);
    super.dispose();
  }

  void disposeController() {
    _timer?.cancel();
    _controllers.remove(this);
  }

  void startCountdown(int seconds) {
    _timer?.cancel();
    _secondsRemaining = seconds;
    if (_isLoading) {
      _isLoading = false;
    }
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _timer = null;
        notifyListeners();
      }
    });
  }

  void startLoading() {
    _timer?.cancel();
    _secondsRemaining = 0;
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  static void stopAllLoading() {
    for (var controller in _controllers) {
      controller.stopLoading();
    }
  }
}

class AppButton extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final double? height;
  final ButtonType buttonType;
  final Widget? prefixIcon;
  final Widget? suffixIcons;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final AppButtonController? controller; // ✅ New controller
  final Widget? loadingWidget;

  AppButton({
    super.key,
    required this.buttonText,
    required this.onTapButton,
    this.width = 0,
    this.height,
    this.prefixIcon,
    this.suffixIcons,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.controller,
    this.loadingWidget,
    this.buttonType = ButtonType.ENABLED,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = widget.controller?.isLoading ?? false;
    final bool isDisabledByTimer =
        widget.controller?.isDisabledByTimer ?? false;
    final bool isTappable =
        widget.buttonType == ButtonType.ENABLED &&
        !isLoading &&
        !isDisabledByTimer;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (isTappable) {
          widget.onTapButton();
        }
      },
      child: MiddleContainer(widget: widget, isLoading: isLoading),
    );
  }
}

class MiddleContainer extends StatelessWidget {
  const MiddleContainer({
    super.key,
    required this.widget,
    required this.isLoading,
  });

  final AppButton widget;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final bool isDisabledByTimer = controller?.isDisabledByTimer ?? false;
    final bool isEffectivelyEnabled =
        widget.buttonType == ButtonType.ENABLED && !isDisabledByTimer;

    Color getButtonColor() {
      if (widget.buttonColor != null) {
        return isEffectivelyEnabled
            ? widget.buttonColor!
            : AppColors.initColors().desabledAppButtonColor;
      }
      return isEffectivelyEnabled
          ? AppColors.initColors().appButtonColor
          : AppColors.initColors().desabledAppButtonColor;
    }

    Color getTextColor() {
      if (widget.textColor != null) {
        return isEffectivelyEnabled
            ? widget.textColor!
            : AppColors.initColors().nonChangeWhite;
      }
      return isEffectivelyEnabled
          ? AppColors.initColors().nonChangeWhite
          : AppColors.initColors().nonChangeWhite;
    }

    return Container(
      height: widget.height ?? 56.h,
      width: widget.width == 0 ? double.infinity : widget.width,
      decoration: BoxDecoration(
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!)
            : null,
        color: getButtonColor(),
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      child: Center(
        child: isLoading
            ? widget.loadingWidget ??
                  Lottie.asset(
                    AppImages.loadingLottieAnimation,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.contain,
                  )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.prefixIcon ?? const SizedBox.shrink(),
                  widget.prefixIcon != null
                      ? SizedBox(width: 10.w)
                      : const SizedBox.shrink(),
                  Flexible(
                    child: (isDisabledByTimer && controller != null)
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    widget.fontSize ??
                                    AppDimensions.kFontSize16,
                                height: AppDimensions.kLineHeight14(24),
                                letterSpacing: AppDimensions.kLetterSpacing14(
                                  -2.5,
                                ),
                                color: getTextColor(),
                              ),
                              children: <TextSpan>[
                                TextSpan(text: '${widget.buttonText} '),
                                TextSpan(
                                  text: '${controller.secondsRemaining}s',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    height: 22 / 14,
                                    letterSpacing: 0.3,
                                    color:
                                        AppColors.initColors().nonChangeWhite,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            widget.buttonText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  widget.fontSize ?? AppDimensions.kFontSize16,
                              height: 1.5,
                              letterSpacing: -0.4,
                              color: getTextColor(),
                            ),
                          ),
                  ),
                  widget.suffixIcons != null
                      ? SizedBox(width: 5.w)
                      : const SizedBox.shrink(),
                  widget.suffixIcons ?? const SizedBox.shrink(),
                ],
              ),
      ),
    );
  }
}
