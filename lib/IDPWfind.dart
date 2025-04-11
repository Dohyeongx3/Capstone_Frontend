import 'package:flutter/material.dart';

class IDPWfind extends StatefulWidget {
  final bool isIdFindSelected;

  const IDPWfind({super.key, required this.isIdFindSelected});

  @override
  State<IDPWfind> createState() => _IDPWfindState();
}

class _IDPWfindState extends State<IDPWfind> {
  late bool _isIdFindSelected;

  @override
  void initState() {
    super.initState();
    _isIdFindSelected = widget.isIdFindSelected;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '아이디/비밀번호 찾기',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildSelectionBox("아이디 찾기", true),
                _buildSelectionBox("비밀번호 찾기", false),
              ],
            ),
            const SizedBox(height: 50),
            _isIdFindSelected ? _buildIdFindForm() : _buildPwFindForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionBox(String title, bool isIdOption) {
    final isSelected = (_isIdFindSelected == isIdOption);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isIdFindSelected = isIdOption;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            color: isSelected ? Colors.white : Colors.grey[300],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdFindForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: '휴대전화번호',
            hintText: "'-' 제외하고 입력해주세요",
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(
              onPressed: () {
                // 인증번호 전송 로직
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("인증번호 전송", style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: '인증번호',
            hintText: '인증번호를 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // 아이디 찾기 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BB6D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: const BorderSide(color: Color(0xFF00BB6D), width: 2),
              ),
            ),
            child: const Text(
              "아이디 찾기",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPwFindForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: '아이디',
            hintText: '아이디를 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: '휴대전화번호',
            hintText: "'-' 제외하고 입력해주세요",
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(
              onPressed: () {
                // 인증번호 전송 로직
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("인증번호 전송", style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: '인증번호',
            hintText: '인증번호를 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // 비밀번호 재설정 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BB6D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: const BorderSide(color: Color(0xFF00BB6D), width: 2),
              ),
            ),
            child: const Text(
              "비밀번호 재설정 하기",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}