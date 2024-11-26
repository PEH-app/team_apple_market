// lib/pages/profile/profile_page.dart

import 'package:apple_market/pages/product_detail/product_detail_page.dart';
import 'package:apple_market/pages/product_list/product/product_provider.dart';
import 'package:apple_market/pages/product_list/widgets/data_utils.dart';
import 'package:apple_market/pages/product_list/widgets/product_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        Provider.of<ProductProvider>(context).favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('찜한 제품이 없습니다.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ProductImage(product: product),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(product.brand.name,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                              const SizedBox(width: 10),
                              Text('|',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                              const SizedBox(width: 10),
                              Text(product.grade.name,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ],
                          ),
                          Text(
                            DataUtils.calcToWon(product.price),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('찜 삭제'),
                                content: Text('찜 목록에서 삭제하시겠습니까?'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('취소'),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .removeFavorite(product);
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '"${product.name}" 찜 목록에서 제거됨'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    isDestructiveAction: true, // 빨간색으로 표시
                                    child: const Text('삭제'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
