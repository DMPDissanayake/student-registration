import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:student_registration/features/common/app_button.dart';
import 'package:student_registration/features/common/app_text_field.dart';
import 'package:student_registration/features/common/appbar.dart';
import 'package:student_registration/features/common/pin_text_field.dart';
import 'package:student_registration/utils/app_colors.dart';
import 'package:student_registration/utils/app_dimensions.dart';
import 'package:student_registration/utils/app_images.dart';
import 'package:student_registration/features/common/snackbar_utils.dart';
import 'package:student_registration/utils/enums.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _buttonController = AppButtonController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isButtonEnabled =
          _emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentAppBar(title: 'Login', isGoBackEnabled: false),
      backgroundColor: AppColors.initColors().whiteBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            _buttonController.startLoading();
          } else {
            _buttonController.stopLoading();
          }

          if (state is AuthAuthenticated) {
            context.go('/dashboard');
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
                          SizedBox(height: 80.h),
                          AppTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Enter your email',
                            inputType: TextInputType.emailAddress,
                            isRequired: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          PinTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            isRequired: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40.h),
                          AppButton(
                            buttonText: 'Login',
                            controller: _buttonController,
                            buttonType: _isButtonEnabled
                                ? ButtonType.ENABLED
                                : ButtonType.DISABLED,
                            onTapButton: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginSubmitted(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 60.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
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
                                  context.push('/register');
                                },
                                child: Text(
                                  ' Register',
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
