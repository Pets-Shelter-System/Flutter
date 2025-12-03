import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shelter_system/core/validators.dart';
import 'package:pets_shelter_system/features/auth/data/auth_repository_impl.dart';
import 'package:pets_shelter_system/features/auth/domain/auth_repository.dart';
import 'package:pets_shelter_system/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pets_shelter_system/features/auth/presentation/cubit/auth_state.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/curved_background.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';

import '../../../../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
  TextEditingController();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepositoryImpl() as AuthRepository),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registered successfully')),
            );
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.loginScreen.name,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                testNetwork();
              },
              child: const Icon(Icons.wifi),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurvedBackground(
                    height: 350,
                    content: LogoSection(),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontFamily:
                              GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Enter your personal information",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color: const Color(0xFF999999),
                              fontWeight: FontWeight.w400,
                              fontFamily:
                              GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                AppFormField(
                                  label: "first name",
                                  controller: firstNameController,
                                  icon: Icons.person,
                                  keyboardType: TextInputType.name,
                                  validator: (text) => validateName(
                                    text,
                                    fieldName: 'first name',
                                  ),
                                ),
                                AppFormField(
                                  label: "last name",
                                  controller: lastNameController,
                                  icon: Icons.person,
                                  keyboardType: TextInputType.name,
                                  validator: (text) => validateName(
                                    text,
                                    fieldName: 'last name',
                                  ),
                                ),
                                AppFormField(
                                  controller: nameController,
                                  label: "Name",
                                  icon: Icons.person,
                                  keyboardType: TextInputType.name,
                                  validator: (text) => validateName(
                                    text,
                                    fieldName: 'name',
                                  ),
                                ),
                                AppFormField(
                                  controller: emailController,
                                  label: "E-mail",
                                  icon: Icons.mail,
                                  keyboardType:
                                  TextInputType.emailAddress,
                                  validator: validateEmail,
                                ),
                                AppFormField(
                                  controller: passwordController,
                                  label: "Password",
                                  icon: Icons.lock,
                                  isPassword: true,
                                  keyboardType: TextInputType.text,
                                  validator: validatePassword,
                                ),
                                AppFormField(
                                  controller: retypePasswordController,
                                  label: "Re-type Password",
                                  icon: Icons.lock,
                                  isPassword: true,
                                  keyboardType: TextInputType.text,
                                  validator: (text) =>
                                      validateConfirmPassword(
                                        text,
                                        passwordController.text,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                    if (!validateForm()) return;
                                    if (passwordController.text !=
                                        retypePasswordController
                                            .text) {
                                      ScaffoldMessenger.of(
                                          context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Passwords do not match',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    context
                                        .read<AuthCubit>()
                                        .register(
                                      firstName:
                                      firstNameController
                                          .text
                                          .trim(),
                                      lastName:
                                      lastNameController.text
                                          .trim(),
                                      username:
                                      nameController.text
                                          .trim(),
                                      email: emailController.text
                                          .trim(),
                                      password:
                                      passwordController.text,
                                      confirmPassword:
                                      retypePasswordController
                                          .text,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      if (isLoading)
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                              AlwaysStoppedAnimation<
                                                  Color>(
                                                Color(0xFFF4F4F4),
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        const SizedBox(width: 12),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: Color(0xFFF4F4F4),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Already Have Account ?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.loginScreen.name,
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                          color:
                                          AppColors.accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
