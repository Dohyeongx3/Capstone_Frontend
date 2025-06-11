import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'escape.dart';
import 'group.dart';
import 'info.dart';
import 'login.dart';
import 'setting.dart';
import 'shelter.dart';
import 'notification.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String _currentLocation = '위치 확인 중...';
  String _currentAddress = '주소 확인 중...';

  // TODO:DB에서 현재 로그인된 사용자 위험 상태 연결
  final List<Map<String, dynamic>> userStatusList = [
    {
      'status': 'SAFE', // 혹은 'DANGER', 'CHECKING'
    }
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = '위치 서비스 꺼짐';
        _currentAddress = '주소를 찾을 수 없음';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = '위치 권한 거부됨';
          _currentAddress = '주소를 찾을 수 없음';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = '위치 권한 영구 거부됨';
        _currentAddress = '주소를 찾을 수 없음';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String address = '주소를 찾을 수 없음';
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      address = '${placemark.country ?? ''}, ${placemark.administrativeArea ?? ''}, '
          '${placemark.subLocality ?? ''}, ${placemark.thoroughfare ?? ''}, '
          '${placemark.subThoroughfare ?? ''}';
    }

    setState(() {
      _currentLocation = '위도: ${position.latitude.toStringAsFixed(4)}, 경도: ${position.longitude.toStringAsFixed(4)}';
      _currentAddress = address.isNotEmpty ? address : '주소를 찾을 수 없음';
    });
  }

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentState = userStatusList.first['status'];

    Color backgroundColor;
    String imageAsset;
    String statusText;
    String statusLabel;

    switch (currentState) {
      case "SAFE":
        backgroundColor = const Color(0xFF00BB6D);
        imageAsset = 'assets/safe.png';
        statusText = "안전";
        statusLabel = "SAFE";
        break;
      case "DANGER":
        backgroundColor = const Color(0xFFFF6200);
        imageAsset = 'assets/danger.png';
        statusText = "위험";
        statusLabel = "DANGER";
        break;
      case "CHECKING":
        backgroundColor = const Color(0xFF007EFF);
        imageAsset = 'assets/checking.png';
        statusText = "상태 체크중";
        statusLabel = "CHECKING";
        break;
      default:
        backgroundColor = Colors.grey;
        imageAsset = '';
        statusText = "-";
        statusLabel = "-";
    }

    return PopScope(
      canPop: false, // 직접 제어하므로 false
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (!didPop) {
            final shouldExit = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                '[SAM 앱 종료]',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Image.asset(
                                'assets/icon_popup.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 16),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: '앱을 ',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: '종료',
                                      style: TextStyle(
                                        color: Color(0xFF0073FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '하시겠습니까?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(false),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF949494),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: const Text(
                                      '취소',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(true),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0073FF),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: const Text(
                                      '종료',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // 오른쪽 상단 X 버튼
                    Positioned(
                      right: 8,
                      top: 8,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(false),
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

            if (shouldExit == true) {
              SystemNavigator.pop(); // 앱 종료
            }
          }
        },
        child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // AppBar 뒤로가기 버튼 클릭 시 Login으로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
          title: Row(
            children: [
              Image.asset('assets/logo.png', width: 24, height: 24),
              const SizedBox(width: 10),
              const Text("홈 메인", style: TextStyle(fontSize: 18)),
              const Spacer(),
              const SizedBox(width: 10),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재 위치: $_currentLocation', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              //TODO:여기 currentAddress 값을 그룹에 현재위치로써 서버에서 주고 받아야 해요
              Text('주소: $_currentAddress', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('State | 상태', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text(statusLabel, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Center(
                      child: Image.asset(imageAsset, height: 200, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white54, thickness: 1),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('현재상태', style: TextStyle(color: Colors.white)),
                        Text('대피소', style: TextStyle(color: Colors.white)),
                        Text('대피경로', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(statusText, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const Text('위치 파악', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const Text('경로 파악', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(thickness: 2, color: Colors.grey),
              const SizedBox(height: 8),
              const Text('바로 가기', style: TextStyle(fontSize: 12, color: Colors.black)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Shelter Box
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Shelter()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // 상단 (4.5 비율)
                          Expanded(
                            flex: 45,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '대피소 위치 >',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Shelter Location',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 하단 (5.5 비율)
                          Expanded(
                            flex: 55,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF00BB6D),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Stack(
                                children: [
                                  const Positioned(
                                    left: 0,
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      '가까운 대피소를 확인하고\n전체 목록에서 위치를 찾아보세요.',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset('assets/shelter.png', height: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Route Box
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(2); // 원하는 위젯으로 이동
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // 상단 (4.5 비율)
                          Expanded(
                            flex: 45,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '경로 안내 >',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Route Guidance',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 하단 (5.5 비율)
                          Expanded(
                            flex: 55,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6200),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Stack(
                                children: [
                                  const Positioned(
                                    left: 0,
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      '지금 위치에서 경로를 안내받고\n빠르게 출구로 이동해보세요.',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset('assets/route.png', height: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: Stack(
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
                behavior: HitTestBehavior.translucent,
                onTap: () => _onItemTapped(2),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/escapebutton.png', fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}