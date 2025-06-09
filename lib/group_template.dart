import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notification.dart';

class GroupPageTemplate extends StatelessWidget {
  const GroupPageTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: DB에서 해당 그룹에 해당하는 정보들 맵핑
    final Map<String, dynamic> groupInfo = {
      'backgroundImage': 'assets/default.png',
      'groupNumber': '그룹번호',
      'groupName': '그룹명',
      'inviteCode': 'ABC123',
    };

    // TODO: DB에서 해당 그룹에 해당하는 그룹원 정보들 맵핑
    final List<Map<String, dynamic>> members = [
      {
        'name': '그룹장',
        'isLeader': true,
        'status': '안전',
        'location': '위치1',
        'relation': '관계1',
        'profileImage': 'assets/default.png', //
      },
      {
        'name': '멤버1',
        'isLeader': false,
        'status': '위험',
        'location': '위치2',
        'relation': '관계2',
        'profileImage': 'assets/default.png',
      },
      {
        'name': '멤버2',
        'isLeader': false,
        'status': '안전',
        'location': '위치3',
        'relation': '관계3',
        'profileImage': 'assets/default.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          '그룹 관리',
          style: TextStyle(
            color: Color(0xFF4B4B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _buildBody(context, groupInfo, members),
    );
  }

  Widget _buildBody(BuildContext context, Map<String, dynamic> groupInfo, List<Map<String, dynamic>> members) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 그룹 정보 박스
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(groupInfo['backgroundImage']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                ),
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
                    child: Text(
                      groupInfo['groupNumber'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    groupInfo['groupName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Member: ${members.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white70),
                  Row(
                    children: [
                      Text(
                        '초대코드 | ${groupInfo['inviteCode']}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: groupInfo['inviteCode']));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('초대코드가 복사되었습니다')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text('그룹장', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildMemberInfo(members.firstWhere((m) => m['isLeader'] == true)),

            const SizedBox(height: 32),
            const Text('멤버', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // 일반 멤버들 반복 렌더링
            ...members.where((m) => m['isLeader'] != true).map((member) {
              return Column(
                children: [
                  _buildMemberInfo(member),
                  const Divider(color: Colors.grey, height: 50),
                ],
              );
            }).toList(),

            const SizedBox(height: 16),
            const Text('추가', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('멤버 초대하기 기능')),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0073FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '멤버 초대하기',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 20), // 하단 버튼 공간 확보
          ],
        ),
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
            CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage(member['profileImage'] ?? 'assets/default_profile.png'),
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
                  member['status'],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member['name'],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('현재 위치: ${member['location']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              Text('관계: ${member['relation']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}