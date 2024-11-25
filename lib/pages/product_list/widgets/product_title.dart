// lib/product_widgets/product_tile.dart

import 'package:apple_market/pages/product_list/product/product.dart';
import 'package:apple_market/pages/product_list/widgets/data_utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../product_detail/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildProductImage(),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 5),
          //const Spacer(),
          Row(
            children: [
              Text(product.brand.name,
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text('|', style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text(product.grade.name,
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text('|', style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Icon(Icons.favorite_outline, color: Colors.black54, size: 15),
              const SizedBox(width: 5),
              Text(product.likeCount.toString(),
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            DataUtils.calcToWon(product.price),
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 100,
      height: 500,
      color: Colors.amber,
      child: product.imageUrl.startsWith('assets/') ||
              !product.imageUrl.contains('/')
          ? Image.asset(
              product.imageUrl,
              // width: 100,
              // height: 100,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(product.imageUrl),
              // width: 100,
              // height: 100,
              fit: BoxFit.cover,
            ),
    );
  }
}
