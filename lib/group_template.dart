import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notification.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupPageTemplate extends StatefulWidget {
  final Map<String, dynamic> groupInfo;
  final List<Map<String, dynamic>> members;

  const GroupPageTemplate({
    Key? key,
    required this.groupInfo,
    required this.members,
  }) : super(key: key);

  @override
  State<GroupPageTemplate> createState() => _GroupPageTemplateState();
}

class _GroupPageTemplateState extends State<GroupPageTemplate> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final groupInfo = widget.groupInfo;
    final members = widget.members;
    final String? currentUserUid = globalUid;

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
                image: DecorationImage(
                  image: AssetImage('assets/group_default.png'),
                  fit: BoxFit.cover,
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
            _buildMemberInfo(
              members.firstWhere((m) => m['isLeader'] == true),
              isCurrentUser: members.firstWhere((m) => m['isLeader'] == true)['uid'] == globalUid,
              isCurrentUserLeader: members.any((m) => m['uid'] == globalUid && m['isLeader'] == true),
            ),

            const SizedBox(height: 32),
            const Text('멤버', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // 일반 멤버들 반복 렌더링
            ...members.where((m) => m['isLeader'] != true).map((member) {
              return Column(
                children: [
                  _buildMemberInfo(
                    member,
                    isCurrentUser: member['uid'] == globalUid,
                    isCurrentUserLeader: members.any((m) => m['uid'] == globalUid && m['isLeader'] == true),
                  ),
                  const Divider(color: Colors.grey, height: 50),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberInfo(
      Map<String, dynamic> member, {
        required bool isCurrentUser,
        required bool isCurrentUserLeader,
      }) {
    final bool showKickButton = isCurrentUserLeader && !isCurrentUser;
    final bool showLeaveButton = !isCurrentUserLeader && isCurrentUser;

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
                  member['status'],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),

        // 이름, 위치, 전화번호
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
              Text('전화번호: ${member['phone']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),

        // 내보내기 또는 나가기 버튼 (globalUid가 null이 아니고 조건에 맞을 때만)
        if (globalUid != null && (showKickButton || showLeaveButton))
          GestureDetector(
            onTap: () {
              if (showKickButton) {
                // TODO: 클라이언트가 groupInfo의 groupinvitecode와 해당 멤버의 이름을 보내면 서버에서 해당 멤버 그룹에서 삭제
                print('${member['name']} 내보내기');
              } else if (showLeaveButton) {
                // TODO: 클라이언트가 groupInfo의 groupinvitecode과 사용자의 이름을 보내면 서버에서 내 정보를 멤버 그룹에서 삭제
                print('${member['name']} 나가기');
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF676767),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                showKickButton ? '내보내기' : '나가기',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}