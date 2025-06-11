import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/logo_header.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  static final name = 'otpVerification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();


  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5.5),
                LogoHeader(
                  titleLarge: 'Enter otp code',
                  titleSmall: 'A 4 digit code has been sent',
                ),
                const SizedBox(height: 20),

                PinCodeTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  length: 4,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  showCursor: false,
                  animationType: AnimationType.fade,
                  autoUnfocus: false,
                  pinTheme: PinTheme(
                    activeColor: AppColors.themColor,
                    selectedFillColor: AppColors.themColor.shade200,
                    inactiveColor: AppColors.themColor,
                    inactiveFillColor: Colors.white,
                    errorBorderColor: Colors.red,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: _otpTEController,
                  onCompleted: (v) {

                  },
                   appContext: context,
                ),


                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onTapLogIn,
                  child: Text('Next',

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapLogIn(){


  }



}
