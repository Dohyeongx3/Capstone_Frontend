import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';


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

  Future<bool> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        '[SAM 앱 종료]',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Image.asset(
                        'assets/icon_popup.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: '앱을 ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text: '종료',
                              style: TextStyle(
                                color: Color(0xFF0073FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '하시겠습니까?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF949494),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              '취소',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF0073FF),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              '종료',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          final shouldExit = await _showExitDialog(context);
          if (shouldExit) {
            SystemNavigator.pop(); // 앱 종료
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
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
                ElevatedButton(
                  onPressed: () => navigateToRegister(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(320, 50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '회원가입 시, SAM의 ',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                      children: [
                        TextSpan(
                          text: '개인정보처리방침',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicyPage()),
                              );
                            },
                        ),
                        const TextSpan(
                          text: ' 및 ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: '이용약관',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TermsOfServicePage()),
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
      ),
    );
  }
}