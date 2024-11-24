// product_list/screens/product_detail_screen.dart

import 'package:apple_market/pages/cart/cart_page.dart';
import 'package:apple_market/pages/product_list/product/product.dart';
import 'package:apple_market/pages/product_list/product/product_provider.dart';
import 'package:apple_market/pages/product_list/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final productProvider =
    //     Provider.of<ProductProvider>(context, listen: false);
    // bool isFavorited = productProvider.favoriteProducts.contains(product);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: '프로필',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
        body: bodyWidget(),
        bottomNavigationBar: bottomBar());
  }

  SingleChildScrollView bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Text('브랜드: ${product.brand.toString().split('.').last}',
          //     style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('판매자닉네임',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('많이 사주세요.'),
              ]),
              Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: Text('상점 팔로우'),
              ),
            ]),
          ),

          _line(),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('카테고리 >', style: TextStyle(color: Colors.grey[600])),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(product.brand.toString().split('.').last,
                      style: TextStyle(color: Colors.pink[800])),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "선물받은 새상품이고\n상품 꺼내보기만 했습니다\n거래는 직거래만 합니다.\n\n선물받은 새상품이고\n상품 꺼내보기만 했습니다\n거래는 직거래만 합니다.\n\n",
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
                SizedBox(height: 15),
                Text(
                  "채팅 3 ∙ 조회 295",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }

  Consumer<ProductProvider> bottomBar() {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      final isFavorited = productProvider.favoriteProducts.contains(product);
      return Container(
        //height: 55,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[350]!)),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                if (isFavorited) {
                  productProvider.removeFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${product.name}" 찜 목록에서 제거됨'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  productProvider.addFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('"${product.name}" 찜 됨'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            SizedBox(width: 10),
            Text('${product.price} 만원',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      );
    });
  }

  Widget _line() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey.withOpacity(0.3),
    );
  }
}