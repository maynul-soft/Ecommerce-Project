import 'package:crafty_bay_ecommerce/features/auth/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/logo_header.dart';
import '../widgets/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final name = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[\w.-]+$');
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{6,}$');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5.5),
                  LogoHeader(
                    titleLarge: 'Welcome Back',
                    titleSmall: 'Please Enter your email address',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailTEController,
                    validator: (value) {
                      return validator(emailRegex, value, 'Enter a valid mail');
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email Address'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordTeController,
                    validator: (value) {
                      return validator(passwordRegex, value, 'Enter a password of 6 char');
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _onTapLogIn,
                    child: Text('Login',

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapLogIn(){
    _formKey.currentState!.validate();
    Navigator.pushNamed(context, RegisterScreen.name);
  }

}
