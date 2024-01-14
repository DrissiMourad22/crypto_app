import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/dependency_injection.dart';
import 'package:crypto_app/home_page.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Utilisez Future.delayed pour attendre un court instant avant de configurer Injector
  Future.delayed(Duration.zero, () async {
    // ignore: await_only_futures, unused_local_variable
    
var injector = Injector();
  injector.configure(Flavor.PROD);
  
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS
            ? Colors.grey[100]
            : null,
      ),
      home: const HomePage(),
    );
  }
}
