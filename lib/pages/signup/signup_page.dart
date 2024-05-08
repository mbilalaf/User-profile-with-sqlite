import 'package:flutter/material.dart';
import 'package:profile_app/models/user_model.dart';
import 'package:profile_app/pages/login/login_page.dart';
import 'package:profile_app/pages/widgets/custom_textfield.dart';
import 'package:profile_app/services/database_helper.dart';
import '../widgets/custom_button.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Controllers
  final fullName = TextEditingController();
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final db = DatabaseHelper();
  signUp() async {
    var res = await db.createUser(Users(
      fullName: fullName.text,
      email: email.text,
      usrName: usrName.text,
      password: password.text,
    ));
    if (res > 0) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // -- Register Account
              const Text(
                "Register Account,",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                "Welcome!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
              ),

              // -- TextFields
              const SizedBox(height: 24),
              CustomTextField(
                hintText: "Full Name",
                controller: fullName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Email",
                controller: email,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "User name",
                controller: usrName,
              ),
              // const SizedBox(height: 16),
              // CustomTextField(
              //   hintText: "Phone",
              //   controller: _phoneController,
              // ),
              // const SizedBox(height: 16),
              // CustomTextField(
              //   hintText: "DOB",
              //   keyboardType: TextInputType.datetime,
              //   controller: _dobController,
              // ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Password",
                // obscureText: true,
                controller: password,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Confirm Password",
                // obscureText: true,
                controller: confirmPassword,
              ),
              const SizedBox(height: 24),

              // -- Sign Up Button
              CustomButton(
                btnText: "Sign Up",
                onTap: () {
                  signUp();
                  // After registration logic, you can navigate to another page
                },
              ),
              const SizedBox(height: 8),

              // -- Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
