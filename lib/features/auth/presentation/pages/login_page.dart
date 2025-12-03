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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          } else if (state is AuthLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logged in successfully')),
            );
            // Navigate to home or main screen
            // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen.name);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: Stack(
              children: [
                CurvedBackground(height: 400, content: LogoSection()),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
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
                              validator: validateEmail,
                            ),
                            const SizedBox(height: 16),
                            AppFormField(
                              controller: passwordController,
                              label: "Password",
                              icon: Icons.lock,
                              isPassword: true,
                              keyboardType: TextInputType.text,
                              validator: validatePassword,
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
                                      GoogleFonts.inter()
                                          .fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                if (!validateForm()) return;

                                context.read<AuthCubit>().login(
                                  email: emailController.text
                                      .trim(),
                                  password: passwordController
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
                              mainAxisAlignment:
                              MainAxisAlignment.start,
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
        },
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
