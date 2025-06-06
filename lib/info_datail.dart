import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'info_detail_template.dart';

class TyphoonPage extends StatefulWidget {
  const TyphoonPage({super.key});

  @override
  State<TyphoonPage> createState() => _TyphoonPageState();
}

class _TyphoonPageState extends State<TyphoonPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleTts() async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('ko-KR');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(
        '태풍 행동요령. 태풍 발생 전. 창문, 간판, 지붕 등 고정 여부 확인. 하천, 산 근처 주거자는 사전 대피 검토. 비상식량, 손전등, 라디오, 배터리를 준비하세요. '
            '태풍 진행 중. 외출을 자제하고 실내에 머무르세요. 뉴스와 재난 문자로 정보를 확인하세요. 침수된 곳과 전신주 접근을 피하세요. '
            '태풍 지나간 후. 쓰러진 전신주나 잔해에 접근하지 마세요. 침수 지역을 피해 이동하세요. 피해 발생 시 즉시 119나 지자체에 신고하세요.',
      );
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisasterPageTemplate(
      appBarTitle: '재난정보',
      headerTitle: '행정안전부 국민행동요령 안내',
      disasterName: '태풍 (Typhoon)',
      mainImageAsset: 'assets/typhoon_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '6월~10월'),
        InfoRowData(title: '경보 기준', content: '최대풍속 25m/s 이상'),
        InfoRowData(title: '피해 위험', content: '침수, 정전, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 안전신문고'),
      ],
      updateDate: '2025.05.27',
      tabFilters: ['재난 개요', '위험 요소', '행동요령', '관련 자료'],
      tabContents: [
        // 1. 재난 개요
        DisasterOverviewSection(
          title: '재난 개요',
          subtitle: 'Disaster Overview',
          blocks: [
            SectionBlock(
              title: '정의',
              items: [
                '태풍은 북서태평양에서 발생하는 중심 최대풍속 17m/s 이상의 열대 저기압입니다.',
                '강한 바람과 많은 비를 동반하며, 주로 여름~가을 사이에 발생합니다.',
              ],
            ),
            SectionBlock(
              title: '발생 시기 및 특징',
              items: [
                '발생 시기: 6월 ~ 10월',
                '이동 경로: 북서진 → 한반도 접근 가능성',
                '영향 지역: 해안가, 저지대, 지하차도 등',
              ],
            ),
            SectionBlock(
              title: '태풍 분류 기준',
              items: [
                '강도: 약(17m/s), 중(25m/s), 강(33m/s), 매우 강(44m/s)',
                '크기: 소형, 중형, 대형 (반경 기준)',
              ],
            ),
          ],
        ),
        // 2. 위험 요소
        DisasterOverviewSection(
          title: '위험 요소',
          subtitle: 'Risk Factors',
          blocks: [
            SectionBlock(
              title: '하천·도로 침수',
              items: [
                '폭우로 인해 도로 및 저지대 침수',
                '차량 고립 위험',
              ],
            ),
            SectionBlock(
              title: '유리창 파손',
              items: [
                '강풍으로 인해 유리창 파손 및 낙하물 위험',
              ],
            ),
            SectionBlock(
              title: '정전 및 감전 사고',
              items: [
                '전신주 파손 및 침수로 인한 전기 사고',
              ],
            ),
            SectionBlock(
              title: '건축물 붕괴',
              items: [
                '노후 주택이나 임시 구조물 붕괴 가능',
              ],
            ),
            SectionBlock(
              title: '산사태 및 급경사 붕괴',
              items: [
                '지반 약화로 인한 붕괴 위험, 특히 산지 거주자 유의',
              ],
            ),
          ],
        ),
        // 3. 행동요령
        BehaviorTipsSection(
          title: '행동요령',
          subtitle: 'Behavior Tips',
          blocks: [
            SectionBlock(
              title: '태풍 발생 전',
              items: [
                '창문, 간판, 지붕 등 고정 여부 확인',
                '하천·산 근처 주거자는 사전 대피 검토',
                '비상식량, 손전등, 라디오, 예비 배터리 준비',
              ],
            ),
            SectionBlock(
              title: '태풍 진행 중',
              items: [
                '외출 자제, 실내에서 대기',
                '뉴스·재난 문자로 최신 정보 확인',
                '침수된 곳, 엘리베이터, 전신주 접근 금지',
              ],
            ),
            SectionBlock(
              title: '태풍 지나간 후',
              items: [
                '쓰러진 전신주·건물 잔해 접근 금지',
                '침수 지역 도보·운전 피하기',
                '피해 발생 시 즉시 신고 (119, 지자체 등)',
              ],
            ),
          ],
          onTtsPressed: _toggleTts,
          isSpeaking: isSpeaking,
        ),
        // 4. 관련 자료
        RelatedMaterialsSection(
          title: '관련 자료',
          subtitle: 'Related Materials',
          cardImageAsset: 'assets/typhoon_card.png',
          linkTitle: '국민재난안전포털 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent02.html?menuSeq=126',
        ),
      ],
    );
  }
}

class FloodPage extends StatefulWidget {
  const FloodPage({super.key});

