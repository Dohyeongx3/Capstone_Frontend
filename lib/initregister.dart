import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';
import 'IDfind.dart';

class Initregister extends StatefulWidget {
  const Initregister({super.key});

  @override
  State<Initregister> createState() => _InitregisterState();
}

class _InitregisterState extends State<Initregister> with SingleTickerProviderStateMixin {
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
      MaterialPageRoute(builder: (context) => Login()), // 기존 Login 위젯으로 이동
    );
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()), // 기존 Register 위젯으로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Spacer(flex: 1), // 화면 상단 여백 조정
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icon1.png', // 이미지 경로
                  width: 100, // 원하는 크기로 조절 가능
                  height: 130,
                ),
                const SizedBox(height: 1), // 이미지와 텍스트 사이 간격 조정
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
          const Spacer(flex: 4), // 화면 하단 여백 조정 (비율 조정 가능)

          // 애니메이션을 통해 올라오는 로그인 화면
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
                    mainAxisAlignment: MainAxisAlignment.start, // 텍스트와 이미지를 왼쪽에 붙여 배치
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          'assets/icon2.png', // 두 번째 이미지 로고
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
                  // 검은색 회원가입 버튼
                  ElevatedButton(
                    onPressed: navigateToRegister, // 로그인 버튼 클릭 시 Register 위젯으로 이동
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 버튼 배경 색상 설정
                      fixedSize: const Size(500, 50),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 연한 회색 로그인 버튼
                  ElevatedButton(
                    onPressed: navigateToLogin, // 로그인 버튼 클릭 시 Login 위젯으로 이동
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // 연한 회색 배경 색상 설정
                      foregroundColor: Colors.black, // 텍스트 색상 설정
                      fixedSize: const Size(500, 50),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 소셜 로그인 버튼들 (이미지 버튼으로 변경)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 카카오 로그인 버튼 크기 조정
                      ElevatedButton(
                        onPressed: () {
                          // 카카오 로그인 동작
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // 배경을 투명으로 설정
                          shadowColor: Colors.transparent, // 그림자 제거
                          padding: const EdgeInsets.all(0), // 기본 패딩 제거
                        ),
                        child: Image.asset('assets/kakao.png', width: 200, height: 50), // 크기 조정
                      ),
                      const SizedBox(width: 20),
                      // 네이버 로그인 버튼 크기 조정
                      ElevatedButton(
                        onPressed: () {
                          // 네이버 로그인 동작
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // 배경을 투명으로 설정
                          shadowColor: Colors.transparent, // 그림자 제거
                          padding: const EdgeInsets.all(0), // 기본 패딩 제거
                        ),
                        child: Image.asset('assets/naver.png', width: 200, height: 50), // 크기 조정
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 이용약관 동의 텍스트
                  const Text(
                    '계속 진행함에 따라 Safety And Management의 이용약관에 동의합니다.',
                    style: TextStyle(fontSize: 9, color: Colors.grey),
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