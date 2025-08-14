import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/config/routes/app_routes.dart';
import 'package:weatherapp/config/theme/app_theme.dart';
import 'package:weatherapp/core/utils/theme_util.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      themeMode: ThemeUtils.getThemeMode(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.lightPrimary,
          secondary: AppColors.lightSecondary
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightFontColor),
          bodyMedium: TextStyle(color: AppColors.lightFontColor),
          bodySmall: TextStyle(color: AppColors.lightFontColor),
          headlineLarge: TextStyle(color: AppColors.lightFontColor),
          headlineMedium: TextStyle(color: AppColors.lightFontColor),
          headlineSmall: TextStyle(color: AppColors.lightFontColor),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSecondary
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkFontColor),
          bodyMedium: TextStyle(color: AppColors.darkFontColor),
          bodySmall: TextStyle(color: AppColors.darkFontColor),
          headlineLarge: TextStyle(color: AppColors.darkFontColor),
          headlineMedium: TextStyle(color: AppColors.darkFontColor),
          headlineSmall: TextStyle(color: AppColors.darkFontColor),
        )
      ),
    );
  }
}

