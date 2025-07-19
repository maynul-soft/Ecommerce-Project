import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controller/login_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/register_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      return validator(
                        passwordRegex,
                        value,
                        'Enter a password of 6 char',
                      );
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: _onTapLogIn, child: GetBuilder<LoginController>(
                    builder: (controller) {
                      return Visibility(
                          visible: controller.isLoading == false,
                          replacement: LoadingWidget.forButton(),
                          child: Text('Login'));
                    }
                  )),
                  const SizedBox(height: 50),

                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have and account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(color: AppColors.themColor,decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.pushNamed(context, RegisterScreen.name);
                          }

                        ),
                      ],
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

  _onTapLogIn() async {
   if( _formKey.currentState!.validate()){
    await Get.find<LoginController>().login(
         email: _emailTEController.text.trim(),
         password: _passwordTeController.text
     );
   }

  }
}
