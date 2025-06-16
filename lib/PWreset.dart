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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

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
          '이메일/비밀번호 찾기',
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
              const SizedBox(height: 50),
              if (_showResetPasswordForm)
                _buildResetPasswordForm()
              else
                _buildPwFindForm(),
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

  Widget _buildPwFindForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이메일 입력
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: '이메일',
            hintText: '이메일을 입력해주세요',
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(
              onPressed: () {
                // TODO: 이메일로 인증번호 전송
                print('인증번호 전송 to ${_emailController.text}');
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

        // 인증번호 입력
        TextField(
          controller: _codeController,
          decoration: const InputDecoration(
            labelText: '인증번호',
            hintText: '이메일로 받은 인증번호를 입력해주세요',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 50),

        // 인증 확인 버튼
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // TODO: 이메일과 인증번호 검증 후 다음 화면으로
              print('입력한 이메일: ${_emailController.text}');
              print('입력한 인증번호: ${_codeController.text}');
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

    // TODO: 클라이언트가 입력한 newPw 변수를 서버에서 해당 사용자의 입력한 비밀번호 변경
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