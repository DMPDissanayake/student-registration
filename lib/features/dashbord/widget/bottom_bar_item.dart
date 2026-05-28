import 'package:student_registration/utils/app_dimensions.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors.dart';

class BottomBarItem extends StatelessWidget {
  final String selectedIcon;
  final VoidCallback onTap;
  final bool isSelected;
  final String? name;

  const BottomBarItem({
    super.key,
    required this.selectedIcon,
    required this.onTap,
    this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        // Using focusColor/highlightColor transparent to clean up the tap effect
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// --- This is the Top Border Indicator ---
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(
                bottom: 10.h,
              ), // Space between bar and icon
              height: 5.h, // Thickness of the line
              width: 35.w, // Width of the line
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.initColors().primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 2.h),
            SvgPicture.asset(
              selectedIcon,
              height: 25.h,
              color: isSelected
                  ? AppColors.initColors().primaryColor
                  : AppColors.initColors().bottomNavigationBarUnselectColor,
            ),
            SizedBox(height: 2.h),
            Text(
              name ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppDimensions.kFontSize11,
                letterSpacing: AppDimensions.kLetterSpacing12(-2.5),
                height: AppDimensions.kLineHeight12(18),
                color: isSelected
                    ? AppColors.initColors().primaryColor
                    : AppColors.initColors().bottomNavigationBarUnselectColor,
              ),
            ),
            // Added small padding at bottom to keep text from touching the edge
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
