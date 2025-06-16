import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'escape.dart';
import 'globals.dart';
import 'group.dart';
import 'home.dart';
import 'info.dart';
import 'setting.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int _selectedIndex = 4; // 설정 화면에서 진입했기 때문에 기본 인덱스는 4

  /*
  //TODO: 클라이언트에서 globalUid 보내면 서버에서 이름,생년월일,전화번호,위험상태 받아오기(setting.dart,editprofile.dart,group.dart 공통)
  final Map<String, dynamic> UserData = {
    'name': '사용자 이름',
    'year': 2000,
    'month': 11,
    'day': 11,
    'phone': '010-1234-5678',
    'status': 'SAFE',
  };
   */

  Map<String, dynamic>? UserData;

  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/profile'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({ 'globalUid': globalUid }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        UserData = data;
      });
    } else {
      print('사용자 정보 불러오기 실패');
    }
  }

  // TextEditingController 선언
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    final user = UserData;

    _nameController = TextEditingController(text: user?['name']);
    _yearController = TextEditingController(text: user?['year'].toString());
    _monthController = TextEditingController(text: user?['month'].toString());
    _dayController = TextEditingController(text: user?['day'].toString());
    _phoneController = TextEditingController(text: user?['phone']);
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _nameController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _phoneController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        '정보수정',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/default_profile.png'),
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '이름',
              hintText: '이름을 입력해주세요',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 40),
          const Text('생년월일', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '년',
                    hintText: 'YYYY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '월',
                    hintText: 'MM',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _dayController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '일',
                    hintText: 'DD',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: '전화번호',
              hintText: '010-0000-0000',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                // 생년월일 검사
                final yearRegex = RegExp(r'^(19|20)\d{2}$');
                final monthRegex = RegExp(r'^(0[1-9]|1[0-2])$');
                final dayRegex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])$');

                if (!yearRegex.hasMatch(_yearController.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('올바른 연도를 입력해주세요. 예: 1990')),
                  );
                  return;
                }

                if (!monthRegex.hasMatch(_monthController.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('올바른 월을 입력해주세요. 예: 01 ~ 12')),
                  );
                  return;
                }

                if (!dayRegex.hasMatch(_dayController.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('올바른 일을 입력해주세요. 예: 01 ~ 31')),
                  );
                  return;
                }

                // 전화번호 정규표현식 검사
                final phoneRegex = RegExp(r'^010-\d{4}-\d{4}$');
                if (!phoneRegex.hasMatch(_phoneController.text.trim())) {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678')),
                );
                return;
                }

                final name = _nameController.text.trim();
                final year = _yearController.text.trim();
                final month = _monthController.text.trim();
                final day = _dayController.text.trim();
                final phone = _phoneController.text.trim();
                final response = await http.post(
                  Uri.parse('https://capstoneserver-etkm.onrender.com/api/group/editProfile'),
                  headers: { 'Content-Type': 'application/json' },
                  body: jsonEncode({
                    'uId': globalUid,
                    'name': name,
                    'year': year,
                    'month': month,
                    'day': day,
                    'phone': phone
                  }),
                );

                if (response.statusCode == 200) {
                  fetchUserData();
                  print('사용자 프로필 수정 성공');
                } else {
                  print('사용자 프로필 수정 실패');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0073FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Text(
                "수정하기",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
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
    );
  }
}