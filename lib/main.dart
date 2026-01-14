import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Essential for initialization

// Existing imports
import 'package:redrip/services/auth_service.dart';
import 'package:redrip/services/cart_service.dart';
import 'package:redrip/services/firebase_auth_service.dart'; // Ensure you have this file
import 'package:redrip/screens/auth/login_screen.dart';

// 1. Mark main as async
void main() async {
  // 2. Required to allow async initialization before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase manually for FlutLab
  // Paste your keys from Firebase Console -> Project Settings -> Your Apps
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB3JGqJc-SuNE7myxct0iIluYcYjukvZVs",
        appId: "1:62220267464:web:24802e21acc1e554171afd",
        messagingSenderId: "62220267464",
        projectId: "redrip-app",
        authDomain: "redrip-app.firebaseapp.com",
        storageBucket: "redrip-app.firebasestorage.app",
        measurementId: "G-TXLD0W7LEC"),
  );

  runApp(
    MultiProvider(
      providers: [
        // Real Firebase Auth Provider
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        // Existing Providers
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => CartService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReDrip',
      theme: ThemeData(
        // Color Scheme
        primaryColor: Colors.green[700],
        colorScheme: ColorScheme.light(
          primary: Colors.green[700]!,
          secondary: Colors.greenAccent[700]!,
          surface: Colors.grey[50]!,
        ),

        // App Bar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            elevation: 3,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green[700],
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green[700]!, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          filled: true,
          fillColor: Colors.white,
        ),

        // Card Theme
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),

        // Dialog Theme
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: Colors.green[50],
          selectedColor: Colors.green[100],
          labelStyle: const TextStyle(color: Colors.black87),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Text Theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        // Divider Theme
        dividerTheme: DividerThemeData(
          color: Colors.grey[300],
          thickness: 1,
          space: 20,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(color: Colors.black87),

        // Use Material 3
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
