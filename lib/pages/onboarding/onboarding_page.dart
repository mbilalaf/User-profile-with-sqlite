import 'package:flutter/material.dart';
import 'package:profile_app/pages/login/login_page.dart';
import 'package:profile_app/pages/signup/signup_page.dart';
import 'package:profile_app/utils/colors.dart';

import 'widgets/onboarding_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage("assets/onboarding.png"),
            ),
            const SizedBox(height: 24),
            const Text(
              "User Profile",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id potenti nisl tellus vestibulum dictum luctus cum habitasse augue. Convallis vitae, dictum justo, iaculis id. Cras a ac augue netus egestas semper varius facilisis id. ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 24),

            // -- Buttons
            Row(
              children: [
                Expanded(
                  child: OnboardingButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    btnText: "Sign in",
                    topLeft: const Radius.circular(16),
                    bottomLeft: const Radius.circular(16),
                  ),
                ),
                Expanded(
                  child: OnboardingButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    btnText: "Login",
                    btnColor: BColors.primaryColor,
                    topRight: const Radius.circular(16),
                    bottomRight: const Radius.circular(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
