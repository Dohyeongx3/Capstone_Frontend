import 'package:flutter/material.dart';

class IDPWfind extends StatefulWidget {
  final bool isIdFindSelected;

  const IDPWfind({super.key, required this.isIdFindSelected});

  @override
  State<IDPWfind> createState() => _IDPWfindState();
}

class _IDPWfindState extends State<IDPWfind> {
  late bool _isIdFindSelected;
  bool _showResetPasswordForm = false;

  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  bool _obscureNewPw = true;
  bool _obscureConfirmPw = true;

  @override
  void initState() {
    super.initState();
    _isIdFindSelected = widget.isIdFindSelected;
  }

  @override
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_showResetPasswordForm)
                Row(
                  children: [
                    _buildSelectionBox("아이디 찾기", true),
                    _buildSelectionBox("비밀번호 찾기", false),
                  ],
                ),
              const SizedBox(height: 50),
              if (_showResetPasswordForm)
                _buildResetPasswordForm()
              else
                _isIdFindSelected ? _buildIdFindForm() : _buildPwFindForm(),
            ],
          ),
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
            border: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
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
                // TODO: 파이어베이스 통한 휴대폰 인증번호 로직
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
              // TODO: 아이디 찾기 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0073FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text("아이디 찾기", style: TextStyle(fontSize: 16, color: Colors.white)),
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
                // TODO: 파이어베이스 통한 휴대폰 인증번호 로직
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
              //TODO: 아이디와 인증번호가 DB정보와 맞아야 넘어가도록 처리
              setState(() {
                _showResetPasswordForm = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0073FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text("비밀번호 재설정 하기", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _newPwController,
          obscureText: _obscureNewPw,
          decoration: InputDecoration(
            labelText: '새 비밀번호',
            hintText: '새로운 비밀번호를 입력해주세요.',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(_obscureNewPw ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureNewPw = !_obscureNewPw;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _confirmPwController,
          obscureText: _obscureConfirmPw,
          decoration: InputDecoration(
            labelText: '새 비밀번호 확인',
            hintText: '새로운 비밀번호를 한 번 더 입력해주세요.',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPw ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureConfirmPw = !_obscureConfirmPw;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _handlePasswordReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0073FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text("비밀번호 변경하기", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  void _handlePasswordReset() {
    final newPw = _newPwController.text.trim();
    final confirmPw = _confirmPwController.text.trim();

    if (newPw.isEmpty || confirmPw.isEmpty) {
      _showDialog("비밀번호를 모두 입력해주세요.");
      return;
    }

    if (newPw != confirmPw) {
      _showDialog("비밀번호가 일치하지 않습니다.");
      return;
    }

    // TODO: 실제 비밀번호 변경 처리
    _showDialog("비밀번호가 성공적으로 변경되었습니다.");
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 닫기
              if (message.contains("성공적으로")) {
                Navigator.pop(context); // 성공 시 이전 화면으로
              }
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}