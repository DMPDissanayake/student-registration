import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:student_registration/features/common/app_button.dart';
import 'package:student_registration/features/common/app_text_field.dart';
import 'package:student_registration/features/common/app_mobile_number_field.dart';
import 'package:student_registration/features/common/appbar.dart';
import 'package:student_registration/features/common/pin_text_field.dart';
import 'package:student_registration/features/common/snackbar_utils.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import 'package:student_registration/utils/enums.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _appMobileNumberController = AppMobileNumberController();
  final _buttonController = AppButtonController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateInputs);
    _studentIdController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _phoneController.addListener(_validateInputs);
    _addressController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isButtonEnabled =
          _nameController.text.trim().isNotEmpty &&
          _emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _appMobileNumberController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentAppBar(
        title: 'Student Registration',
        isGoBackEnabled: true,
      ),
      backgroundColor: AppColors.initColors().whiteBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            _buttonController.startLoading();
          } else {
            _buttonController.stopLoading();
          }

          if (state is AuthUnauthenticated) {
            AppSnackBar.show(
              context,
              message: 'Registration successful! Please login.',
              backgroundColor: Colors.green,
              textColor: AppColors.initColors().nonChangeWhite,
            );
            context.go('/login');
          } else if (state is AuthError) {
            AppSnackBar.show(
              context,
              message: state.message,
              backgroundColor: AppColors.initColors().errorColor,
              textColor: AppColors.initColors().nonChangeWhite,
            );
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.all(24.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppImages.pngAppLogo2,
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(height: 40.h),
                          AppTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            isRequired: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          AppTextField(
                            controller: _studentIdController,
                            label: 'Student ID',
                            hint: 'Enter your ID',
                            isRequired: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          AppTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'example@mail.com',
                            inputType: TextInputType.emailAddress,
                            isRequired: true,
                            validator: (value) =>
                                value == null || !value.contains('@')
                                ? 'Invalid email'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          PinTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Min 6 characters',
                            isRequired: true,
                            validator: (value) =>
                                value == null || value.length < 6
                                ? 'Min 6 characters'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          AppMobileNumberField(
                            controller: _phoneController,
                            appMobileNumberController:
                                _appMobileNumberController,
                            label: 'Phone Number',
                            hint: '07X XXX XXXX',
                            isRequired: true,
                            onChange: (phone, minLength) {
                              _validateInputs();
                            },
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          AppTextField(
                            controller: _addressController,
                            label: 'Address',
                            hint: 'Enter your address',
                            isRequired: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required field'
                                : null,
                          ),
                          SizedBox(height: 40.h),
                          AppButton(
                            buttonText: 'Register',
                            controller: _buttonController,
                            buttonType: _isButtonEnabled
                                ? ButtonType.ENABLED
                                : ButtonType.DISABLED,
                            onTapButton: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  RegisterSubmitted(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    studentId: _studentIdController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    address: _addressController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppDimensions.kFontSize12,
                                  letterSpacing: AppDimensions.kLetterSpacing14(
                                    -1,
                                  ),
                                  color: AppColors.initColors().nonChangeBlack,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push('/login');
                                },
                                child: Text(
                                  ' Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.kFontSize12,
                                    letterSpacing:
                                        AppDimensions.kLetterSpacing14(-1),
                                    color: AppColors.initColors().primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
