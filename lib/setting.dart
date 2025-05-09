import 'package:flutter/material.dart';

import 'escape.dart';
import 'group.dart';
import 'home.dart';
import 'info.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int _selectedIndex = 4; // 설정 화면이므로 인덱스 4로 설정

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // AppBar 설정
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Text(
            '설정',
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

  // Body 구성
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 프로필
          Row(
            children: [
              // 프로필 이미지
              ClipOval(
                child: Icon(Icons.person)
              ),
              const SizedBox(width: 16),
              // 사용자 이름과 기본 정보 보기
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '사용자 이름', // 실제 사용자 이름으로 바꾸세요
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '기본 정보 보기',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              // 오른쪽 '>' 아이콘
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 24),

          // 대피 이력 섹션
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // 대피 이력 텍스트
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '대피 이력',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '완료된 대피 경로와 세부 이력을 확인하세요.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                // "보기" 텍스트 버튼
                TextButton(
                  onPressed: () {
                    // 대피 이력 보기 동작 추가 가능
                  },
                  child: const Text(
                    '보기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF00BB6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey, thickness: 1),

          // 서비스 섹션
          const SizedBox(height: 16),
          const Text(
            '서비스',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // 서비스 항목들
          _buildServiceOption(
            icon: Icons.arrow_forward,
            text: '현재 위치 추적 활성화',
            onOffButton: true,
          ),
          const SizedBox(height: 12),
          _buildServiceOption(
            icon: Icons.notifications,
            text: '재난 알림 활성화',
            onOffButton: true,
          ),
          const SizedBox(height: 12),
          _buildServiceOption(
            icon: Icons.volume_up,
            text: 'TTS 안내 활성화',
            onOffButton: true,
          ),
        ],
      ),
    );
  }

  // 서비스 항목을 만드는 위젯
  Widget _buildServiceOption({
    required IconData icon,
    required String text,
    required bool onOffButton,
  }) {
    return Row(
      children: [
        // 아이콘
        Icon(icon, size: 30, color: Colors.black),
        const SizedBox(width: 16),
        // 텍스트
        Text(text, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        // On/Off 버튼
        Switch(
          value: true, // 실제로는 상태에 따라 변경되게 할 수 있음
          onChanged: (bool value) {},
          activeColor: const Color(0xFF00BB6D), // 활성화 상태 트랙 색상
          inactiveThumbColor: Colors.white, // 비활성화 상태 동그라미 색상 (흰색)
          inactiveTrackColor: Colors.grey, // 비활성화 상태 트랙 색상
          activeTrackColor: const Color(0xFF00BB6D), // 활성화 상태 트랙 색상
          thumbColor: MaterialStateProperty.all(Colors.white), // 동그라미 색상 흰색
        ),
      ],
    );
  }

  // BottomNavigationBar 설정
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