// lib/pages/login/login_page.dart

// ignore_for_file: use_build_context_synchronously

import 'package:apple_market/pages/login/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../register/register_page.dart';
import '../product_list/product_list_page.dart';
import '../../providers/user_provider.dart';
import 'widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (emailController.text.isEmpty ||
        !emailExp.hasMatch(emailController.text)) {
      setState(() {
        emailError = '유효하지 않은 이메일 주소입니다.';
      });
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = '비밀번호를 입력해주세요.';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() async {
    if (validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool success = await authProvider.login(
          emailController.text, passwordController.text);

      if (success) {
        // UserProvider에 사용자 정보 설정
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (authProvider.user != null) {
          userProvider.setUserProfile(authProvider.user!);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductListPage()),
        );
      } else {
        final error = authProvider.errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? '로그인에 실패했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              '환영합니다,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              '계속하려면 로그인하세요!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              labelText: '이메일',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              errorText: emailError,
              icon: Icons.email, // 아이콘 추가 (선택 사항)
              onChanged: (value) {
                if (emailError != null) {
                  setState(() {
                    emailError = null;
                  });
                }
              },
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: '비밀번호',
              obscureText: true,
              controller: passwordController,
              errorText: passwordError,
              icon: Icons.lock, // 아이콘 추가 (선택 사항)
              onChanged: (value) {
                if (passwordError != null) {
                  setState(() {
                    passwordError = null;
                  });
                }
              },
              onSubmitted: (val) => submit(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // 비밀번호 찾기 기능 구현 가능
                },
                child: const Text(
                  '비밀번호를 잊으셨나요?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            authProvider.isLoading
                ? const LoadingIndicator()
                : ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(
              height: screenHeight * .15,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterPage(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "새 사용자이신가요? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '회원가입',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
