import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _currentStep = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _currentStep == 0 ? _buildStepOne() : _buildStepTwo(),
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '반가워요! 이름과 생년월일을 알려주세요.',
          style: TextStyle(
            color: Color(0xFF00BB6D),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        const Text('회원 정보 입력 (1/2)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(height: 40),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: '이름',
            hintText: '이름을 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _birthController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '생년월일',
            hintText: '생년월일 8자리 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentStep = 1;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BB6D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text(
              "다음",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('회원 정보 입력 (2/2)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(height: 40),
        TextField(
          controller: _idController,
          decoration: InputDecoration(
            labelText: '아이디',
            hintText: '5~13자의 영문 또는 영문 + 숫자 합',
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(
              onPressed: () {
                // 중복 확인 로직
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("중복 확인", style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _pwController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: '비밀번호',
            hintText: '비밀번호를 입력해주세요',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _confirmPwController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: '비밀번호 확인',
            hintText: '비밀번호를 한번 더 입력해주세요',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons
                  .visibility),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BB6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    "이전",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final birth = _birthController.text.trim();
                    final userId = _idController.text.trim();
                    final password = _pwController.text.trim();
                    final confirmPassword = _confirmPwController.text.trim();

                    // 비밀번호와 비밀번호 확인이 일치하는지 확인
                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                      );
                      return;
                    }

                    // 서버로 회원가입 요청
                    final url = Uri.parse('https://capstoneserver-etkm.onrender.com/api/auth/register');

                    try {
                      final response = await http.post(
                        url,
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'userId': userId,
                          'password': password,
                          'name': name,
                          'birth': birth,
                        }),
                      );

                      if (response.statusCode == 201) {
                        // 회원가입 성공
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('회원가입 성공!')),
                        );
                        Navigator.pop(context); // 또는 로그인 화면 등으로 이동
                      } else {
                        // 회원가입 실패
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('회원가입 실패: ${response.body}')),
                        );
                      }
                    } catch (e) {
                      print('회원가입 요청 실패: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('서버 연결 실패')),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BB6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    "가입하기",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}