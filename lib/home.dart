import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'escape.dart';
import 'group.dart';
import 'info.dart';
import 'login.dart';
import 'setting.dart';
import 'shelter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String _currentLocation = '위치 확인 중...';
  String _currentAddress = '주소 확인 중...';

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
      MaterialPageRoute(builder: (context) => const Login()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    const String currentState = "SAFE";

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
        statusText = "상태 변동 가능성";
        statusLabel = "CHECKING";
        break;
      default:
        backgroundColor = Colors.grey;
        imageAsset = '';
        statusText = "-";
        statusLabel = "-";
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/logo.png', width: 24, height: 24),
              const SizedBox(width: 10),
              const Text("홈 메인", style: TextStyle(fontSize: 18)),
              const Spacer(),
              const Icon(Icons.search),
              const SizedBox(width: 10),
              const Icon(Icons.notifications_outlined),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('현재 위치: $_currentLocation', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
                        const Text('-', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const Text('-', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('대피소 위치 >', style: TextStyle(color: Colors.white, fontSize: 14)),
                          const Text('Shelter Location', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00BB6D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('-', style: TextStyle(color: Colors.white, fontSize: 16)),
                                Image.asset('assets/shelter.png', height: 30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Route Box
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(2);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('경로 안내 >', style: TextStyle(color: Colors.white, fontSize: 14)),
                          const Text('Route Guidance', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('-', style: TextStyle(color: Colors.white, fontSize: 16)),
                                Image.asset('assets/route.png', height: 30),
                              ],
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