// lib/pages/add_product/add_product_page.dart

import 'dart:io';

import 'package:apple_market/pages/product_list/product/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../product_list/product/product_provider.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _price = 0;
  String _imageUrl = '';
  PhoneBrand? _selectedBrand;
  PhoneGrade? _selectedGrade;
  //int _likeCount = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('상품정보'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 선택 섹션
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    return GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _imageUrl = image.path;
                          });
                        }
                      },
                      child: Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: _imageUrl.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(_imageUrl)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Stack(
                          children: [
                            if (_imageUrl.isEmpty)
                              Center(
                                  child: Icon(Icons.add_a_photo,
                                      color: Colors.grey, size: 50)),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),

                // 상품명 입력
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '상품명',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '상품명을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),

                SizedBox(height: 20),
                // 브랜드 선택 드롭다운
                DropdownButtonFormField<PhoneBrand>(
                  decoration: const InputDecoration(labelText: '브랜드'),
                  items: PhoneBrand.values.map((brand) {
                    return DropdownMenuItem<PhoneBrand>(
                      value: brand,
                      child:
                          Text(brand.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (PhoneBrand? newBrand) {
                    setState(() {
                      _selectedBrand = newBrand;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return '브랜드를 선택해주세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                //폰상태 드롭다운
                DropdownButtonFormField<PhoneGrade>(
                  decoration: const InputDecoration(labelText: '폰 상태'),
                  items: PhoneGrade.values.map((grade) {
                    return DropdownMenuItem<PhoneGrade>(
                      value: grade,
                      child:
                          Text(grade.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (PhoneGrade? newGrade) {
                    setState(() {
                      _selectedGrade = newGrade;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return '폰 상태를 선택해주세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // 설명 입력
                TextField(
                  maxLength: 2000,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText:
                        '브랜드, 모델명, 구매 시기, 하자 유무 등 \n상품 설명을 최대한 자세히 적어주세요.',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.grey[50],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 휴대폰 타입 토글
                // Consumer<ProductProvider>(
                //   builder: (context, provider, _) {
                //     final List<bool> isSelected = [
                //       _selectedBrand == PhoneBrand.iPhone,
                //       _selectedBrand == PhoneBrand.Samsung,
                //     ];

                //     return ToggleButtons(
                //       constraints: BoxConstraints.expand(
                //         width:
                //             MediaQuery.of(context).size.width / 2 - 24, // 패딩 고려
                //         height: 40,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //       selectedColor: Colors.white,
                //       fillColor: Colors.blue,
                //       color: Colors.grey,
                //       isSelected: isSelected,
                //       onPressed: (index) {
                //         setState(() {
                //           _selectedBrand = index == 0
                //               ? PhoneBrand.iPhone
                //               : PhoneBrand.Samsung;
                //         });
                //       },
                //       children: const [
                //         Text('아이폰'),
                //         Text('삼성'),
                //       ],
                //     );
                //   },
                // ),

                // 가격 입력
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '가격',
                    prefixIcon: Text('₩ ', style: TextStyle(fontSize: 16)),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixText: '원',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '가격을 입력해주세요.';
                    }
                    if (int.tryParse(value) == null) {
                      return '유효한 숫자를 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = int.parse(value!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          child: Text('등록 완료'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              productProvider.addProduct(
                name: _name,
                price: _price,
                imageUrl: _imageUrl,
                brand: _selectedBrand!,
                grade: _selectedGrade!,
                likeCount: 0,
              );
              // 등록 로직 구현
              // 예: context.read<ProductProvider>().addProduct(...);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('제품이 성공적으로 등록되었습니다.')),
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
