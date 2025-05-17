import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'main.dart';
import 'escape.dart';
import 'group.dart';
import 'home.dart';
import 'info.dart';
import 'login.dart';
import 'setting.dart';

class Shelter extends StatefulWidget {
  const Shelter({Key? key}) : super(key: key);

  @override
  State<Shelter> createState() => _ShelterState();
}

class _ShelterState extends State<Shelter> {
  late NaverMapController _mapController;
  bool _isMapInitialized = false;
  int _selectedIndex = 0;

  String _currentAddress = '위치 확인 중...';
  String _thoroughfare = '';
  String _statusMessage = '';
  Color _statusColor = const Color(0xFF00BB6D);
  String _statusIcon = 'assets/shelter_safe.png';
  String _currentState = "SAFE";

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeNaverMap();
    _determinePosition();
  }

  Future<void> _initializeNaverMap() async {
    setState(() {
      _isMapInitialized = true;
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = '위치 서비스 꺼짐';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = '위치 권한 거부됨';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = '위치 권한 영구 거부됨';
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      _currentPosition = position;

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      String thoroughfare = '';
      String address = '주소를 찾을 수 없음';
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        thoroughfare = placemark.thoroughfare ?? '';
        address =
        '${placemark.country ?? ''}, ${placemark.administrativeArea ?? ''}, '
            '${placemark.subLocality ?? ''}, ${placemark.thoroughfare ?? ''}, '
            '${placemark.subThoroughfare ?? ''}';
      }

      setState(() {
        _currentAddress = address;
        _thoroughfare = thoroughfare;

        if (_currentState == "SAFE") {
          _statusColor = const Color(0xFF00BB6D);
          _statusIcon = 'assets/shelter_safe.png';
        } else if (_currentState == "DANGER") {
          _statusColor = const Color(0xFFFF6200);
          _statusIcon = 'assets/shelter_danger.png';
        }
      });
    } catch (e) {
      setState(() {
        _currentAddress = '위치 정보를 가져오지 못했습니다.';
      });
      print("위치 가져오기 오류: $e");
    }
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Group()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
        break;
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.gps_fixed),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _currentAddress,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.search),
              const SizedBox(width: 10),
              const Icon(Icons.notifications_outlined),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              color: _statusColor,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _currentState == "SAFE"
                          ? '현재 계신 $_thoroughfare, 안전해요!\n안심하고, 필요한 정보를 확인해보세요.'
                          : '현재 $_thoroughfare, 위험 지역입니다!\n주변 대피소를 확인하고 안전한 곳으로 이동하세요.',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(_statusIcon, height: 36),
                ],
              ),
            ),
            Expanded(
              child: _isMapInitialized
                  ? NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: _currentPosition != null
                        ? NLatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                        : const NLatLng(37.5665, 126.9780), // 서울시청 기본 위치
                    zoom: 16,
                  ),
                  locationButtonEnable: true,
                ),
                onMapReady: (controller) {
                  _mapController = controller;
                  print("네이버 맵 로딩됨!");
                },
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
                BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: '재난정보'),
                BottomNavigationBarItem(
                  icon: Opacity(opacity: 0, child: Icon(Icons.circle)),
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
            Positioned(
              top: -25,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: GestureDetector(
                onTap: () => _onItemTapped(2),
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
      ),
    );
  }
}