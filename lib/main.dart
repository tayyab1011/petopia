import 'package:flutter/material.dart';
import 'package:petopia/pages/bottomnav.dart';
import 'package:petopia/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petopia/pages/login.dart';
import 'package:petopia/pages/signup.dart';
import 'package:petopia/service/cart_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=> CartProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:LogIn(),
      ),
    );
  }
}
