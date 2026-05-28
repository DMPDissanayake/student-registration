import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_registration/features/home/presentation/widgets/home_action_queck_card.dart';
import 'package:student_registration/features/home/presentation/widgets/home_baner.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/features/common/snackbar_utils.dart';
import 'package:student_registration/features/home/presentation/bloc/courses_bloc.dart';
import 'package:student_registration/features/home/presentation/bloc/courses_event.dart';
import 'package:student_registration/features/home/presentation/bloc/courses_state.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../widgets/course_card.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final Function(int, {dynamic data}) onChangeTab;
  final dynamic data;
  const HomeScreen({super.key, required this.onChangeTab, this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().add(FetchCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.initColors().primaryColor.withOpacity(0.05),
      body: BlocListener<CoursesBloc, CoursesState>(
        listener: (context, state) {
          if (state is CourseRegistrationSuccess) {
            AppSnackBar.show(
              context,
              message: state.message,
              backgroundColor: AppColors.initColors().successColor,
              textColor: AppColors.initColors().nonChangeWhite,
            );
            context.read<CoursesBloc>().add(FetchCourses());
          } else if (state is CoursesError) {
            AppSnackBar.show(
              context,
              message: state.message,
              backgroundColor: AppColors.initColors().errorColor,
              textColor: AppColors.initColors().nonChangeWhite,
            );
          }
        },
        child: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeAppBar(),
                    state is CoursesLoading
                        ? _buildShimmerLoading()
                        : _buildHomeContent(state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(CoursesState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          const HomeBaner(),
          SizedBox(height: 24.h),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomeActionQueckCard(
                      onTap: () => widget.onChangeTab(1),
                      icon: AppImages.svgCourses,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: HomeActionQueckCard(
                      onTap: () => widget.onChangeTab(2),
                      icon: AppImages.svgGrade,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              HomeActionQueckCard(
                onTap: () => widget.onChangeTab(3),
                icon: AppImages.svgProfile,
              ),
            ],
          ),

          SizedBox(height: 24.h),
          Text(
            'Available Courses',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.kFontSize18,
              color: AppColors.initColors().nonChangeBlack,
            ),
          ),
          SizedBox(height: 16.h),
          if (state is CoursesLoaded)
            state.courses.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          AppImages.loadingLottieAnimation,
                          width: 150.w,
                          height: 150.w,
                        ),
                        const Text('No courses available at the moment.'),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return CourseCard(
                        course: course,
                        onTap: () =>
                            context.push('/course-detail', extra: course),
                      );
                    },
                  )
          else
            const Center(child: Text('Load courses failed.')),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.initColors().nonChangeWhite,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Quick Actions Shimmer
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: AppColors.initColors().nonChangeWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: AppColors.initColors().nonChangeWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.initColors().nonChangeWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Section Title Shimmer
            Container(
              height: 20.h,
              width: 150.w,
              decoration: BoxDecoration(
                // Changed to BoxDecoration for borderRadius
                color: AppColors.initColors().nonChangeWhite,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Course List Shimmer
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.initColors().nonChangeWhite,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
