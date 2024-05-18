import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dermoscan/Authentification/login.dart';
import 'package:tflite_v2/tflite_v2.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Tflite.loadModel(
    model: "lib/assets/tflite_model.tflite", // Update the path to your TensorFlow Lite model file
    labels: "lib/assets/labels.txt", // Update the path to your labels file
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}