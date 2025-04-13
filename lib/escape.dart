import 'package:flutter/material.dart';

class Escape extends StatefulWidget {
  final int selectedIndex;  // 부모의 selectedIndex를 전달받음

  const Escape({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<Escape> createState() => _EscapeState();
}

class _EscapeState extends State<Escape> {
  final String locationName = '대구광역시 달서구 달구벌대로 1095 계명대학교 성서캠퍼스 공학1호관';
  final String coordinates = 'X: 35.854026 / Y: 128.491114 / Z: (1층)';

  // Escape 화면에서 선택된 인덱스를 변경할 수 있는 변수
  int _currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // 부모 화면에서 받은 selectedIndex를 초기값으로 설정
    _currentSelectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            // 부모 화면에 변경된 selectedIndex 값을 전달
            Navigator.pop(context, _currentSelectedIndex);
          },
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "실내 대피 경로 안내",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // 지도 영역 (아직 미완성)
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                '실내지도 영역',
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
            ),
          ),
          // 온보딩 시트
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.warning, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            '규모 4.2 지진 발생',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.black54),
                          SizedBox(width: 8),
                          Text(
                            '현재 위치',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 4),
                        child: Text(locationName),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Icon(Icons.map, color: Colors.black54),
                          SizedBox(width: 8),
                          Text(
                            '현재 좌표',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 4),
                        child: Text(coordinates),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}