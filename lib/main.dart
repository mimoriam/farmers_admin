import 'package:farmers_admin/constants/constants.dart';
import 'package:farmers_admin/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/auth_screen.dart';
import 'firebase_options.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandColor,
    required this.sidebarBackground,
    required this.activeMenuBackground,
    required this.inactiveMenuText,
    required this.settingsHeaderText,
    required this.cardBackgroundColor,
    required this.cardBackgroundColor2,
    required this.formFieldBorderColor,
    required this.applyFilterButtonColor,
  });

  final Color? brandColor;
  final Color? sidebarBackground;
  final Color? activeMenuBackground;
  final Color? inactiveMenuText;
  final Color? settingsHeaderText;
  final Color? cardBackgroundColor;
  final Color? cardBackgroundColor2;
  final Color? formFieldBorderColor;
  final Color? applyFilterButtonColor;

  @override
  AppColors copyWith({
    Color? brandColor,
    Color? sidebarBackground,
    Color? activeMenuBackground,
    Color? inactiveMenuText,
    Color? settingsHeaderText,
    Color? cardBackgroundColor,
    Color? cardBackgroundColor2,
    Color? formFieldBorderColor,
    Color? applyFilterButtonColor,
  }) {
    return AppColors(
      brandColor: brandColor ?? this.brandColor,
      sidebarBackground: sidebarBackground ?? this.sidebarBackground,
      activeMenuBackground: activeMenuBackground ?? this.activeMenuBackground,
      inactiveMenuText: inactiveMenuText ?? this.inactiveMenuText,
      settingsHeaderText: settingsHeaderText ?? this.settingsHeaderText,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      cardBackgroundColor2: cardBackgroundColor2 ?? this.cardBackgroundColor2,
      formFieldBorderColor: formFieldBorderColor ?? this.formFieldBorderColor,
      applyFilterButtonColor: applyFilterButtonColor ?? this.applyFilterButtonColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      sidebarBackground: Color.lerp(sidebarBackground, other.sidebarBackground, t),
      activeMenuBackground: Color.lerp(activeMenuBackground, other.activeMenuBackground, t),
      inactiveMenuText: Color.lerp(inactiveMenuText, other.inactiveMenuText, t),
      settingsHeaderText: Color.lerp(settingsHeaderText, other.settingsHeaderText, t),
      cardBackgroundColor: Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t),
      cardBackgroundColor2: Color.lerp(cardBackgroundColor2, other.cardBackgroundColor2, t),
      formFieldBorderColor: Color.lerp(formFieldBorderColor, other.formFieldBorderColor, t),
      applyFilterButtonColor: Color.lerp(applyFilterButtonColor, other.applyFilterButtonColor, t),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        sidebarBackground: sideBarBackground,
        brandColor: Colors.white,
        activeMenuBackground: buttonBackground,
        inactiveMenuText: Colors.white,
        settingsHeaderText: Colors.grey[700],
        cardBackgroundColor: cardBackgroundColor,
        cardBackgroundColor2: cardBackgroundColor2,
        formFieldBorderColor: formFieldBorderColor,
        applyFilterButtonColor: buttonBackground,
      ),
    ],
  );

  // Dark Theme (Original Style)
  // static final _darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   fontFamily: 'Inter',
  //   scaffoldBackgroundColor: const Color(0xFF1E2828),
  //   extensions: <ThemeExtension<dynamic>>[
  //     AppColors(
  //       sidebarBackground: const Color(0xFF2D3A3A),
  //       brandColor: Colors.white,
  //       activeMenuBackground: const Color(0xFF1ABC9C),
  //       inactiveMenuText: Colors.grey[400],
  //       settingsHeaderText: Colors.grey,
  //       cardBackgroundColor: cardBackgroundColor,
  //       cardBackgroundColor2: cardBackgroundColor2,
  //     ),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Farmer's Hub Admin",
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,      // Set the light theme as the default
      // darkTheme: _darkTheme,   // Set the dark theme
      // themeMode: ThemeMode.system, // Automatically switch based on system settings
      // home: DashboardScreen(),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return const DashboardScreen();
        }
        return const AuthScreen();
      },
    );
  }
}