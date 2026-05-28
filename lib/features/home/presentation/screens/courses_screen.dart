// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:student_registration/features/common/snackbar_utils.dart';
// import 'package:student_registration/utils/app_colors.dart';
// import 'package:student_registration/features/home/presentation/bloc/courses_bloc.dart';
// import 'package:student_registration/features/home/presentation/bloc/courses_event.dart';
// import 'package:student_registration/features/home/presentation/bloc/courses_state.dart';
// import 'package:student_registration/utils/app_images.dart';
// import '../widgets/course_card.dart';

// class CoursesScreen extends StatefulWidget {
//   const CoursesScreen({super.key});

//   @override
//   State<CoursesScreen> createState() => _CoursesScreenState();
// }

// class _CoursesScreenState extends State<CoursesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<CoursesBloc>().add(FetchCourses());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Available Courses')),
//       body: BlocListener<CoursesBloc, CoursesState>(
//         listener: (context, state) {
//           if (state is CourseRegistrationSuccess) {
//             AppSnackBar.show(
//               context,
//               message: state.message,
//               backgroundColor: Colors.green,
//               textColor: AppColors.initColors().nonChangeWhite,
//             );
//             context.read<CoursesBloc>().add(FetchCourses());
//           } else if (state is CoursesError) {
//             AppSnackBar.show(
//               context,
//               message: state.message,
//               backgroundColor: AppColors.initColors().errorColor,
//               textColor: AppColors.initColors().nonChangeWhite,
//             );
//           }
//         },
//         child: BlocBuilder<CoursesBloc, CoursesState>(
//           builder: (context, state) {
//             if (state is CoursesLoading) {
//               return Center(
//                 child: Lottie.asset(
//                   AppImages.loadingLottieAnimation,
//                   width: 100.w,
//                   height: 100.w,
//                 ),
//               );
//             } else if (state is CoursesLoaded) {
//               if (state.courses.isEmpty) {
//                 return const Center(
//                   child: Text('No courses available at the moment.'),
//                 );
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(12.0),
//                 itemCount: state.courses.length,
//                 itemBuilder: (context, index) {
//                   final course = state.courses[index];
//                   return CourseCard(
//                     course: course,
//                     onTap: () => context.push('/course-detail', extra: course),
//                   );
//                 },
//               );
//             }
//             return const Center(child: Text('Load courses failed.'));
//           },
//         ),
//       ),
//     );
//   }
// }
