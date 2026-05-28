import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:student_registration/features/common/app_button.dart';
import 'package:student_registration/features/common/appbar.dart';
import 'package:student_registration/features/common/snackbar_utils.dart';
import 'package:student_registration/features/home/presentation/bloc/courses_state.dart';
import 'package:student_registration/features/home/presentation/widgets/home_baner.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import '../../domain/entities/course_entity.dart';
import '../bloc/courses_bloc.dart';
import '../bloc/courses_event.dart';

class CourseDetailView extends StatefulWidget {
  final CourseEntity course;

  const CourseDetailView({super.key, required this.course});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  final _buttonController = AppButtonController();

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: StudentAppBar(title: widget.course.title, isGoBackEnabled: true),
      backgroundColor: colors.whiteBackgroundColor,
      body: BlocListener<CoursesBloc, CoursesState>(
        listener: (context, state) {
          if (state is CoursesLoading) {
            _buttonController.startLoading();
          } else {
            _buttonController.stopLoading();
          }

          if (state is CourseRegistrationSuccess) {
            AppSnackBar.show(
              context,
              message: state.message,
              backgroundColor: colors.successColor,
              textColor: colors.nonChangeWhite,
            );
            context.pop();
          } else if (state is CoursesError) {
            AppSnackBar.show(
              context,
              message: state.message,
              backgroundColor: colors.errorColor,
              textColor: colors.nonChangeWhite,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              HomeBaner(),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.code,
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w600,
                        color: colors.primaryColor.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.course.title,
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize22,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _infoItem(
                          Icons.book_outlined,
                          '${widget.course.credits} Credits',
                        ),
                        SizedBox(width: 24.w),
                        _infoItem(
                          Icons.person_outline,
                          widget.course.instructor,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _infoItem(
                      Icons.calendar_today_outlined,
                      widget.course.schedule,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: AppDimensions.kFontSize18,
                  fontWeight: FontWeight.w700,
                  color: colors.nonChangeBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.course.description,
                    style: TextStyle(
                      fontSize: AppDimensions.kFontSize14,
                      color: colors.nonChangeBlack.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              //if (!widget.course.isEnrolled)
              AppButton(
                buttonText: 'Enroll in Course',
                controller: _buttonController,
                onTapButton: () {
                  context.read<CoursesBloc>().add(
                    RegisterInCourse(
                      userId: userId,
                      courseId: widget.course.courseId,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    final colors = AppColors.initColors();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: colors.primaryColor),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: AppDimensions.kFontSize14,
            fontWeight: FontWeight.w500,
            color: colors.nonChangeBlack.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
