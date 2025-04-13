import 'package:disasterescape/setting.dart';
import 'package:flutter/material.dart';
import 'escape.dart';
import 'group.dart';
import 'home.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _selectedIndex = 1;

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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        children: const [
          Text(
            '사전재난대비 정보제공',
            style: TextStyle(
              color: Color(0xFF4B4B4B),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Spacer(),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.notifications, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Natural disaster information",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          const Text(
            "자연재난",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildGrid([
            {'label': '기상재난', 'image': 'assets/weather.png'},
            {'label': '지진재난', 'image': 'assets/earthquake.png'},
            {'label': '해양재난', 'image': 'assets/marine.png'},
            {'label': '지질재난', 'image': 'assets/geology.png'},
            {'label': '우주재난', 'image': 'assets/space.png'},
            {'label': '생태재난', 'image': 'assets/ecology.png'},
          ], crossAxisCount: 3),
          const Divider(height: 40, thickness: 1),
          const Text(
            "Social disaster information",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          const Text(
            "사회재난",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildGrid([
            {'label': '인적사고', 'image': 'assets/human.png'},
            {'label': '사회적혼란', 'image': 'assets/social.png'},
            {'label': '감염병', 'image': 'assets/infectious.png'},
            {'label': '산업재해', 'image': 'assets/industrial.png'},
          ], crossAxisCount: 2),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Map<String, String>> items, {required int crossAxisCount}) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        return _buildDisasterTile(items[index]['label']!, items[index]['image']!);
      },
    );
  }

  Widget _buildDisasterTile(String label, String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey, // 테두리색
          width: 1,                 // 테두리 두께
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,  // 이미지 크기 키운 부분
              height: 60, // 이미지 크기 키운 부분
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 24,        // 텍스트 크기 키운 부분
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: '재난정보'),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '대피경로'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: '그룹'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }
}