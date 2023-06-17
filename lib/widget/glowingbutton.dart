import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/Colorsnew/appcolors.dart';
import '../res/colors/style.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  const GlowingButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 7.0).animate(
        _animationController); // Adjust the end value for reduced glow width
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: Get.width * 0.2,
          height: Get.height * 0.037,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: _animation.value,
                spreadRadius: _animation.value,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColor.pinkColor, AppColor.purpleColor]),
            color: Colors.purple,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class GlowingButton2 extends StatefulWidget {
  final String text;
  const GlowingButton2({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  _GlowingButton2State createState() => _GlowingButton2State();
}

class _GlowingButton2State extends State<GlowingButton2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 7.0).animate(
        _animationController); // Adjust the end value for reduced glow width
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          // width: Get.width * 0.2,
          // height: Get.height * 0.02,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: _animation.value,
                spreadRadius: _animation.value,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColor.pinkColor, AppColor.purpleColor]),
            color: Colors.purple,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GlowingButtonAuth extends StatefulWidget {
  final String text;
  final bool loading;
  const GlowingButtonAuth({
    Key? key,
    required this.text,
    required this.loading,
  }) : super(key: key);
  @override
  _GlowingButtonAuthState createState() => _GlowingButtonAuthState();
}

class _GlowingButtonAuthState extends State<GlowingButtonAuth>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 7.0).animate(
        _animationController); // Adjust the end value for reduced glow width
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: Get.height * 0.06,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: _animation.value,
                spreadRadius: _animation.value,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColor.pinkColor, AppColor.purpleColor]),
            color: Colors.purple,
          ),
          child: Center(
            child: widget.loading == true
                ? CircularProgressIndicator()
                : Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class GlowingButtonQR extends StatefulWidget {
  final String text;
  // final bool icon;
  const GlowingButtonQR({
    Key? key,
    required this.text,
    // required this.icon,
  }) : super(key: key);
  @override
  _GlowingButtonQRState createState() => _GlowingButtonQRState();
}

class _GlowingButtonQRState extends State<GlowingButtonQR>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 7.0).animate(
        _animationController); // Adjust the end value for reduced glow width
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: Get.height * 0.06,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: _animation.value,
                spreadRadius: _animation.value,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColor.pinkColor, AppColor.purpleColor]),
            color: Colors.purple,
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
