import 'package:apple_market/pages/add_product/add_product_page.dart';
import 'package:apple_market/pages/product_list/product/product_provider.dart';
import 'package:apple_market/pages/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //ChangeNotifierProvider 상품목록 같은 데이터 저장, 데이터 변경시 앱의 화면도 바꿔줌
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
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
      home: const ProjectListPage(),
      //상품 추가 페이지로 이동
      routes: {
        AddProductPage.routeName: (context) => const AddProductPage(),
      },
    );
  }
}
