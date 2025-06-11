import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/logo_header.dart';
import '../widgets/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static final name = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();
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
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  LogoHeader(
                    titleLarge: 'Sign Up',
                    titleSmall: 'Get started with us with your details',
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
                    controller: _firstNameTEController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _lastNameTEController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordTEController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter a password of 6 char';
                      }

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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _cityTEController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your city';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'City'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _shippingAddressTEController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter your Shipping Address';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Shipping Address',

                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: _onTapLogIn, child: Text('SignUp')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapLogIn() {
    _formKey.currentState!.validate();
    Navigator.pushNamed(context, OtpVerificationScreen.name);
  }
}
