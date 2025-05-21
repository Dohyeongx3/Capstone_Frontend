import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'escape.dart';
import 'home.dart';
import 'info.dart';
import 'setting.dart';
import 'group_invite.dart';

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

  // 위험 상태 멤버 리스트 예시
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

  final List<Map<String, dynamic>> groups = [
    {'name': '그룹1', 'members': 4},
    {'name': '그룹2', 'members': 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_outlined),
        ],
      ),
    );
  }

  Widget _buildBody() {
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
                      // 왼쪽: 상태 + 이름 + 이메일
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
                              child: const Text(
                                '안전', // 위험일 경우 '위험'
                                style: TextStyle(
                                  color: Color(0xFF00BB6D), // 위험: Color(0xFFFF6200)
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '사용자 이름',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'abc123@gmail.com',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 오른쪽: 프로필 이미지
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/default_profile.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 8),
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
                          Clipboard.setData(const ClipboardData(text: 'ABC123')); // 복사
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
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // 추가 버튼 카드
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GroupInvite()),
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