import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    this.onTap,
    this.btnColor = Colors.black,
    this.topLeft = const Radius.circular(0),
    this.topRight = const Radius.circular(0),
    this.bottomLeft = const Radius.circular(0),
    this.bottomRight = const Radius.circular(0),
    required this.btnText,
  });

  final void Function()? onTap;
  final Color btnColor;
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.only(
            topLeft: topLeft,
            topRight: topRight,
            bottomLeft: bottomLeft,
            bottomRight: bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
