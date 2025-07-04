import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';


import 'onboard.dart';
import 'PWreset.dart';
import 'home.dart';
import 'globals.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  Future<void> loginUser() async {
    final id = _idController.text.trim();
    final pw = _pwController.text.trim();

    if (id.isEmpty || pw.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("아이디와 비밀번호를 입력해주세요."),
        ),
      );
      return;
    }

    final url = Uri.parse('https://capstoneserver-etkm.onrender.com/api/auth/login'); // 주소 수정

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': id, 'password': pw}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          globalUid = data['uid'];

          // SharedPreferences에 저장
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', globalUid!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          _showErrorDialog(data['message'] ?? '로그인 실패');
        }
      } else if(response.statusCode == 401){
        final data = jsonDecode(response.body);
        _showErrorDialog('로그인 실패: ${data['message']}');
      } else{
        _showErrorDialog('서버 오류 : ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('서버와 연결할 수 없습니다.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
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
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboard()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('개인회원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'email@example.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _pwController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: '비밀번호',
                hintText: '8~16자의 영문 대/소문자, 숫자, 특수문자',
                border: const OutlineInputBorder(),
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0073FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  "로그인하기",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  "임시 홈 이동 버튼",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const IDPWfind(isIdFindSelected: false)));
                  },
                  child: const Text("비밀번호 찾기", style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}