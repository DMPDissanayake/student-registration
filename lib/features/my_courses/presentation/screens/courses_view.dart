import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../bloc/my_courses_bloc.dart';
import '../bloc/my_courses_event.dart';
import '../bloc/my_courses_state.dart';
import '../widgets/registered_course_card.dart';

class CourseView extends StatefulWidget {
  final Function(int, {dynamic data}) onChangeTab;
  final dynamic data;
  const CourseView({super.key, required this.onChangeTab, this.data});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: colors.nonChangeWhite,
      body: BlocProvider.value(
        value: context.read<MyCoursesBloc>()
          ..add(FetchMyCourses(userId: userId)),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'My Enrolled Courses',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppDimensions.kFontSize18,
                                  color: colors.nonChangeBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildStateContent(state),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStateContent(MyCoursesState state) {
    if (state is MyCoursesLoading) {
      return _buildShimmerLoading();
    } else if (state is MyCoursesLoaded) {
      if (state.registrations.isEmpty) {
        return Center(
          child: Column(
            children: [
              Lottie.asset(
                AppImages.loadingLottieAnimation,
                width: 150.w,
                height: 150.w,
              ),
              const Text('You have not registered for any courses yet.'),
            ],
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.registrations.length,
        itemBuilder: (context, index) {
          final registration = state.registrations[index];
          return RegisteredCourseCard(registration: registration);
        },
      );
    } else if (state is MyCoursesError) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('Failed to load enrolled courses.'));
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          5,
          (index) => Container(
            width: double.infinity,
            height: 120.h,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }
}
