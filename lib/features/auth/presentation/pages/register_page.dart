import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shelter_system/core/constants.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/curved_background.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Enter your personal information",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF999999),
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppFormField(
                            label: "first name",
                            controller: firstNameController,
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "Please enter Name";
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            label: "last name",
                            controller: lastNameController,
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "Please enter Name";
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: nameController,
                            label: "Name",
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "Please enter Name";
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: emailController,
                            label: "E-mail",
                            icon: Icons.mail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "Please enter email";
                              }
                              if (!isValidEmail(text)) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: passwordController,
                            label: "Password",
                            icon: Icons.lock,
                            isPassword: true,
                            keyboardType: TextInputType.text,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "please enter password";
                              }
                              if ((text?.length ?? 0) < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: retypePasswordController,
                            label: "Re-type Password",
                            icon: Icons.lock,
                            isPassword: true,
                            keyboardType: TextInputType.text,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "please enter password";
                              }
                              if (passwordController.text != text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (validateForm()) {
                                // TODO: call AuthRepositoryImpl().register(...) later
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(width: 12),
                                Padding(
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                    color: AppColors.accentColor,
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
  }
}
