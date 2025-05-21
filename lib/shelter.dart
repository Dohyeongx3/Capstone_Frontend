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

  final List<Map<String, dynamic>> shelterList = [
    {
      'name': '중앙 한파쉼터',
      'address': '서울특별시 중구 세종대로 110',
      'lat': 37.5665,
      'lng': 126.9780,
      'type': 1,
    },
    {
      'name': '도림 무더위쉼터',
      'address': '서울특별시 영등포구 도림로 123',
      'lat': 37.5131,
      'lng': 126.9115,
      'type': 2,
    },
    {
      'name': '서울지진대피장소',
      'address': '서울특별시 종로구 종로 1',
      'lat': 37.5704,
      'lng': 126.9827,
      'type': 3,
    },
    {
      'name': '해안 지진해일대피소',
      'address': '부산광역시 해운대구 달맞이길 123',
      'lat': 35.1587,
      'lng': 129.1604,
      'type': 4,
    },
    {
      'name': '달서구 한파쉼터',
      'address': '대구광역시 달서구',
      'lat': 37.5665,
      'lng': 126.9780,
      'type': 1,
    },
  ];

  final List<String> shelterTypes = [
    '전체',
    '한파쉼터',
    '무더위쉼터',
    '지진옥외대피소',
    '지진해일대피소',
  ];

  int _selectedShelterIndex = 0; // 클래스 내에 추가 필요

  String getShelterTypeImage(int type) {
    switch (type) {
      case 1:
        return 'assets/cold.png';
      case 2:
        return 'assets/hot.png';
      case 3:
        return 'assets/earthquake_shelter.png';
      case 4:
        return 'assets/tsunami.png';
      default:
        return 'assets/default.png';
    }
  }

  String getShelterTypeLabel(int type) {
    switch (type) {
      case 1:
        return '시설구분: 한파쉼터';
      case 2:
        return '시설구분: 무더위쉼터';
      case 3:
        return '시설구분: 지진옥외대피소';
      case 4:
        return '시설구분: 지진해일대피소';
      default:
        return '시설구분: 알 수 없음';
    }
  }


  @override
  void initState() {
    super.initState();
    _determinePosition().then((_) {
      setState(() {
        _isMapInitialized = true;
      });
    });
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
                  initialCameraPosition: const NCameraPosition(
                    target: NLatLng(37.5665, 126.9780), // 임시 기본 위치
                    zoom: 16,
                  ),
                  locationButtonEnable: true,
                ),
                onMapReady: (controller) async {
                  _mapController = controller;
                  print("네이버 맵 로딩됨!");

                  if (_currentPosition != null) {
                    final currentLatLng = NLatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    );

                    await _mapController!.updateCamera(
                      NCameraUpdate.scrollAndZoomTo(
                        target: currentLatLng,
                        zoom: 16,
                      ),
                    );
                  } else {
                    print("현재 위치 정보가 없습니다.");
                  }
                },
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '대피소 경로 안내',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '현재 위치에서 가까운 순으로 안내합니다.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: List.generate(shelterTypes.length, (index) {
                        final bool isSelected = _selectedShelterIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedShelterIndex = index;
                              // 필터 로직은 추후 구현
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
                              shelterTypes[index],
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
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: shelterList.length,
                itemBuilder: (context, index) {
                  final shelter = shelterList[index];
                  final type = shelter['type'];

                  // 필터링: '전체'가 아니면 선택된 shelterType과 다르면 스킵
                  if (_selectedShelterIndex != 0 && _selectedShelterIndex != type) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(getShelterTypeImage(type)),
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shelter['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                shelter['address'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getShelterTypeLabel(type),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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