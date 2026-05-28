import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:student_registration/features/profile/presentation/bloc/profile_state.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    final String name = (state is ProfileLoaded)
                        ? state.profile.name
                        : 'User';
                    return Text(
                      'Hi, $name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.kFontSize24,
                        height: AppDimensions.kLineHeight14(20),
                        letterSpacing: AppDimensions.kLetterSpacing14(-1),
                        color: colors.primaryColor,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Text(
                      'Welcome back ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimensions.kFontSize14,
                        height: AppDimensions.kLineHeight14(20),
                        letterSpacing: AppDimensions.kLetterSpacing14(0),
                        color: colors.nonChangeBlack,
                      ),
                    ),
                    Image.asset(AppImages.imgHand),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primaryColor.withOpacity(0.1),
              image: DecorationImage(
                image: AssetImage(AppImages.pngProfile),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
