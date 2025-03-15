import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class Idfind extends StatefulWidget {
  const Idfind({super.key});

  @override
  State<Idfind> createState() => _IdfindState();
}

class _IdfindState extends State<Idfind> {
  bool _isIdFindSelected = true; // 아이디 찾기 선택 여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '아이디 찾기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildSelectionBox("아이디 찾기", true),
                _buildSelectionBox("비밀번호 찾기", false),
              ],
            ),
            SizedBox(height: 50),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: '휴대전화번호',
                hintText: "'-' 제외하고 입력해주세요",
                border: OutlineInputBorder(),
                suffixIcon: TextButton(
                  onPressed: () {
                    // 인증번호 전송 로직
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 40),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text("인증번호 전송", style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '인증번호',
                hintText: '인증번호를 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 아이디 찾기 로직 추가
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Text(
                  "아이디 찾기",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionBox(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isIdFindSelected = isSelected;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
            color: isSelected ? Colors.white : Colors.grey[300],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
