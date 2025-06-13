import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'createdAt': '2025-06-13 14:25',
      'message': '규모 4.2 지진이 감지되었습니다. 즉시 대피하세요.',
      'region': '대구광역시',
      'alertLevel': '주의보',
      'disasterType': '지진',
    },
  ];

  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = List.generate(notifications.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '알림',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/not_notification.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              '알림이 없습니다.',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF0073FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isExpanded = _isExpanded[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF0073FF), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 아이콘, 제목, 토글
                Row(
                  children: [
                    Image.asset(
                      isExpanded
                          ? 'assets/notification_detail.png'
                          : 'assets/notification.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '재난 알림 / ${notification['disasterType']} ${notification['alertLevel']}',
                        style: const TextStyle(
                          color: Color(0xFF0073FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded[index] = !_isExpanded[index];
                        });
                      },
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (!isExpanded)
                  Text(
                    '${notification['createdAt']} • ${notification['region']}',
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                if (isExpanded) ...[
                  const Divider(color: Color(0xFF0073FF)),

                  const SizedBox(height: 8),
                  _buildInfoRow('위치', notification['region']),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                      '종류',
                      '${notification['disasterType']} ${notification['alertLevel']}'),
                  const SizedBox(height: 8),
                  _buildInfoRow('시각', notification['createdAt']),
                  const SizedBox(height: 8),
                  _buildInfoRow('내용', notification['message']),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title | ',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}