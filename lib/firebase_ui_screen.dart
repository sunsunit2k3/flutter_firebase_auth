import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter_localizations/flutter_localizations.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
  @override
  String get passwordInputLabel => "Enter your password";
}

class FirebaseUIScreen extends StatefulWidget {
  const FirebaseUIScreen({super.key});

  @override
  State<FirebaseUIScreen> createState() => _FirebaseUIScreenState();
}

class _FirebaseUIScreenState extends State<FirebaseUIScreen> {
  final auth = FirebaseAuth.instance;
  final providers = [
    EmailAuthProvider(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: auth.currentUser == null ? '/signin' : '/profile',
      routes: {
        "/signin": (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              })
            ],
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/signin');
              }),
            ],
          );
        },
      },
      title: 'Firebase UI demo',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en')],
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
    );
  }
}
