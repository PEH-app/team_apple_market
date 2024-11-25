// lib/product_widgets/product_tile.dart

import 'package:apple_market/pages/product_list/product/product.dart';
import 'package:apple_market/pages/product_list/product/product_provider.dart';
import 'package:apple_market/pages/product_list/widgets/data_utils.dart';
import 'package:apple_market/pages/product_list/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import '../../product_detail/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
            ),
          ),
          const SizedBox(height: 5),
          //const Spacer(),
          Row(
            children: [
              Text(product.brand.toString().split('.').last,
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text('|', style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text(product.grade.toString().split('.').last,
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Text('|', style: TextStyle(color: Colors.black54, fontSize: 15)),
              const SizedBox(width: 10),
              Icon(Icons.favorite_outline, color: Colors.black54, size: 15),
              const SizedBox(width: 5),
              Text(product.likeCount.toString(),
                  style: TextStyle(color: Colors.black54, fontSize: 15)),
              // Container(
              //   padding: EdgeInsets.all(7.0),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(product.brand.toString().split('.').last,
              //       style: TextStyle(color: Colors.black54, fontSize: 15)),
              // ),
              // const SizedBox(width: 10),
              // Container(
              //   padding: EdgeInsets.all(7.0),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(product.grade.toString().split('.').last,
              //       style: TextStyle(color: Colors.black54, fontSize: 13)),
              // ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            DataUtils.calcToWon(product.price),
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ]),
        // trailing: Consumer<ProductProvider>(
        //   builder: (context, productProvider, child) {
        //     final isFavorited =
        //         productProvider.favoriteProducts.contains(product);
        //     return IconButton(
        //       icon: Icon(
        //         isFavorited ? Icons.favorite : Icons.favorite_border,
        //         color: isFavorited ? Colors.red : Colors.grey,
        //       ),
        //       onPressed: () {
        //         if (isFavorited) {
        //           productProvider.removeFavorite(product);
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(
        //               content: Text('"${product.name}" 찜 목록에서 제거됨'),
        //               duration: const Duration(seconds: 2),
        //             ),
        //           );
        //         } else {
        //           productProvider.addFavorite(product);
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(
        //               content: Text('"${product.name}" 찜 됨'),
        //               duration: const Duration(seconds: 2),
        //             ),
        //           );
        //         }
        //       },
        //     );
        //   },
        // ),
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
    return product.imageUrl.startsWith('assets/') ||
            !product.imageUrl.contains('/')
        ? Image.asset(
            product.imageUrl,
            width: 100,
            height: 200,
            //fit: BoxFit.cover,
          )
        : Image.file(
            File(product.imageUrl),
            width: 100,
            height: 200,
            fit: BoxFit.cover,
          );
  }
}
