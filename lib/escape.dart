import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:http/http.dart' as http;

class Escape extends StatefulWidget {
  final int selectedIndex;

  const Escape({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<Escape> createState() => _EscapeState();
}

class _EscapeState extends State<Escape> {
  final String locationName = '대구광역시 달서구 달구벌대로 1095 계명대학교 성서캠퍼스 공학1호관';
  int _currentSelectedIndex = 0;
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  bool _isExpanded = true;
  List<Map<String, dynamic>> _escapePath = [];
  int _floor = 1;
  double? _x;
  double? _y;
  Timer? _timer;

  //List<Map<String, dynamic>> _apList = [];

  @override
  void initState() {
    super.initState();
    _currentSelectedIndex = widget.selectedIndex;
    _scanAndSendWiFiData(); // Wi-Fi 정보 스캔 및 전송
    _startPeriodicUpdate(); // WIFI 정보 시간 간격마다 반복 전송
  }

  void _startPeriodicUpdate() {  // 10초(10000ms)마다 서버에 요청 보내기
    _timer = Timer.periodic(const Duration(milliseconds: 10000), (timer) {
      _scanAndSendWiFiData();
    });
  }

  @override
  void dispose() {  // 탈출 경로 화면에서 나가면 서버 요청 멈추기
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _scanAndSendWiFiData() async {
    final canScan = await WiFiScan.instance.canStartScan();
    if (canScan != CanStartScan.yes) {
      print("WiFi 스캔 불가: $canScan");
      return;
    }

    await WiFiScan.instance.startScan();
    final List<WiFiAccessPoint> results = await WiFiScan.instance.getScannedResults();

    final apList = results.map((ap) => {
      "ssid": ap.ssid,
      "bssid": ap.bssid,
      "level": ap.level,
    }).toList();


    /*
    Map<String, Map<String, dynamic>> apMap = {};

    for (int i = 0; i < 3; i++) {
      await WiFiScan.instance.startScan();
      final results = await WiFiScan.instance.getScannedResults();

      for (var ap in results) {
        final bssid = ap.bssid;

        if (!apMap.containsKey(bssid)) {
          apMap[bssid] = {
            "ssid": ap.ssid,
            "levels": <int>[]
          };
        }
        apMap[bssid]!["levels"].add(ap.level);
      }

      await Future.delayed(const Duration(milliseconds: 500));
    }

    final apList = apMap.entries.map((entry) {
      final ssid = entry.value["ssid"];
      final levels = entry.value["levels"] as List<int>;
      final avg = levels.reduce((a, b) => a + b) / levels.length;

      return {
        "ssid": ssid,
        "bssid": entry.key,
        "level": avg.round(),
      };
    }).toList();
    */

    //print("스캔된 AP: $apList");

    // 신호 세기(RSSI) 기준으로 내림차순 정렬
    apList.sort((a, b) => ((b['level'] ?? 0) as int).compareTo((a['level'] ?? 0) as int));

    /*setState(() {
      _apList = apList;
    });*/

    try {
      final response = await http.post(
        Uri.parse("https://fastapi-app-592113319078.asia-northeast3.run.app/locate"), // 서버 주소
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"apList": apList}),
      );

      if (response.statusCode == 200) {  // 사용자의 현재 좌표
        final data = jsonDecode(response.body);
        setState(() {
          _escapePath = List<Map<String, dynamic>>.from(data['escape_path']);
          _floor = data['floor'];
          _x = data['estimated_location']['x']?.toDouble();
          _y = data['estimated_location']['y']?.toDouble();
        });
        apList.clear();
      } else {
        print("서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("서버 전송 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final coordinates = _x != null && _y != null
        ? 'X: ${_x!.toStringAsFixed(2)} / Y: ${_y!.toStringAsFixed(2)} / Z: ($_floor층)'
        : '좌표 없음';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, _currentSelectedIndex);
          },
        ),
        title: const Text(
          '실내 대피 경로 안내',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 72 / 23,  //도면 비율 맞추기
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/floor_$_floor.png',  // 각 층에 해당하는 png 가져오기
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PathPainter(_escapePath, _x, _y, _floor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.41,
            minChildSize: 0.15,
            maxChildSize: 0.41,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(_isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });

                              _sheetController.animateTo(
                                _isExpanded ? 0.41 : 0.15,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ],
                      ),
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
                      Row(children: const [
                        Icon(Icons.location_on, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('현재 위치', style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 4),
                        child: Text(locationName),
                      ),
                      const SizedBox(height: 12),
                      Row(children: const [
                        Icon(Icons.map, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('현재 좌표', style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
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

class PathPainter extends CustomPainter {  // 경로 그리기 클래스
  final List<Map<String, dynamic>> path;
  final double? userX;
  final double? userY;
  final int currentFloor;

  PathPainter(this.path, this.userX, this.userY, this.currentFloor);

  int? extractFloor(String nodeName) {  //현재 사용자 위치 정보 층과 같은 노드 필터링
    if (nodeName.startsWith("B1")) return -1; //지하 노드 필터링 추가

    final fMatch = RegExp(r'^(\d)F_').firstMatch(nodeName);
    if (fMatch != null) return int.parse(fMatch.group(1)!);

    final hMatch = RegExp(r'^(\d{2})H_').firstMatch(nodeName);
    if (hMatch != null) return int.parse(hMatch.group(1)!) - 10;

    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bool isBasement = currentFloor == -1;

    // 지하일 땐 x: 16~72 → 56칸, y: 0~19 → 19칸
    final double scaleX = isBasement ? size.width / (72.0 - 16.0) : size.width / 72.0;
    final double scaleY = isBasement ? size.height / 19.0 : size.height / 23.0;

    double toFlutterX(num x) => isBasement ? (x - 16.0) * scaleX: x * scaleX;
    double toFlutterY(num y) => size.height - (y * scaleY);

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final filtered = path.where((node) {
      final name = node['node'].toString();
      final floorNum = extractFloor(name);
      return floorNum == currentFloor;
    }).toList();

    for (int i = 0; i < filtered.length - 1; i++) {  // 탈출 경로 노드 좌표 찍기
      final x1 = toFlutterX(filtered[i]['x']);
      final y1 = toFlutterY(filtered[i]['y']);
      final x2 = toFlutterX(filtered[i + 1]['x']);
      final y2 = toFlutterY(filtered[i + 1]['y']);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);  // 경로 그리기
    }

    if (userX != null && userY != null) {
      final userPaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill;
      final ux = userX! * scaleX;
      final uy = toFlutterY(userY!);
      canvas.drawCircle(Offset(ux, uy), 4.0, userPaint);  //사용자 위치 표시
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


/*Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: _apList.length,
    itemBuilder: (context, index) {
      final ap = _apList[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: const Icon(Icons.wifi),
          title: Text("SSID: ${ap['ssid']}"),
          subtitle: Text("BSSID: ${ap['bssid']}\nRSSI: ${ap['level']}"),
        ),
      );
    },
  ),
),*/