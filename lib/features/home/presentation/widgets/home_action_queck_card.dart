import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class HomeActionQueckCard extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  const HomeActionQueckCard({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.initColors().nonChangeWhite,
          border: Border.all(
            width: 0.5.w,
            color: AppColors.initColors().primaryColor,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.initColors().nonChangeBlack.withOpacity(0.05),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.initColors().primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 25.h,
                    height: 25.h,
                    color: AppColors.initColors().primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