  @override
  State<FloodPage> createState() => _FloodPageState();
}

class _FloodPageState extends State<FloodPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleTts() async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('ko-KR');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(
          '홍수 행동요령. '
              '홍수 발생 전. TV와 라디오를 통해 기상 정보를 확인하세요. 집 주변의 배수구와 하수구를 정리하고, 차량은 고지대로 옮기세요. '
              '가전제품과 귀중품은 높은 곳에 보관하세요. '
              '홍수 진행 중. 침수된 도로나 지하차도에는 진입하지 마세요. 맨홀이나 전봇대, 전기시설 근처에는 접근하지 마세요. '
              '위험이 발생하면 119나 112에 신고하고, 어린이는 절대 밖에 나가지 않도록 지도하세요. '
              '홍수 지나간 후. 실내외 청소 전에는 반드시 전기를 차단했는지 확인하세요. 오염된 음식물은 반드시 폐기하고, 수돗물이 오염되었을 경우 반드시 끓여 마시세요. '
              '손을 자주 씻고 감염병을 예방하세요.'
      );
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisasterPageTemplate(
      appBarTitle: '재난정보',
      headerTitle: '행정안전부 국민행동요령 안내',
      disasterName: '도심 홍수 (Urban Flooding)',
      mainImageAsset: 'assets/flood_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '6월~9월'),
        InfoRowData(title: '경보 기준', content: '하천 수위 상승, 하천 범람 우려'),
        InfoRowData(title: '피해 위험', content: '침수, 감전, 도로 붕괴, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 행정안전부, 소방청'),
      ],
      updateDate: '2025.05.27',
      tabFilters: ['재난 개요', '위험 요소', '행동요령', '관련 자료'],
      tabContents: [
        // 1. 재난 개요
        DisasterOverviewSection(
          title: '재난 개요',
          subtitle: 'Disaster Overview',
          blocks: [
            SectionBlock(
              title: '정의',
              items: [
                '홍수는 폭우, 제방 붕괴, 하천 범람 등으로 인해 물이 넘쳐나는 현상입니다.',
                '주택·도로 침수, 농경지 피해, 인명 사고 등을 유발합니다.',
              ],
            ),
            SectionBlock(
              title: '발생 원인',
              items: [
                '발생 시기: 6월 ~ 10월',
                '폭우, 하천 범람, 제방 붕괴 등',
                '영향 지역: 저지대, 하천 인근, 지하차도 등',
              ],
            ),
            SectionBlock(
              title: '홍수 분류 기준',
              items: [
                '하천 수위 상승, 범람 위험',
                '도심 침수, 도로·지하차도 침수',
              ],
            ),
          ],
        ),
        // 2. 위험 요소
        RiskFactorsSection(
          title: '위험 요소',
          subtitle: 'Risk Factors',
          blocks: [
            SectionBlock(
              title: '지하차도 침수',
              items: [
                '짧은 시간 내 수위 상승, 차량 고립 및 익사 위험',
              ],
            ),
            SectionBlock(
              title: '주택·상가 침수',
              items: [
                '실내 정전, 감전, 가전제품 파손 가능',
              ],
            ),
            SectionBlock(
              title: '정전 및 감전 사고',
              items: [
                '침수된 전기시설 접근 시 위험',
              ],
            ),
            SectionBlock(
              title: '도로 붕괴 / 침하',
              items: [
                '보행 중 하수구 및 맨홀 추락 위험',
              ],
            ),
            SectionBlock(
              title: '하천 범람',
              items: [
                '범람 시 급속한 수위 상승, 대피 지연',
              ],
            ),
          ],
        ),
        // 3. 행동요령 (TTS 버튼 포함)
        BehaviorTipsSection(
          title: '행동요령',
          subtitle: 'Behavior Tips',
          blocks: [
            SectionBlock(
              title: '홍수 발생 전',
              items: [
                'TV·라디오 통해 기상 정보 확인',
                '집 주변 배수구, 하수구 정리',
                '차량은 고지대로 이동',
                '가전제품, 귀중품은 높은 곳에 보관',
              ],
            ),
            SectionBlock(
              title: '홍수 진행 중',
              items: [
                '침수 도로·지하차도 진입 금지',
                '맨홀, 전봇대, 전기시설 근처 접근 금지',
                '위험 발생 시 119·112 신고',
                '어린이는 절대 밖에 나가지 않도록 지도',
              ],
            ),
            SectionBlock(
              title: '홍수 지나간 후',
              items: [
                '실내외 청소 시 전기 차단 확인',
                '오염된 음식물은 반드시 폐기',
                '수돗물 오염 의심 시 끓여 마시기',
                '손 씻기, 감염병 예방',
              ],
            ),
          ],
          onTtsPressed: _toggleTts,
          isSpeaking: isSpeaking,
        ),
        // 4. 관련 자료
        RelatedMaterialsSection(
          title: '관련 자료',
          subtitle: 'Related Materials',
          cardImageAsset: 'assets/flood_card.png',
          linkTitle: '국민재난안전포털 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent13.html?menuSeq=126',
        ),
      ],
    );
  }
}