import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'demo.dart';
import 'escape.dart';
import 'home.dart';
import 'info.dart';
import 'notification.dart';
import 'setting.dart';
import 'group_template.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Group extends StatefulWidget {
  const Group({Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    int previousIndex = _selectedIndex;  // 화면을 전환하기 전에 현재 selectedIndex를 저장

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Info()));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Escape(selectedIndex: previousIndex), // 변경되기 전의 selectedIndex 전달
          ),
        ).then((returnedIndex) {
          if (returnedIndex != null) {
            setState(() {
              _selectedIndex = returnedIndex; // Escape 화면에서 반환된 selectedIndex로 업데이트
            });
          }
        });
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Group()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
        break;
    }
  }
  /*
  // TODO: 사용자 프로필 호출 테스트, DB API 수정 필요
  Map<String, dynamic>? UserData;

  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/profile'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'globalUid': globalUid }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        UserData = data;
      });
    } else {
      print('사용자 정보 불러오기 실패');
    }
  }


  //TODO: 위험 멤버 호출 테스트, DB API 수정 필요
  List<Map<String, String?>> dangerMembers = [];

  Future<void> fetchDangerMembers() async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/danger'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'globalUid': globalUid }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      setState(() {
        dangerMembers = data.map<Map<String, String?>>((member) => {
          'name': member['name'],
          'image': member['image'],
        }).toList();
      });
    } else {
      print('위험 멤버 불러오기 실패');
    }
  }


  //TODO: 그룹 호출 테스트, DB API 수정 필요
  List<Map<String, dynamic>> groups = [];

  Future<void> fetchGroups() async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/groups'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'globalUid': globalUid }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      setState(() {
        groups = data.map<Map<String, dynamic>>((group) => {
          'name': group['name'],
          'members': group['members'],
          'backgroundimage': group['backgroundimage'],
        }).toList();
      });
    } else {
      print('그룹 목록 불러오기 실패');
    }
  }
  */
  //TODO: DB에서 로그인된 사용자 정보 맵핑해서 리스트에서 연결(setting.dart,editprofile.dart,group.dart 공통)
  final Map<String, dynamic> UserData = {
    'name': '사용자 이름',
    'year': 2000,
    'month': 11,
    'day': 11,
    'phone': '010-1234-5678',
    'status': 'SAFE',// 'SAFE', 'DANGER', 'CHECKING'
    'profileImage': 'assets/default.png',
  };
  //TODO: DB에서 그룹 내 속한 모든 상태가 DANGER인사람 모아서 호출
  final List<Map<String, String?>> dangerMembers = [
    {
      'name': '홍길동',
      'image': 'assets/default_profile.png',
    },
    {
      'name': '김길동',
      'image': 'assets/default_profile.png',
    },
    {
      'name': null, // 이름 없음
      'image': null, // 이미지 없음
    },
  ];
  //TODO: DB에서 사용자가 속한 모든 그룹 호출
  final List<Map<String, dynamic>> groups = [
    {'name': '그룹1', 'members': 4 ,'backgroundimage': 'assets/default_profile.png'},
    {'name': '그룹2', 'members': 6 ,'backgroundimage': 'assets/default_profile.png'},
  ];

  Future<void> GroupInviteCodeDialog(BuildContext context) async {
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
                    '[그룹 들어가기]',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '친구에게 받은 그룹코드를 입력해주세요.',
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
                      hintText: '그룹 코드를 입력해주세요.',
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
      // TODO: 그룹 코드 처리 로직 추가
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('입력한 그룹코드: $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            '그룹',
            style: TextStyle(
              color: Color(0xFF4B4B4B),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final user = UserData;
    //final user = UserData!;

    Color statusColor;
    String statusText;

    switch (user['status']) {
      case 'SAFE':
        statusColor = const Color(0xFF00BB6D);
        statusText = '안전';
        break;
      case 'DANGER':
        statusColor = const Color(0xFFFF6200);
        statusText = '위험';
        break;
      case 'CHECKING':
        statusColor = const Color(0xFF007EFF);
        statusText = '확인중';
        break;
      default:
        statusColor = Colors.grey;
        statusText = '알 수 없음';
    }
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '마이 프로필',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0073FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 왼쪽: 상태 + 이름 + 전화번호
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user['phone'],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 오른쪽: 프로필 이미지
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(user['profileImage'] ?? 'assets/default_profile.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // 아래 위험 상태 멤버 섹션
            const SizedBox(height: 32),
            const Text(
              '현재 위험 상태 멤버',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dangerMembers.map((member) {
                  final String? name = member['name'];
                  final String? image = member['image'];
                  final bool isMissing = name == null;

                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // 아바타
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: image != null ? Colors.transparent : Colors.grey,
                          backgroundImage: image != null ? AssetImage(image) : null,
                          child: image == null
                              ? const Icon(Icons.close, color: Colors.white)
                              : null,
                        ),

                        // 이름 태그
                        Positioned(
                          bottom: -10, // 아바타 아래로 겹치게 위치 조정
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: isMissing ? const Color(0xFF676767) : const Color(0xFFFF6200),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              name ?? '없음',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // 전체 그룹 섹션
            const SizedBox(height: 32),
            const Text(
              '전체 그룹',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child:Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // 추가 버튼 카드
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GroupPageTemplate()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF676767),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '추가',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 그룹 카드들
                  ...groups.map((group) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${group['members']}명 참여 중',
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text('추가', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                GroupInviteCodeDialog(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0073FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '그룹 들어가기',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 실제 bottomNavigationBar 영역
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: '재난정보'),
              BottomNavigationBarItem(
                icon: Opacity(opacity: 0, child: Icon(Icons.circle)), // 높이 맞춤용 숨겨진 아이콘
                label: '대피경로',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: '그룹'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            onTap: _onItemTapped,
          ),

          // 여기서 이미지와 상호작용할 수 있도록 GestureDetector 사용
          Positioned(
            top: -25, // 위로 튀어나오도록 위치 조절
            left: MediaQuery.of(context).size.width / 2 - 30, // 가운데 정렬
            child: GestureDetector(
              onTap: () {
                _onItemTapped(2); // 대피경로 화면으로 이동
              },
              child: Container(
                width: 60,
                height: 60,
                color: Colors.transparent, // 터치 영역 확장
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/escapebutton.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}