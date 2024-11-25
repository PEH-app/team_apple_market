import 'dart:io';
import 'package:flutter/material.dart';
import 'package:apple_market/pages/product_list/product/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  const ProductImage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildProductImage();
  }

  Widget _buildProductImage() {
    return SizedBox(
      width: 100,
      height: 100,
      child: product.imageUrl.startsWith('assets/') ||
              !product.imageUrl.contains('/')
          ? Image.asset(
              product.imageUrl,
              // width: 100,
              // height: 100,
              //fit: BoxFit.cover,
            )
          : Image.file(
              File(product.imageUrl),
              // width: 100,
              // height: 100,
              // fit: BoxFit.cover,
            ),
    );
  }
}
