import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class StudentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool isGoBackEnabled;
  final Color? textAndButtonColors;
  final Color? subTitleBgColor;
  final GlobalKey<State<StatefulWidget>>? moreKey;

  const StudentAppBar({
    super.key,
    this.title = '',
    this.subTitle,
    this.actions,
    this.isGoBackEnabled = true,
    this.onBackPressed,
    this.textAndButtonColors,
    this.moreKey,
    this.subTitleBgColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(65.h);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.initColors().nonChangeWhite,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isGoBackEnabled)
                    LoginBackIcon()
                  else
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                textAndButtonColors ??
                                AppColors.initColors().primaryColor,
                            fontWeight: FontWeight.w600,
                            height: AppDimensions.kLineHeight16(24),
                            letterSpacing: AppDimensions.kLetterSpacing16(0),
                            fontSize: AppDimensions.kFontSize20,
                          ),
                        ),
                        if (subTitle != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 14.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color:
                                    subTitleBgColor ??
                                    AppColors.initColors().nonChangeBlack,
                              ),
                              child: Text(
                                subTitle!,
                                style: TextStyle(
                                  fontSize: AppDimensions.kFontSize14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing:
                                      -0.04 * AppDimensions.kFontSize14,
                                  color: AppColors.initColors().nonChangeWhite,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (actions != null)
                    Row(mainAxisSize: MainAxisSize.min, children: actions!)
                  else
                    SizedBox(width: 48.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBackIcon extends StatelessWidget {
  const LoginBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(10.w),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.transparent,
          border: Border.all(
            width: 1,
            color: AppColors.initColors().primaryColor,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.initColors().primaryColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
