import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_registration/features/dashbord/bottom_bar_view.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/course_detail_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/domain/entities/profile_entity.dart';
import '../features/home/domain/entities/course_entity.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/course-detail',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final course = state.extra as CourseEntity;
        return CourseDetailView(course: course);
      },
    ),
    GoRoute(
      path: '/edit-profile',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final profile = state.extra as ProfileEntity;
        return EditProfileScreen(profile: profile);
      },
    ),
  ],
);
