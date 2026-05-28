import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import '../../domain/entities/grade_entity.dart';

class GradeCard extends StatelessWidget {
  final GradeEntity gradeItem;

  const GradeCard({super.key, required this.gradeItem});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();

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
            color: colors.nonChangeBlack.withOpacity(0.05),
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
                      gradeItem.courseTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.kFontSize16,
                        color: colors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Assessment: ${gradeItem.assignmentName}',
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        color: colors.nonChangeBlack.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Marks: ${gradeItem.marks} / ${gradeItem.totalMarks}',
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize14,
                            color: colors.nonChangeBlack.withOpacity(0.6),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            gradeItem.grade,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.kFontSize16,
                              color: colors.primaryColor,
                            ),
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
