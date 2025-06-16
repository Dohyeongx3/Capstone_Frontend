import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupPageTemplate extends StatefulWidget {
  final Map<String, dynamic> groupInfo;
  final List<Map<String, dynamic>> members;
  final List<Map<String, dynamic>> groups;
  final VoidCallback? onGroupChanged;

  const GroupPageTemplate({
    Key? key,
    required this.groupInfo,
    required this.members,
    required this.groups,
    this.onGroupChanged,
  }) : super(key: key);

  @override
  State<GroupPageTemplate> createState() => _GroupPageTemplateState();
}

class _GroupPageTemplateState extends State<GroupPageTemplate> {
  late Map<String, dynamic> groupInfo;
  late List<Map<String, dynamic>> members;

  @override
  void initState() {
    super.initState();
    groupInfo = Map<String, dynamic>.from(widget.groupInfo);
    members = List<Map<String, dynamic>>.from(widget.members);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onGroupChanged?.call();
    });
  }

  Future<void> fetchGroupData(List<Map<String, dynamic>> groups) async {
    final groupCode = groupInfo['groupinviteCode'];

    try {
      // 서버 getGroupInfo API가 없으므로, 클라이언트에 있는 groups 리스트에서 찾음
      final foundGroup = groups.firstWhere(
            (g) => g['groupinviteCode'] == groupCode,
        orElse: () => {},
      );

      if (foundGroup.isNotEmpty) {
        // 그룹 정보와 멤버 리스트를 업데이트 (members가 foundGroup 안에 있어야 함)
        setState(() {
          groupInfo = Map<String, dynamic>.from(foundGroup);
          members = List<Map<String, dynamic>>.from(foundGroup['members'] ?? []);
        });

        widget.onGroupChanged?.call();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('해당 그룹 정보를 찾을 수 없습니다'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('그룹 정보 불러오기 중 오류가 발생했습니다'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupInfo = this.groupInfo;
    final members = this.members;
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
            icon: const Icon(Icons.refresh, color: Color(0xFF4B4B4B)),
            onPressed: () => fetchGroupData(widget.groups),
          ),
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
                  color: member['status'] == 'SAFE' ? const Color(0xFF00BB6D) : const Color(0xFFFF6200),
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
            onTap: () async {
              final groupCode = widget.groupInfo['groupinviteCode'];
              if (showKickButton) {
                final response = await http.post(
                  Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/exitGroup'),
                  headers: { 'Content-Type': 'application/json' },
                  body: jsonEncode({ 'groupCode': groupCode,'uId': member['uid'] }),
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${member['name']} 내보내기 성공')),
                  );
                  await fetchGroupData(widget.groups);
                } else {
                  print('그룹 내보내기 실패');
                }
                print('${member['name']} 내보내기');
              }
              else if (showLeaveButton) {
                final response = await http.post(
                  Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/exitGroup'),
                  headers: { 'Content-Type': 'application/json' },
                  body: jsonEncode({ 'groupCode': groupCode,'uId': member['uid'] }),
                );
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('그룹에서 나가기 성공')),
                  );
                  Navigator.pop(context); // 나가면 화면 종료
                  widget.onGroupChanged?.call();
                } else {
                  print('그룹 나가기 실패');
                }
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