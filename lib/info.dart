import 'package:flutter/material.dart';
import 'escape.dart';
import 'group.dart';
import 'home.dart';
import 'info_datail.dart';
import 'notification.dart';
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
    {'name': '강력 태풍', 'type': 0, 'image':'assets/typhoon.png'},
    {'name': '도심 홍수', 'type': 0, 'image':'assets/flood.png'},
    {'name': '집중 호우', 'type': 0, 'image':'assets/rain.png'},
    {'name': '돌발 낙뢰', 'type': 0, 'image':'assets/lightning.png'},
    {'name': '대설', 'type': 0, 'image':'assets/heavysnow.png'},
    {'name': '이상 폭염', 'type': 0, 'image':'assets/heatwave.png'},
    {'name': '지진', 'type': 1, 'image':'assets/earthquake.png'},
    {'name': '지진해일', 'type': 1, 'image':'assets/earthquaketsunami.png'},
    {'name': '산사태', 'type': 1, 'image':'assets/landslide.png'},
    {'name': '해일', 'type': 2, 'image':'assets/tsunami.png'},
    {'name': '조수(조석)', 'type': 2, 'image':'assets/tide.png'},
    {'name': '침수', 'type': 2, 'image':'assets/flooding.png'},
    {'name': '황사', 'type': 3, 'image':'assets/yellowdust.png'},
    {'name': '적조', 'type': 3, 'image':'assets/redtide.png'},
    {'name': '우주전파재난', 'type': 3, 'image':'assets/space.png'},
    {'name': '자연우주물체추락', 'type': 3, 'image':'assets/fall.png'},
    {'name': '조류대발생(녹조)', 'type': 3, 'image':'assets/greentide.png'},
    {'name': '해빙기 재난예방', 'type': 3, 'image':'assets/thaw.png'},
  ];

  int _selectedSocialFilterIndex = 0;

  final List<String> socialFilterTypes = ['물리적 재해', '기술적 재해', '환경·감염', '인적 요인'];

  final List<Map<String, dynamic>> socialDisasterItems = [
    {'name': '대형 화재', 'type': 0, 'image':'assets/blaze.png'},
    {'name': '산업 폭발', 'type': 0, 'image':'assets/explosion.png'},
    {'name': '건축물붕괴', 'type': 0, 'image':'assets/collapse.png'},
    {'name': '댐붕괴', 'type': 0, 'image':'assets/dam.png'},
    {'name': '대규모 산불', 'type': 0, 'image':'assets/wildfire.png'},
    {'name': '도로터널사고', 'type': 0, 'image':'assets/tunnel.png'},
    {'name': '전기·가스 사고', 'type': 1, 'image':'assets/electricitygas.png'},
    {'name': '정전 및 전력부족', 'type': 1, 'image':'assets/blackout.png'},
    {'name': '철도, 지하철 사고', 'type': 1, 'image':'assets/railway.png'},
    {'name': '항공기사고', 'type': 1, 'image':'assets/plane.png'},
    {'name': '정보통신사고', 'type': 1, 'image':'assets/information.png'},
    {'name': 'GPS전파혼신재난', 'type': 1, 'image':'assets/GPS.png'},
    {'name': '감염병', 'type': 2, 'image':'assets/infection.png'},
    {'name': '보건의료재난', 'type': 2, 'image':'assets/medical.png'},
    {'name': '미세먼지', 'type': 2, 'image':'assets/finedust.png'},
    {'name': '대규모수질오염', 'type': 2, 'image':'assets/waterpollution.png'},
    {'name': '원유수급위기', 'type': 2, 'image':'assets/crude.png'},
    {'name': '해양오염사고', 'type': 2, 'image':'assets/marinepollution.png'},
    {'name': '지역축제장', 'type': 3, 'image':'assets/festival.png'},
    {'name': '보험자 안전', 'type': 3, 'image':'assets/insurance.png'},
    {'name': '대중운집 인파사고', 'type': 3, 'image':'assets/crowd.png'},
    {'name': '공동주택난', 'type': 3, 'image':'assets/apartment.png'},
    {'name': '공연장 안전', 'type': 3, 'image':'assets/theater.png'},
    {'name': '경기장 안전', 'type': 3, 'image':'assets/stadium.png'},
  ];

  final List<Map<String, dynamic>> lifeSafetyItems = [
    {'name': '승강기 안전사고', 'image': 'assets/elevator.png'},
    {'name': '응급처치', 'image': 'assets/firstaid.png'},
    {'name': '심폐소생술', 'image': 'assets/cpr.png'},
    {'name': '산행안전사고', 'image': 'assets/hiking.png'},
  ];

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
          Image.asset('assets/logo.png', width: 24, height: 24),
          const SizedBox(width: 10),
          const Text("재난 정보", style: TextStyle(fontSize: 18, color: Colors.black)),
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
    final filteredItems = disasterItems
        .where((item) => _selectedFilterIndex == item['type'])
        .toList();

    while (filteredItems.length < 6) {
      filteredItems.add({'image': '', 'name': '', 'type': _selectedFilterIndex});
    }

    List<TableRow> rows = [];
    for (int i = 0; i < 3; i++) {
      rows.add(
        TableRow(
          children: List.generate(2, (j) {
            final item = filteredItems[i * 2 + j];
            if (item['name'] == '') {
              return const SizedBox.shrink();
            }

            return Material(
              color: Colors.transparent, // 배경 투명
              child: InkWell(
                onTap: () {
                  if (item['name'] == '강력 태풍') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TyphoonPage()),
                    );
                  }
                  if (item['name'] == '도심 홍수') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FloodPage()),
                    );
                  }
                  if (item['name'] == '집중 호우') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RainfallPage()),
                    );
                  }
                  if (item['name'] == '돌발 낙뢰') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LightningPage()),
                    );
                  }
                  if (item['name'] == '대설') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HeavysnowPage()),
                    );
                  }
                  if (item['name'] == '이상 폭염') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HeatwavePage()),
                    );
                  }
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: item['image'] != ''
                            ? AssetImage(item['image']) as ImageProvider
                            : null,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
    final filteredItems = socialDisasterItems
        .where((item) => _selectedSocialFilterIndex == item['type'])
        .toList();

    while (filteredItems.length < 6) {
      filteredItems.add({'image': '', 'name': '', 'type': _selectedSocialFilterIndex});
    }

    return List.generate(3, (i) {
      return TableRow(
        children: List.generate(2, (j) {
          final item = filteredItems[i * 2 + j];
          if (item['name'] == '') return const SizedBox.shrink();

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (item['name'] == '대형 화재') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BlazePage()),
                  );
                }
                if (item['name'] == '산업 폭발') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExplosionPage()),
                  );
                }
                if (item['name'] == '건축물붕괴') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CollapsePage()),
                  );
                }
                if (item['name'] == '댐붕괴') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DamPage()),
                  );
                }
                if (item['name'] == '대규모 산불') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WildfirePage()),
                  );
                }
                if (item['name'] == '도로터널사고') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TunnelPage()),
                  );
                }
              },
              child: Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: item['image'] != ''
                          ? AssetImage(item['image']) as ImageProvider
                          : null,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  List<TableRow> _buildLifeSafetyRows() {
    List<TableRow> rows = [];

    // 2x2 그리드를 채우기 위해 리스트 길이가 4보다 적을 경우 빈 항목으로 채움
    while (lifeSafetyItems.length < 4) {
      lifeSafetyItems.add({'name': '', 'image': ''});
    }

    for (int i = 0; i < 2; i++) {
      rows.add(
        TableRow(
          children: List.generate(2, (j) {
            final item = lifeSafetyItems[i * 2 + j];

            if (item['name'] == '') {
              return const SizedBox.shrink(); // 빈 칸 처리
            }

            return SizedBox(
              height: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(item['image']),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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