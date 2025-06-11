import 'package:flutter/material.dart';

import 'app_logo.dart';
class LogoHeader extends StatelessWidget {
  const LogoHeader({
    super.key,

    required this.titleLarge,
    required this.titleSmall,
  });


  final String titleLarge;
  final String titleSmall;

  @override
  Widget build(BuildContext context) {
    var textTheme = TextTheme.of(context);
    return Column(
      children: [
        AppLogo(height: 120, width: 100),
        Text(titleLarge, style: textTheme.titleLarge),
        Text(titleSmall, style: textTheme.bodySmall),
      ],
    );
  }
}