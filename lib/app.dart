import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'injection_container.dart';
import 'utils/app_navigation.dart';

// Import Blocs
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'package:student_registration/features/home/presentation/bloc/courses_bloc.dart';
import 'features/my_courses/presentation/bloc/my_courses_bloc.dart';
import 'features/grades/presentation/bloc/grades_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => sl<ProfileBloc>()),
        BlocProvider<CoursesBloc>(create: (_) => sl<CoursesBloc>()),
        BlocProvider<MyCoursesBloc>(create: (_) => sl<MyCoursesBloc>()),
        BlocProvider<GradesBloc>(create: (_) => sl<GradesBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Student Registration App',
            theme: ThemeData(
              primaryColor: AppColors.initColors().primaryColor,
              scaffoldBackgroundColor: AppColors.initColors().primaryColor,
              useMaterial3: true,
            ),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
