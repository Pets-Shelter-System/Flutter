import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pets_shelter_system/ui/common/CustomFromField.dart';
import 'package:pets_shelter_system/ui/common/curvedBackground.dart';

import '../../routes.dart';
import '../common/validator.dart';
import '../design/design.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              content:  LogoSection(),
            ),


            Transform.translate(

              offset: Offset(0, -100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                          fontFamily: GoogleFonts.poppins().fontFamily
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text("Enter your personal information",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.poppins().fontFamily
                    ),),
                    SizedBox(height: 12,),
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
                              return null; // Must return null on success
                            },
                          ),
                          AppFormField(
                            label: "first name",
                            controller: lastNameController,
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (text) {
                              if (text?.trim().isEmpty == true) {
                                return "Please enter Name";
                              }
                              return null; // Must return null on success
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
                              return null; // Must return null on success
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
                              // FIX: Use '!' to assert non-null after checking for empty/null
                              if (!isValidEmail(text!)) {
                                return "Please enter valid email";
                              }
                              return null; // Must return null on success
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
                              return null; // Must return null on success
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
                              return null; // Must return null on success
                            },
                          ),
                          SizedBox(height: 16,),
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
                                  child: Text("Sign Up", style: TextStyle(
                                    color: Color(0xFFF4F4F4),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                ),
                              ],
                            )
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Already Have Account ?",
                                style: Theme.of(context).textTheme.bodyMedium
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
                                child: Text("Login",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.accentColor,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
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


  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }


}
