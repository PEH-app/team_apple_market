import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:provider/provider.dart';

import 'pages/add_product/add_product_page.dart';
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: const MyApp(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Market',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
      //상품 추가 페이지로 이동
      routes: {
        AddProductPage.routeName: (context) => const AddProductPage(),
      },
    );
  }
}
