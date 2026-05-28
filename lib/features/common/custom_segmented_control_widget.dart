import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';

class TabTata {
  final int id;
  final String name;

  TabTata({required this.id, required this.name});
}

class CustomSegmentedControl extends StatelessWidget {
  final int
  selectedId; // Track by ID instead of index for better data integrity
  final List<TabTata> tabs;
  final Function(TabTata) onTabSelected;

  const CustomSegmentedControl({
    super.key,
    required this.selectedId,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.initColors().primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = selectedId == tab.id;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.initColors().nonChangeWhite
                      : AppColors.initColors().primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.initColors().nonChangeBlack
                                .withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  tab.name,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: AppDimensions.kFontSize14,
                    height: AppDimensions.kLineHeight14(20),
                    letterSpacing: AppDimensions.kLetterSpacing14(0),
                    color: isSelected
                        ? AppColors.initColors().primaryColor
                        : AppColors.initColors().nonChangeBlack,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
