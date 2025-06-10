import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notification.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupPageTemplate extends StatefulWidget {
  const GroupPageTemplate({super.key});

  @override
  State<GroupPageTemplate> createState() => _GroupPageTemplateState();
}

class _GroupPageTemplateState extends State<GroupPageTemplate> {
  // TODO: DB에서 해당 그룹에 해당하는 정보들 맵핑
  final Map<String, dynamic> groupInfo = {
    'backgroundImage': 'assets/default.png',
    'groupNumber': '그룹번호',
    'groupName': '그룹명',
    'groupinviteCode': 'ABC456',
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
  /*
  // TODO: DB API 수정 필요
  Map<String, dynamic>? groupInfo;

  Future<void> fetchGroupData() async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/groups'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'globalUid': globalUid }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        groupInfo = {
          'backgroundImage': data['backgroundImage'],
          'groupNumber': data['groupNumber'],
          'groupName': data['groupName'],
          'inviteCode': data['inviteCode'],
        };
      });

      await fetchGroupMembers(data['groupNumber']);

    } else {
      print('그룹 정보 불러오기 실패');
    }
  }

  // TODO: DB API 수정 필요
  List<Map<String, dynamic>> members = [];

  Future<void> fetchGroupMembers(String groupId) async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/members'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'groupId': groupId }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['members'];

      setState(() {
        members = List<Map<String, dynamic>>.from(data.map((member) => {
          'name': member['name'],
          'isLeader': member['isLeader'],
          'status': member['status'],
          'location': member['location'],
          'relation': member['relation'],
          'profileImage': member['profileImage'],
        }));
      });
    } else {
      print('멤버 불러오기 실패');
    }
  }
  */

  Future<void> InviteCodeDialog(BuildContext context) async {
    final TextEditingController _inviteCodeController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_popup.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '[멤버 초대]',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '친구에게 받은 초대코드를 입력해주세요.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _inviteCodeController,
                    decoration: InputDecoration(
                      hintText: '초대 코드를 입력해주세요.',
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(_inviteCodeController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0073FF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '입력 완료',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
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

    if (result != null && result.isNotEmpty) {
      // TODO: 초대 코드 처리 로직 추가
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('입력한 초대코드: $result')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    //fetchGroupData(); // 최초 실행 시 서버에서 데이터 받아오기
  }


  @override
  Widget build(BuildContext context) {
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
      body: _buildBody(context, groupInfo!, members),
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
                /*
                image: DecorationImage(
                  image: AssetImage(groupInfo['backgroundImage']),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                ),
                */
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
                        '초대코드 | ${groupInfo['groupinviteCode']}',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: groupInfo['groupinviteCode']));
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
                InviteCodeDialog(context);
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