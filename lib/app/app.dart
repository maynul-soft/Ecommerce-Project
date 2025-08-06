import 'package:crafty_bay_ecommerce/app/providers.dart';
import 'package:crafty_bay_ecommerce/core/routes/app_routes.dart';
import 'package:crafty_bay_ecommerce/core/constants/app_theme.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppTheme.lightThemeData,
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

