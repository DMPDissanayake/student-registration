import 'dart:io';
import 'package:student_registration/features/home/presentation/screens/home_view.dart';
import 'package:student_registration/features/dashbord/widget/bottom_bar_item.dart'; // මෙතන spelling නිවැරදිද බලන්න (dashbord/dashboard)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/features/grades/presentation/screens/grades_view.dart';
import 'package:student_registration/features/my_courses/presentation/screens/courses_view.dart';
import 'package:student_registration/features/profile/presentation/screens/profile_view.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';

class DashboardView extends StatefulWidget {
  final int? initTab;

  const DashboardView({super.key, this.initTab});
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedTab = 0;
  dynamic tabData;
  final TextEditingController _filenameController = TextEditingController();
  String? _fileNameError;
  Color? _selectedColor;
  final TextEditingController _fileUploadNoteController =
      TextEditingController();
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    if (widget.initTab != null) {
      selectedTab = widget.initTab!;
    }
  }

  @override
  void dispose() {
    _filenameController.dispose();
    _fileUploadNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedTab == 0,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (selectedTab != 0) {
          changeTab(0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.initColors().whiteBackgroundColor,
        body: SafeArea(child: Stack(children: [_getBody()])),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 15.h),
          decoration: BoxDecoration(
            color: AppColors.initColors().nonChangeWhite,
            boxShadow: const [
              BoxShadow(
                offset: Offset(4, 0),
                blurRadius: 24,
                spreadRadius: 0,
                color: Color(0x3D000000),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomBarItem(
                name: 'Home',
                selectedIcon: AppImages.svgHome,
                onTap: () => changeTab(0),
                isSelected: selectedTab == 0,
              ),
              BottomBarItem(
                name: 'Courses',
                selectedIcon: AppImages.svgCourses,
                onTap: () => changeTab(1),
                isSelected: selectedTab == 1,
              ),
              BottomBarItem(
                name: 'Grades',
                selectedIcon: AppImages.svgGrade,
                onTap: () => changeTab(2),
                isSelected: selectedTab == 2,
              ),
              BottomBarItem(
                name: 'Profile',
                selectedIcon: AppImages.svgProfile,
                onTap: () => changeTab(3),
                isSelected: selectedTab == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTab(int value, {dynamic data}) {
    setState(() {
      if (selectedTab != value) {
        selectedTab = value;
        tabData = data;
      }
    });
  }

  Widget _getBody() {
    switch (selectedTab) {
      case 0:
        return HomeScreen(onChangeTab: changeTab, data: tabData);
      case 1:
        return CourseView(onChangeTab: changeTab, data: tabData);
      case 2:
        return GradesView(onChangeTab: changeTab, data: tabData);
      case 3:
        return ProfileView(onChangeTab: changeTab, data: tabData);
      default:
        return HomeScreen(onChangeTab: changeTab, data: tabData);
    }
  }
}
