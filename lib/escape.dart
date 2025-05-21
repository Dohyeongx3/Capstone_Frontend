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
  final String locationName = '대구광역시 달서구 달구벌대로 1095 계명대학교 성서캠퍼스 공학1호관';   //실험 장소가 1호관이라 이렇게 적었습니다.
  final String coordinates = 'X: 35.854026 / Y: 128.491114 / Z: (1층)';                    // AP로 위치 특정하면 여기 값 갱신하면 돼요.
  int _currentSelectedIndex = 0;
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  bool _isExpanded = true;

  List<Map<String, dynamic>> _apList = [];

  @override
  void initState() {
    super.initState();
    _currentSelectedIndex = widget.selectedIndex;
    _scanAndSendWiFiData(); // Wi-Fi 정보 스캔 및 전송
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
      "SSID": ap.ssid,
      "BSSID": ap.bssid,
      "RSSI": ap.level,
    }).toList();

    print("스캔된 AP: $apList");

    // 신호 세기(RSSI) 기준으로 내림차순 정렬
    apList.sort((a, b) => ((b['RSSI'] ?? 0) as int).compareTo((a['RSSI'] ?? 0) as int));

    setState(() {
      _apList = apList;
    });

    try {
      final response = await http.post(
        Uri.parse(""), // 서버 주소
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"ap_data": apList}),
      );

      if (response.statusCode == 200) {
        print("서버 전송 성공");
      } else {
        print("서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("서버 전송 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
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
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  '실내지도 영역',
                  style: TextStyle(fontSize: 24, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _apList.length,
                    itemBuilder: (context, index) {
                      final ap = _apList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.wifi),
                          title: Text("SSID: ${ap['SSID']}"),
                          subtitle: Text("BSSID: ${ap['BSSID']}\nRSSI: ${ap['RSSI']}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.43,
            minChildSize: 0.1,
            maxChildSize: 0.43,
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
                                _isExpanded ? 0.45 : 0.1,
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