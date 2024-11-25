// ignore_for_file: unused_import

import 'package:apple_market/pages/add_product/add_product_page.dart';
import 'package:apple_market/pages/login/login_page.dart';
import 'package:apple_market/providers/product_provider.dart';
import 'package:apple_market/pages/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

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
