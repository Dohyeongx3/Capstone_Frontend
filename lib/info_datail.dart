import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TyphoonPage extends StatefulWidget {
  const TyphoonPage({super.key});

  @override
  State<TyphoonPage> createState() => _TyphoonPageState();
}

class _TyphoonPageState extends State<TyphoonPage> {
  final List<String> tabFilters = ['재난 개요', '위험 요소', '행동요령', '관련 자료'];
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('재난정보'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 전체 상단 정보 및 필터바 포함 영역
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '행정안전부 국민행동요령 안내',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '태풍 (Typhoon)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0073FF),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: Colors.grey),
                      onPressed: () {
                        // TODO: TTS 연결
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/typhoon_detail.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('발생 가능 시기', '6월~10월'),
                const SizedBox(height: 8),
                _buildInfoRow('경보 기준', '최대풍속 25m/s 이상'),
                const SizedBox(height: 8),
                _buildInfoRow('피해 위험', '침수, 정전, 인명 피해'),
                const SizedBox(height: 8),
                _buildInfoRow('관련 기관', '기상청, 안전신문고'),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '*업데이트: 2025.05.27',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),
              ],
            ),
          ),

          // 필터바
          Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(tabFilters.length, (index) {
                    final bool isSelected = _selectedTabIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = index;
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
                          tabFilters[index],
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
            ),
          ),

          // 필터별 내용 영역 (Expanded 로 화면 채우기)
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, MediaQuery.of(context).padding.bottom + 16.0,),
              child: _selectedTabIndex == 0
                  ? _buildDisasterOverview()
                  : _selectedTabIndex == 1
                  ? _buildRiskFactors()
                  : _selectedTabIndex == 2
                  ? _buildBehaviorTips()
                  : _selectedTabIndex == 3
                  ? _buildRelatedMaterals()
                  : Center(
                child: Text(
                  '${tabFilters[_selectedTabIndex]} 내용 준비중',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        const Text('|', style: TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // 재난 개요 내용 위젯
  Widget _buildDisasterOverview() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 + 부제
            const Text(
              '재난 개요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Disaster Overview',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 12),

            // 얇은 회색 경계선
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),

            const SizedBox(height: 12),

            // 정의 제목
            const Text(
              '정의',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 정의 리스트 (unordered list)
            _buildUnorderedList([
              '태풍은 북서태평양에서 발생하는 중심 최대풍속 17m/s 이상의 열대 저기압입니다.',
              '강한 바람과 많은 비를 동반하며, 주로 여름~가을 사이에 발생합니다.',
            ]),

            const SizedBox(height: 16),

            // 발생 시기 및 특징 제목
            const Text(
              '발생 시기 및 특징',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 발생 시기 및 특징 리스트
            _buildUnorderedList([
              '발생 시기: 6월 ~ 10월',
              '이동 경로: 북서진 → 한반도 접근 가능성',
              '영향 지역: 해안가, 저지대, 지하차도 등',
            ]),

            const SizedBox(height: 16),

            // 태풍 분류 기준 제목
            const Text(
              '태풍 분류 기준',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 태풍 분류 기준 리스트
            _buildUnorderedList([
              '강도: 약(17m/s), 중(25m/s), 강(33m/s), 매우 강(44m/s)',
              '크기: 소형, 중형, 대형 (반경 기준)',
            ]),
          ],
        ),
      ),
    );
  }

  // 위험 요소 내용 위젯
  Widget _buildRiskFactors() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 + 부제
            const Text(
              '위험 요소',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Risk Factors',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 12),

            // 얇은 회색 경계선
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),

            const SizedBox(height: 12),

            const Text(
              '하천·도로 침수',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '폭우로 인해 도로 및 저지대 침수',
              '차량 고립 위험',
            ]),

            const SizedBox(height: 16),

            const Text(
              '유리창 파손',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '강풍으로 인해 유리창 파손 및 낙하물 위험',
            ]),

            const SizedBox(height: 16),

            const Text(
              '정전 및 감전 사고',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 태풍 분류 기준 리스트
            _buildUnorderedList([
              '전신주 파손 및 침수로 인한 전기 사고',
            ]),

            const SizedBox(height: 16),

            const Text(
              '건축물 붕괴',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '노후 주택이나 임시 구조물 붕괴 가능',
            ]),

            const SizedBox(height: 16),

            const Text(
              '산사태 및 급경사 붕괴',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '지반 약화로 인한 붕괴 위험, 특히 산지 거주자 유의',
            ]),
          ],
        ),
      ),
    );
  }

  // 행동 요령 내용 위젯
  Widget _buildBehaviorTips() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 + 부제
            const Text(
              '행동요령',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Behavior Tips',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 12),

            // 얇은 회색 경계선
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),

            const SizedBox(height: 12),

            const Text(
              '태풍 발생 전',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '창문, 간판, 지붕 등 고정 여부 확인',
              '하천·산 근처 주거자는 사전 대피 검토',
              '비상식량, 손전등, 라디오, 예비 배터리 준비',
            ]),

            const SizedBox(height: 16),

            const Text(
              '태풍 진행 중',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '외출 자제, 실내에서 대기',
              '뉴스·재난 문자로 최신 정보 확인',
              '침수된 곳, 엘리베이터, 전신주 접근 금지',
            ]),

            const SizedBox(height: 16),

            const Text(
              '태풍 지나간 후',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            _buildUnorderedList([
              '쓰러진 전신주·건물 잔해 접근 금지',
              '침수 지역 도보·운전 피하기',
              '피해 발생 시 즉시 신고 (119, 지자체 등)',
            ]),
          ],
        ),
      ),
    );
  }

  // 관련 자료 내용 위젯
  Widget _buildRelatedMaterals() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 + 부제
            const Text(
              '관련 자료',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Related Materials',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 12),

            // 얇은 회색 경계선
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),

            const SizedBox(height: 12),

            const Text(
              '행정안전부 카드뉴스',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 이미지 넣기
            Center(
              child: Image.asset(
                'assets/typhoon_card.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              '외부링크',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0073FF),
              ),
            ),
            const SizedBox(height: 8),

            // 국민재난안전포털 바로가기 버튼
            Center(
              child: GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(
                    'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent02.html?menuSeq=126',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('링크를 열 수 없습니다.')),
                    );
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0073FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '국민재난안전포털 바로가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
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

  // 회색 글씨, unordered list 스타일 아이템 빌더
  Widget _buildUnorderedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}