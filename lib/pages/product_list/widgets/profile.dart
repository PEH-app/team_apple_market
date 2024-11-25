import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cart/cart_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/product_detail/product_detail_page.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final String userid;
  const ProfilePage({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        Provider.of<ProductProvider>(context).favoriteProducts;

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '프로필',
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                tooltip: '장바구니',
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ''' 사용자 이름 : 
                    $userid ''',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('로그아웃'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Center(
                  child: const SizedBox(
                    height: 30,
                  ),
                ),
              ),
              const Text(
                '찜 목록',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              favoriteProducts.isEmpty
                  ? const Center(
                      child: Text('찜한 제품이 없습니다.'),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image, size: 50),
                            ),
                            title: Text(product.name),
                            subtitle: Text('${product.price} 만원'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .removeFavorite(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('"${product.name}" 찜 목록에서 제거됨'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
