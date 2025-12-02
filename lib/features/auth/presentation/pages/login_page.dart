import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shelter_system/core/constants.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:pets_shelter_system/features/auth/presentation/widgets/curved_background.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CurvedBackground(height: 400, content: LogoSection()),
          SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 290),
                _buildLoginHeader(context),
                const SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      const SizedBox(height: 16),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: const Color(0xFF3377CF),
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (validateForm()) {
                            // TODO: call AuthRepositoryImpl().login(...) later
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 12),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Login",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "New User ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: const Color(0x88000000),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.registerScreen.name,
                              );
                            },
                            child: Text(
                              "Sign Up",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Login",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Welcome back! Please login to your account",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF999999),
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
