import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import '../../domain/entities/registration_entity.dart';

class RegisteredCourseCard extends StatelessWidget {
  final RegistrationEntity registration;

  const RegisteredCourseCard({super.key, required this.registration});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    final formattedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(registration.registeredAt);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colors.nonChangeWhite,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 10.r,
            color: colors.nonChangeBlack.withOpacity(0.1),
          ),
        ],
      ),
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
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      registration.courseTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.kFontSize16,
                        color: colors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${registration.courseCode} • ${registration.courseCredits} Credits',
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        color: colors.nonChangeBlack.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Instructor: ${registration.instructor}',
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        color: colors.nonChangeBlack.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.kFontSize12,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        Text(
                          'Enrolled: $formattedDate',
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize12,
                            color: colors.nonChangeBlack.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
