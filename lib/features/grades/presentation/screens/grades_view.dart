import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import '../bloc/grades_bloc.dart';
import '../bloc/grades_event.dart';
import '../bloc/grades_state.dart';
import '../widgets/grade_card.dart';

class GradesView extends StatefulWidget {
  final Function(int, {dynamic data}) onChangeTab;
  final dynamic data;
  const GradesView({super.key, required this.onChangeTab, this.data});

  @override
  State<GradesView> createState() => _GradesViewState();
}

class _GradesViewState extends State<GradesView> {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: colors.nonChangeWhite,
      body: BlocProvider.value(
        value: context.read<GradesBloc>()..add(FetchGrades(userId: userId)),
        child: BlocBuilder<GradesBloc, GradesState>(
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
                                'My Academic Grades',
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

  Widget _buildStateContent(GradesState state) {
    if (state is GradesLoading) {
      return _buildShimmerLoading();
    } else if (state is GradesLoaded) {
      if (state.grades.isEmpty) {
        return Center(
          child: Column(
            children: [
              Lottie.asset(
                AppImages.loadingLottieAnimation,
                width: 150.w,
                height: 150.w,
              ),
              const Text('No grading records found.'),
            ],
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.grades.length,
        itemBuilder: (context, index) {
          final gradeItem = state.grades[index];
          return GradeCard(gradeItem: gradeItem);
        },
      );
    } else if (state is GradesError) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('Failed to load grades.'));
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
