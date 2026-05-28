import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import '../../domain/entities/course_entity.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colors.nonChangeWhite.withOpacity(0.75),
        boxShadow: [
          BoxShadow(
            offset: Offset(4.w, 0),
            blurRadius: 24.r,
            spreadRadius: 0,
            color: colors.nonChangeBlack.withOpacity(0.12),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Vertical Accent Bar
              Container(
                width: 6.w,
                decoration: BoxDecoration(
                  color: colors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: colors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 14.sp,
                            color: colors.nonChangeBlack.withOpacity(0.5),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${course.code} • ${course.credits} Credits',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: colors.nonChangeBlack.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 14.sp,
                            color: colors.nonChangeBlack.withOpacity(0.5),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              course.instructor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: colors.nonChangeBlack.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: colors.primaryColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
