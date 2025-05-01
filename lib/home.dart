import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'escape.dart';
import 'group.dart';
import 'info.dart';
import 'login.dart';
import 'setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late NaverMapController _mapController;
  bool _isMapInitialized = false;
  int _selectedIndex = 0;

  // 계명대 공학1호관 위치 (현재 위치로 간주)
  final double keimyungLat = 35.854026;
  final double keimyungLng = 128.491114;

  @override
  void initState() {
    super.initState();
    _initializeNaverMap();
  }

  Future<void> _initializeNaverMap() async {
    await NaverMapSdk.instance.initialize(
      clientId: '8j69e3z4nm',
      onAuthFailed: (ex) {
        print("네이버맵 인증오류: $ex");
      },
    );

    setState(() {
      _isMapInitialized = true;
    });
  }

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

  // 뒤로가기 버튼 눌렀을 때 로그인 화면으로 돌아가는 로직
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()), // 로그인 화면으로 이동
    );
    return false; // true 반환하지 않으면 앱이 종료되지 않음
  }

  @override
  Widget build(BuildContext context) {
    final isSafe = true;
    final district = '계명대학교 공학1호관';

    return WillPopScope(
      onWillPop: _onWillPop,  // 뒤로가기 버튼을 눌렀을 때 로그인 화면으로 이동
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.gps_fixed),
              const SizedBox(width: 10),
              Text(district),
              const Spacer(),
              const Icon(Icons.search),
              const SizedBox(width: 10),
              const Icon(Icons.notifications_outlined),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              color: isSafe ? const Color(0xFF00BB6D) : Colors.redAccent,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isSafe
                          ? "현재 계신 $district, 안전해요! 안심하고, 필요한 정보를 확인해보세요."
                          : "$district은 위험 지역입니다! 주변 대피소를 확인하고 안전한 곳으로 이동하세요.",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  isSafe
                      ? const Icon(Icons.eco, color: Colors.white)
                      : const Icon(Icons.warning, color: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: _isMapInitialized
                  ? NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(keimyungLat, keimyungLng),
                    zoom: 16,
                  ),
                  locationButtonEnable: true,
                ),
                onMapReady: (controller) {
                  _mapController = controller;
                  print("네이버맵 준비 완료");
                },
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: '재난정보'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: '대피경로'),
            BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: '그룹'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}