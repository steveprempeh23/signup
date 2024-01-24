import 'package:clothes_app/users/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clothes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Add a future parameter here, replace fetchData() with your actual async function
        future: fetchData(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            // While data is loading, you can return a loading indicator or placeholder
            return CircularProgressIndicator();
          } else if (dataSnapShot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${dataSnapShot.error}');
          } else {
            // Return the widget you want to build with the data
            return LoginScreen();
          }
        },
      ),
    );
  }
}

// Replace this function with your actual asynchronous data fetching function
Future<void> fetchData() async {
  // Simulating an asynchronous operation
  await Future.delayed(Duration(seconds: 2));
}
