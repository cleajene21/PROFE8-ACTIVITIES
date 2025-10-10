import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const CameraRentProApp());
}

class CameraRentProApp extends StatelessWidget {
  const CameraRentProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CameraRent Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
