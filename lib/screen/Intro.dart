import 'package:application/screen/Login.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void navigateToLogin() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png', // Replace 'your_image.png' with the actual image asset path
                width: 300,
              ),
              const SizedBox(height: 100),
              Image.asset(
                'assets/images/intro_picture.png',
                width: 300,
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () {
                  // Call the function to navigate to the login page with custom transition
                  navigateToLogin();
                },
                child: Container(
                  width: 250.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF567BAE),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white, width: 1.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
