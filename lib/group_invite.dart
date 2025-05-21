import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupInvite extends StatelessWidget {
  const GroupInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true, // 텍스트 가운데 정렬
        title: const Text(
          '그룹 관리',
          style: TextStyle(
            color: Color(0xFF4B4B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.notifications_outlined, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // 예시 데이터 (DB에서 데이터를 가져올 때 이 데이터를 대신 사용할 수 있습니다)
    final members = [
      {'name': '그룹장', 'isLeader': true, 'status': '안전', 'location': '위치1', 'relation': '관계1'},
      {'name': '멤버1', 'isLeader': false, 'status': '위험', 'location': '위치2', 'relation': '관계2'},
      {'name': '멤버2', 'isLeader': false, 'status': '안전', 'location': '위치3', 'relation': '관계3'},
      // 여기에 추가적인 멤버들을 넣을 수 있음
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 검은색 그룹 정보 박스
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '그룹번호',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '그룹명',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Member:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white70),
                Row(
                  children: [
                    const Text(
                      '초대코드 | ABC123',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: 'ABC123'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('초대코드가 복사되었습니다'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // 그룹장 섹션
          const Text(
            '그룹장',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // 그룹장 정보
          _buildMemberInfo(members.firstWhere((member) => member['isLeader'] == true)),

          const SizedBox(height: 32),

          // 멤버 섹션
          const Text(
            '멤버',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // 멤버 목록
          Expanded(
            child: ListView.builder(
              itemCount: members.length - 1,  // 첫 번째는 그룹장이므로 제외
              itemBuilder: (context, index) {
                var member = members[index + 1]; // 첫 번째 그룹장은 이미 처리되었으므로 인덱스 1부터 시작
                return Column(
                  children: [
                    _buildMemberInfo(member),
                    const Divider(color: Colors.grey, height: 50), // 각 멤버 사이에 얇은 회색 경계선 추가
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // "멤버 추가" 버튼
          const Text(
            '추가',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // 멤버 초대하기 버튼
          GestureDetector(
            onTap: () {
              // 여기에 멤버 초대 기능 추가
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('멤버 초대하기 기능')),
              );
            },
            child: Container(
              width: double.infinity, // 가로 꽉 차게 만들기
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF0073FF), // 파란색 배경
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '멤버 초대하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center, // ← 가운데 정렬
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberInfo(Map<String, dynamic> member) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 프로필 + 상태 뱃지
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/default_profile.png'),
              backgroundColor: Colors.grey,
            ),
            Positioned(
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: member['status'] == '안전' ? const Color(0xFF00BB6D) : const Color(0xFFFF6200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  member['status'], // 안전/위험 상태
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),

        // 이름, 위치, 관계 정보
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member['name'], // 그룹장/멤버 이름
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '현재 위치: ${member['location']}', // 위치 정보
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '관계: ${member['relation']}', // 관계 정보
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}