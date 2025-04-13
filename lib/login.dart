import 'package:flutter/material.dart';

import 'register.dart';
import 'onboard.dart';
import 'IDPWfind.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _autoLogin = false;

  // 아이디/비밀번호 찾기 페이지로 이동
  void navigateToIDPWFind(bool isIdFind) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IDPWfind(isIdFindSelected: isIdFind),
      ),
    );
  }

  // 임시 홈 화면으로 이동
  void navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '로그인',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('개인회원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: _autoLogin,
                  onChanged: (bool? value) {
                    setState(() {
                      _autoLogin = value ?? false;
                    });
                  },
                ),
                Text("자동 로그인"),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 로그인 로직 구현 예정
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BB6D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "로그인하기",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            // 임시 홈 이동 버튼
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: navigateToHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "임시 홈 이동 버튼",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => navigateToIDPWFind(true),
                  child: Text("아이디 찾기"),
                ),
                SizedBox(width: 20),
                Text("|"),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () => navigateToIDPWFind(false),
                  child: Text("비밀번호 찾기"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}