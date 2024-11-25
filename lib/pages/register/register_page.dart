// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:apple_market/pages/product_list/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../login/widgets/input_field.dart';
import '../login/widgets/loading_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String email, password, confirmPassword;
  String? emailError, passwordError, confirmPasswordError;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';

    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
    });
  }

  bool validate() {
    resetErrorText();
    bool isValid = true;

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = '유효하지 않은 이메일 주소입니다.';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = '비밀번호를 입력해주세요.';
      });
      isValid = false;
    }

    if (confirmPassword.isEmpty || confirmPassword != password) {
      setState(() {
        confirmPasswordError = '비밀번호가 일치하지 않습니다.';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() async {
    if (validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool success = await authProvider.register(email, password);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductListPage()),
        );
      } else {
        final error = authProvider.errorMessage;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? '회원가입에 실패했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * 0.05),
            const Text(
              '계정을 생성하세요',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.05),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              labelText: '이메일',
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * 0.025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              labelText: '비밀번호',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenHeight * 0.025),
            InputField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              labelText: '비밀번호 확인',
              errorText: confirmPasswordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => submit(),
            ),
            SizedBox(height: screenHeight * 0.05),
            authProvider.isLoading
                ? const LoadingIndicator()
                : ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
