import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'onboard.dart';

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
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
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
        child: _currentStep == 0 ? _buildStepOne() : _currentStep == 1 ? _buildStepTwo() : _buildSuccessStep(),
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
            color: Color(0xFF0073FF),
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
        const Text('생년월일', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '년',
                  hintText: 'YYYY',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextField(
                controller: _monthController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '월',
                  hintText: 'MM',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextField(
                controller: _dayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '일',
                  hintText: 'DD',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
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
              backgroundColor: const Color(0xFF0073FF),
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
            hintText: '비밀번호는 8~16자의 영문 대/소문자, 숫자, 특수문자 사용',
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
                    backgroundColor: const Color(0xFF0073FF),
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
                    // 모든 필드 입력 여부 확인
                    if (_nameController.text.isEmpty ||
                        _yearController.text.isEmpty ||
                        _monthController.text.isEmpty ||
                        _dayController.text.isEmpty ||
                        _idController.text.isEmpty ||
                        _pwController.text.isEmpty ||
                        _confirmPwController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('모든 필드를 입력해주세요.')),
                      );
                      return;
                    }

                    // 아이디 길이 검사
                    final userId = _idController.text.trim();
                    if (userId.length < 5 || userId.length > 13) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('아이디는 5~13자여야 합니다.')),
                      );
                      return;
                    }

                    // 비밀번호 정규식 검사: 8~16자, 영문 대/소문자 + 숫자 + 특수문자
                    final password = _pwController.text.trim();
                    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,16}$');

                    if (!passwordRegex.hasMatch(password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호는 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.')),
                      );
                      return;
                    }

                    // 비밀번호 일치 확인
                    final passwordCheck = _confirmPwController.text.trim();
                    if (password != passwordCheck) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                      );
                      return;
                    }

                    final name = _nameController.text.trim();
                    final year = _yearController.text.trim();
                    final month = _monthController.text.trim();
                    final day = _dayController.text.trim();
                    
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
                          'year': year,
                          'month': month,
                          'day': day
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
                    backgroundColor: const Color(0xFF0073FF),
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

  Widget _buildSuccessStep() {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/success.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 30),
              Text(
                "${_nameController.text}님 가입이 완료되었습니다!",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0073FF),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "SAM과 함께 안전한 하루를 시작해보세요.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0073FF),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Onboard()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0073FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text(
              "홈으로",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}