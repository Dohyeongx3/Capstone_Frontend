import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


import 'login.dart';
import 'register.dart';
import 'terms.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/splashbackground.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const Spacer(flex: 1),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icon1.png',
                      width: 100,
                      height: 130,
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      'SAM으로 시작하는 안전한 하루',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 4),
              const SizedBox(height: 20),
              // 회원가입 버튼
              ElevatedButton(
                onPressed: () => navigateToRegister(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(320, 50),
                  side: BorderSide(color: Colors.white),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              // 로그인 버튼
              ElevatedButton(
                onPressed: () => navigateToLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0073FF),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(320, 50),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // 이용약관 및 개인정보처리방침 문구
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '회원가입 시, SAM의 ',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    children: [
                      TextSpan(
                        text: '개인정보처리방침',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                            );
                          },
                      ),
                      const TextSpan(
                        text: ' 및 ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: '이용약관',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TermsOfServicePage()),
                            );
                          },
                      ),
                      const TextSpan(
                        text: '에 동의한 것으로 간주됩니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}