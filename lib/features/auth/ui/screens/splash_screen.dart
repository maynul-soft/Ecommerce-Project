import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';


import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  Future<void> _moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
  }
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Center(child: AppLogo()),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('version 1.0.0', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}


