import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/ui/common/CustomFromField.dart';
import 'package:pets_shelter_system/ui/common/curvedBackground.dart';
import 'package:pets_shelter_system/ui/common/validator.dart';
import 'package:pets_shelter_system/ui/design/design.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CurvedBackground(height: 400, content: LogoSection()),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 290),
                _buildLoginHeader(context),
                SizedBox(height: 24,),
                // You can add your form fields here
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
                        },
                      ),
                      SizedBox(height: 16,),
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
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Color(0xFF3377CF),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();

                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Login", style: TextStyle(
                                  color: Color(0xFFF4F4F4),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),),
                              ),
                            ],
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "New User ?",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Color(0x88000000),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.registerScreen.name,
                              );
                            },
                            child: Text("Sign Up",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.accentColor
                            ),),
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
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
