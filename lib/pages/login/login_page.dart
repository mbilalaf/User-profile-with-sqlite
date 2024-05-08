import 'package:flutter/material.dart';
import 'package:profile_app/models/user_model.dart';
import 'package:profile_app/pages/profile/profile_page.dart';
import 'package:profile_app/pages/signup/signup_page.dart';
import 'package:profile_app/pages/widgets/custom_textfield.dart';
import 'package:profile_app/services/database_helper.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isLoginTrue = false;

  final db = DatabaseHelper();
  //Login Method
  //We will take the value of text fields using controllers in order to verify whether details are correct or not
  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db
        .authenticate(Users(usrName: usrName.text, password: password.text));
    if (res == true) {
      //If result is correct then go to profile or home
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(profile: usrDetails)));
    } else {
      //Otherwise show the error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- Welcome back text
                const Text(
                  "Login,",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ),

                // -- TextFields
                const SizedBox(height: 24),
                CustomTextField(
                  hintText: "User name",
                  controller: usrName,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Password",
                  // obscureText: true,
                  controller: password,
                ),
                const SizedBox(height: 8),

                // -- Forgot Password
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 24),

                // -- Login Button
                CustomButton(
                  btnText: "Login",
                  onTap: () {
                    login();
                  },
                ),
                const SizedBox(height: 8),

                // -- Don't have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ? ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
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
  }
}
