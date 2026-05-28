import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_dimensions.dart';

class AppSnackBar {
  /// Shows a customized SnackBar across the application.
  /// Pass [message], [backgroundColor], and [textColor] as requested.
  static void show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    // Removes any existing snackbars to show the new one immediately
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: AppDimensions.kFontSize14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
