// product_list/screens/product_detail_screen.dart

import 'package:apple_market/pages/cart/cart_page.dart';
import 'package:apple_market/pages/product_list/product/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(product.name),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(product.brand.toString().split('.').last),
                ),
              ),
              // Text('브랜드: ${product.brand.toString().split('.').last}',
              //     style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          //height: 55,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[350]!)),
          ),
          child: Row(
            children: [
              Text('찜하기'),
              SizedBox(width: 10),
              Text('${product.price} 만원',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  productProvider.addCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${product.name}" 장바구니 추가'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('장바구니'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ));
  }
}
