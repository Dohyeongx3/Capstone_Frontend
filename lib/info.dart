import 'package:flutter/material.dart';
import 'escape.dart';
import 'group.dart';
import 'home.dart';
import 'info_datail.dart';
import 'setting.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _selectedIndex = 1;

  int _selectedFilterIndex = 0; // 필터 선택 상태 변수

  final List<String> filterTypes = ['기상', '지질', '해양·수재', '기타 특수'];

  final List<Map<String, dynamic>> disasterItems = [
    {'name': '강력 태풍', 'type': 0, },
    {'name': '도심 홍수', 'type': 0, },
    {'name': '집중 호우', 'type': 0, },
    {'name': '돌발 낙뢰', 'type': 0, },
    {'name': '대량 적설', 'type': 0, },
    {'name': '이상 폭염', 'type': 0, },
    {'name': '지진', 'type': 1, },
  ];

  int _selectedSocialFilterIndex = 0;

  final List<String> socialFilterTypes = ['물리적 재해', '기술적 재해', '환경·감염', '인적 요인'];

  final List<Map<String, dynamic>> socialDisasterItems = [
    {'name': '대형 화재', 'type': 0},
    {'name': '산업 폭발', 'type': 0},
    {'name': '건축물붕괴', 'type': 0},
    {'name': '댐붕괴', 'type': 0},
    {'name': '대규모 산불', 'type': 0},
    {'name': '도로터널사고', 'type': 0},
    {'name': '테러 공격', 'type': 1},
  ];

  final List<String> lifeSafetyItems = ['승강기 안전사고', '응급처치', '심폐소생술', '산행안전사고',];

  void _onItemTapped(int index) {
    int previousIndex = _selectedIndex;

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
            builder: (context) => Escape(selectedIndex: previousIndex),
          ),
        ).then((returnedIndex) {
          if (returnedIndex != null) {
            setState(() {
              _selectedIndex = returnedIndex;
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
      appBar: _buildCustomAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset('assets/logo.png', width: 24, height: 24),
          const SizedBox(width: 10),
          const Text("재난 정보", style: TextStyle(fontSize: 18, color: Colors.black)),
          const Spacer(),
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_outlined, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // [1] 자연 재난 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '자연 재난',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Natural disaster information',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),

          // 자연 재난 필터 바
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: List.generate(filterTypes.length, (index) {
                      final bool isSelected = _selectedFilterIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilterIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF0073FF) : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF0073FF),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            filterTypes[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(thickness: 1, height: 1, color: Colors.grey),
              ],
            ),
          ),

          // 자연 재난 테이블
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: _buildDisasterRows(),
            ),
          ),

          // [2] 사회 재난 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '사회 재난',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Social disaster information',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),

          // 사회 재난 필터 바
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: List.generate(socialFilterTypes.length, (index) {
                      final bool isSelected = _selectedSocialFilterIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSocialFilterIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF0073FF) : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF0073FF),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            socialFilterTypes[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const Divider(thickness: 1, height: 1, color: Colors.grey),
              ],
            ),
          ),

          // 사회 재난 테이블
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: _buildSocialDisasterRows(),
            ),
          ),

          // [3] 생활 안전 행동요령 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '생활 안전 행동요령',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Life Safety Behavior Guidelines',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),

          // 생활 안전 테이블
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              children: _buildLifeSafetyRows(),
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _buildDisasterRows() {
    final filteredItems = disasterItems.where((item) => _selectedFilterIndex == item['type']).toList();

    while (filteredItems.length < 6) {
      filteredItems.add({'name': '', 'image': '', 'type': _selectedFilterIndex});
    }

    List<TableRow> rows = [];
    for (int i = 0; i < 2; i++) {
      rows.add(
        TableRow(
          children: List.generate(3, (j) {
            final item = filteredItems[i * 3 + j];
            if (item['name'] == '') {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () {
                if (item['name'] == '강력 태풍') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TyphoonPage()),
                  );
                }
              },
              child: SizedBox(
                height: 80,
                child: Container( // 이 Container는 시각적 터치 확인을 위해 추가 가능
                  color: Colors.transparent, // 터치 인식되도록 transparent 처리
                  alignment: Alignment.center,
                  child: Text(
                    item['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
    return rows;
  }

  List<TableRow> _buildSocialDisasterRows() {
    final filteredItems = socialDisasterItems.where((item) => _selectedSocialFilterIndex == item['type']).toList();
    while (filteredItems.length < 6) {
      filteredItems.add({'name': '', 'type': _selectedSocialFilterIndex});
    }
    return List.generate(2, (i) {
      return TableRow(
        children: List.generate(3, (j) {
          final item = filteredItems[i * 3 + j];
          if (item['name'] == '') return const SizedBox.shrink();
          return SizedBox(
            height: 80,
            child: Center(
              child: Text(
                item['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }),
      );
    });
  }

  List<TableRow> _buildLifeSafetyRows() {
    List<TableRow> rows = [];
    for (int i = 0; i < 2; i++) {
      rows.add(
        TableRow(
          children: List.generate(2, (j) {
            final index = i * 2 + j;
            return SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  lifeSafetyItems[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
    return rows;
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: '재난정보'),
              BottomNavigationBarItem(icon: Opacity(opacity: 0, child: Icon(Icons.circle)), label: '대피경로'),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: '그룹'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            onTap: _onItemTapped,
          ),
          Positioned(
            top: -25,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () {
                _onItemTapped(2);
              },
              child: Container(
                width: 60,
                height: 60,
                color: Colors.transparent,
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