import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _currentPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  bool _obscureCurrentPw = true;
  bool _obscureNewPw = true;
  bool _obscureConfirmPw = true;

  @override
  void dispose() {
    _currentPwController.dispose();
    _newPwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  void _handlePasswordReset() {
    final currentPw = _currentPwController.text.trim();
    final newPw = _newPwController.text.trim();
    final confirmPw = _confirmPwController.text.trim();

    if (currentPw.isEmpty || newPw.isEmpty || confirmPw.isEmpty) {
      _showDialog("모든 비밀번호를 입력해주세요.");
      return;
    }

    if (newPw != confirmPw) {
      _showDialog("새 비밀번호가 일치하지 않습니다.");
      return;
    }

    // TODO: 비밀번호 변경 로직 구현

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
              Navigator.pop(context);
              if (message.contains("성공적으로")) {
                Navigator.pop(context);
              }
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // 텍스트 가운데 정렬
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black), // 뒤로가기 아이콘 검정색
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _currentPwController,
              obscureText: _obscureCurrentPw,
              decoration: InputDecoration(
                labelText: '현재 비밀번호',
                hintText: '현재 비밀번호를 입력해주세요.',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPw ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPw = !_obscureCurrentPw;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPwController,
              obscureText: _obscureNewPw,
              decoration: InputDecoration(
                labelText: '새로운 비밀번호',
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
                labelText: '새로운 비밀번호 확인',
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
                child: const Text(
                  "비밀번호 변경하기",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({super.key});

  @override
  State<AccountDeletePage> createState() => _AccountDeletePageState();
}

class _AccountDeletePageState extends State<AccountDeletePage> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> showDeleteAccountDialog(BuildContext context) async {
      final shouldDelete = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        const Text(
                          '[회원 탈퇴]',
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(text: '정말로 '),
                              TextSpan(
                                text: '회원탈퇴',
                                style: TextStyle(
                                  color: Color(0xFF0073FF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: '를 진행하시겠습니까?\n'),
                              TextSpan(
                                text:
                                '탈퇴 시 모든 정보가 삭제되며,\n다시 복구할 수 없습니다.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
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
                            onTap: () {
                              // TODO: 회원 탈퇴 처리 로직 구현
                              Navigator.of(context).pop(true);
                            },
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
                                '탈퇴하기',
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

      if (shouldDelete == true) {
        // TODO: 실제 회원 탈퇴 처리 및 후속 동작 구현
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '회원 탈퇴',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '계정 삭제',
              style: TextStyle(
                color: Color(0xFF0073FF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '회원 탈퇴 시 계정과 관련된 모든 정보가 삭제되며,\n삭제된 데이터는 복구되지 않습니다.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              '탈퇴 시 삭제되는 데이터',
              style: TextStyle(
                color: Color(0xFF0073FF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '회원 탈퇴를 진행하시면 아래 정보가 모두 삭제됩니다.\n삭제된 데이터는 복구할 수 없습니다.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• 로그인 계정 정보",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0073FF)),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "• 그룹 참여 내역 및 기록",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0073FF)),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "• 대피 이력 및 설정 데이터",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0073FF)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              '탈퇴 사유 (선택)',
              style: TextStyle(
                color: Color(0xFF0073FF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '탈퇴 사유를 입력해 주세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                '위 내용을 확인하였으며, 모든 정보가 삭제되는 것에 동의합니다.',
                style: TextStyle(
                  color: Color(0xFF8B8B8B),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await showDeleteAccountDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0073FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  '회원 탈퇴하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}