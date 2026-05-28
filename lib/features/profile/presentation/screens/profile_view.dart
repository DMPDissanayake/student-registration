import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:student_registration/features/common/app_button.dart';
import 'package:student_registration/features/common/appbar.dart';
import 'package:student_registration/utils/app_images.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_info_card.dart';

class ProfileView extends StatelessWidget {
  final Function(int, {dynamic data}) onChangeTab;
  final dynamic data;
  const ProfileView({super.key, required this.onChangeTab, this.data});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.initColors();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: StudentAppBar(
        title: 'My Profile',
        isGoBackEnabled: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      backgroundColor: colors.nonChangeWhite,
      body: BlocProvider.value(
        value: context.read<ProfileBloc>()
          ..add(LoadProfile(uid: currentUserId)),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: Lottie.asset(
                  AppImages.loadingLottieAnimation,
                  width: 100.w,
                  height: 100.w,
                ),
              );
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileInfoCard(profile: profile),
                      SizedBox(height: 24.h),
                      AppButton(
                        buttonText: 'Edit Profile',
                        onTapButton: () =>
                            context.push('/edit-profile', extra: profile),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Failed to load profile.'));
          },
        ),
      ),
    );
  }
}
