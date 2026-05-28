import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileInfoCard({super.key, required this.profile});

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
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    // Profile Image
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.primaryColor.withOpacity(0.2),
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.pngProfile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      profile.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.kFontSize20,
                        color: colors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Details List
                    _buildDetailRow('Email', profile.email),
                    _buildDetailRow('Student ID', profile.studentId),
                    _buildDetailRow('Phone', profile.phone),
                    _buildDetailRow('Address', profile.address),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    final colors = AppColors.initColors();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppDimensions.kFontSize14,
                fontWeight: FontWeight.w600,
                color: colors.nonChangeBlack.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: AppDimensions.kFontSize14,
                fontWeight: FontWeight.w700,
                color: colors.nonChangeBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
