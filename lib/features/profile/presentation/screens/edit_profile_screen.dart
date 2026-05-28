import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:student_registration/features/common/app_button.dart';
import 'package:student_registration/features/common/app_text_field.dart';
import 'package:student_registration/features/common/appbar.dart';
import 'package:student_registration/utils/app_colors.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileEntity profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _addressController = TextEditingController(text: widget.profile.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.initColors().nonChangeWhite,
      appBar: StudentAppBar(title: 'Edit Profile', isGoBackEnabled: true),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Full Name',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _phoneController,
                label: 'Phone Number',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _addressController,
                label: 'Address',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 24.h),
              AppButton(
                buttonText: 'Save Changes',
                onTapButton: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedProfile = ProfileEntity(
                      uid: widget.profile.uid,
                      name: _nameController.text.trim(),
                      email: widget.profile.email,
                      studentId: widget.profile.studentId,
                      phone: _phoneController.text.trim(),
                      address: _addressController.text.trim(),
                    );
                    context.read<ProfileBloc>().add(
                      ProfileUpdated(profile: updatedProfile),
                    );
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
