import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'login.dart';
import 'register.dart';

// 예시 약관 페이지
class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이용약관')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('여기에 이용약관 내용을 입력하세요.'),
      ),
    );
  }
}

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward(); // 애니메이션 시작
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
                  'Safety And Management',
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
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          'assets/icon2.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const Text(
                        '계정이 없으신가요?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: navigateToRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: const Size(500, 50),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: navigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      fixedSize: const Size(500, 50),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 카카오 로그인 동작
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Image.asset('assets/kakao.png', width: 180, height: 50),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // 네이버 로그인 동작
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Image.asset('assets/naver.png', width: 180, height: 50),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 수정된 이용약관 문구 (이용약관만 버튼)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '로그인 하시면 Safety And Management의 ',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                        children: [
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
                          TextSpan(
                            text: '에 동의하는 것으로 간주합니다.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}