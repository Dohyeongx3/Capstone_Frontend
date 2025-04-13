import 'package:flutter/material.dart';

class GroupInvite extends StatelessWidget {
  const GroupInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: const [
            Text(
              '그룹 초대',
              style: TextStyle(
                color: Color(0xFF4B4B4B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 10),
            Icon(Icons.notifications, color: Colors.black),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '지금 그룹원을 초대해,\n서로의 안전을 확인하세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                '그룹 (Family)',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // 그룹원 목록 그리드
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  _GroupCircle(icon: Icons.person, label: '나'),
                  _GroupCircle(icon: Icons.person_add, label: 'Family'),
                  _GroupCircle(icon: Icons.person_add, label: 'Family'),
                  _GroupCircle(icon: Icons.person_add, label: 'Family'),
                  _GroupCircle(icon: Icons.person_add, label: 'Friend'),
                  _GroupCircle(icon: Icons.person_add, label: 'Friend'),
                ],
              ),

              const SizedBox(height: 32),
              const Text('초대코드', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // 초대코드 입력 로직
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BB6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '초대코드 입력',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupCircle extends StatelessWidget {
  final IconData icon;
  final String label;

  const _GroupCircle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.grey[300],
          child: Icon(icon, size: 36, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}